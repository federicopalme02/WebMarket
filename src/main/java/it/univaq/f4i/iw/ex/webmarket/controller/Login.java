package it.univaq.f4i.iw.ex.webmarket.controller;

import it.univaq.f4i.iw.ex.webmarket.data.dao.impl.ApplicationDataLayer;
import it.univaq.f4i.iw.ex.webmarket.data.model.Utente;
import it.univaq.f4i.iw.framework.data.DataException;
import it.univaq.f4i.iw.framework.result.TemplateManagerException;
import it.univaq.f4i.iw.framework.result.TemplateResult;
import it.univaq.f4i.iw.framework.security.SecurityHelpers;
import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.http.*;


public class Login extends BaseController {

    private void action_default(HttpServletRequest request, HttpServletResponse response) throws IOException, TemplateManagerException {
        TemplateResult result = new TemplateResult(getServletContext());
        request.setAttribute("referrer", request.getParameter("referrer"));
        request.setAttribute("pageName", "login"); // Imposta pageName per Freemarker
        result.activate("login.ftl.html", request, response);
       
    }

    private void action_login(HttpServletRequest request, HttpServletResponse response) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException, TemplateManagerException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (!username.isEmpty() && !password.isEmpty()) {
            try {
                
                System.out.println("ciao "+username);
                
                Utente u = ((ApplicationDataLayer) request.getAttribute("datalayer")).getUtenteDAO().getUtenteByUsername(username);
                
               if (u != null && SecurityHelpers.checkPasswordHashPBKDF2(password, u.getPassword())) {
                
                    SecurityHelpers.createSession(request, username, u.getKey(), u.getTipologiaUtente());
           
                    String redirectPage;
                    redirectPage = switch (u.getTipologiaUtente()) {
    
                        case ORDINANTE -> "home";
                        case TECNICO -> "home";
                        case AMMINISTRATORE -> "homeAdmin";
                        default -> "login";
                    };
                    
                    String referrer = request.getParameter("referrer");
                 

                if (referrer != null && SecurityHelpers.accessControl(referrer, u.getTipologiaUtente().toString())) {
                        response.sendRedirect(referrer);

                    } else if (referrer != null) {
                        
                        response.sendRedirect(redirectPage);
                    }else {
                        response.sendRedirect(redirectPage);
                    }
                    return;
                } else{
                    request.setAttribute("error", "Username o password non corretti");
                    action_default(request, response);

               }
            } catch (DataException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
        //se la validazione fallisce...
        //if the validation fails...
        //request.setAttribute("error", "Email o password non corretti");
        //handleError("Login failed", request, response);
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        try {

            if (request.getParameter("login") != null) {
                action_login(request, response);
            } else {
                String https_redirect_url = SecurityHelpers.checkHttps(request);
                request.setAttribute("https-redirect", https_redirect_url);
                action_default(request, response);
            }
        } catch (IOException | TemplateManagerException ex) {
            handleError(ex, request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
