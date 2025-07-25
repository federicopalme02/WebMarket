package it.univaq.f4i.iw.ex.webmarket.controller;

import it.univaq.f4i.iw.ex.webmarket.data.dao.impl.ApplicationDataLayer;
import it.univaq.f4i.iw.ex.webmarket.data.model.Utente;
import it.univaq.f4i.iw.ex.webmarket.data.model.TipologiaUtente;
import it.univaq.f4i.iw.framework.data.DataException;
import it.univaq.f4i.iw.framework.result.TemplateManagerException;
import it.univaq.f4i.iw.framework.result.TemplateResult;
import it.univaq.f4i.iw.framework.security.SecurityHelpers;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Impostazioni extends BaseController {

    private void action_default(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException, ServletException, TemplateManagerException, DataException {
        TemplateResult res = new TemplateResult(getServletContext());
        Utente u = ((ApplicationDataLayer) request.getAttribute("datalayer")).getUtenteDAO().getUtente(userId);
        request.setAttribute("user", u);
        String tipologia = u.getTipologiaUtente().toString();
        request.setAttribute("utente", u);
        request.setAttribute("tipologia", tipologia);
        request.setAttribute("page_title", "impostazioni");
        request.setAttribute("user_type", u.getTipologiaUtente().toString());
        res.activate("impostazioniAccount.ftl.html", request, response);
    }
    
    private void action_update(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException, ServletException, TemplateManagerException, DataException, NoSuchAlgorithmException, InvalidKeySpecException {
         
        String current = request.getParameter("current-password");
        String newP = request.getParameter("new-password");
        String confirm = request.getParameter("confirm-password");
        
        
        if (current == null || current.trim().isEmpty() || newP == null || newP.trim().isEmpty()||confirm == null || confirm.trim().isEmpty()) {
            request.setAttribute("errore", "Tutti i campi devono essere compilati!");
            action_default(request, response, userId);
            return; 
        }
        
        
        if (!newP.equals(confirm)) {
        request.setAttribute("errore", "Le password non coincidono.");
        action_default(request, response, userId);
        return;

        }
        
        Utente u = ((ApplicationDataLayer) request.getAttribute("datalayer")).getUtenteDAO().getUtente(userId);
        
        //controllo su passwrod vecchia
        if (!SecurityHelpers.checkPasswordHashPBKDF2(current, u.getPassword())){
          request.setAttribute("errore", "La password vecchia è errata");
          action_default(request, response, userId);
          return;  
        }
        
        String hashedPass = SecurityHelpers.getPasswordHashPBKDF2(newP);
        u.setPassword(hashedPass);
        ((ApplicationDataLayer) request.getAttribute("datalayer")).getUtenteDAO().storeUtente(u);
        
        if (u.getTipologiaUtente().equals(TipologiaUtente.ORDINANTE)) {
            response.sendRedirect("impostazioni?success=true");
            
        } else if (u.getTipologiaUtente().equals(TipologiaUtente.TECNICO)) {
            response.sendRedirect("impostazioni?success=true");
        }
    }

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException {
    try {
        HttpSession session = SecurityHelpers.checkSession(request);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        
        int userId = (int) session.getAttribute("userid");
        Utente u = ((ApplicationDataLayer) request.getAttribute("datalayer")).getUtenteDAO().getUtente(userId);

        String action = request.getParameter("action");
        if (action != null && action.equals("updatePassword")){
            action_update(request, response, userId);
        }else{
            action_default(request, response, userId);
        }
        

    } catch (IOException | TemplateManagerException /* | DataException */ ex) {
        handleError(ex, request, response);
    }   catch (DataException ex) {
            Logger.getLogger(Impostazioni.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Impostazioni.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeySpecException ex) {
            Logger.getLogger(Impostazioni.class.getName()).log(Level.SEVERE, null, ex);
        }
}


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "impostazioni servlet";
    }

}
