package it.univaq.f4i.iw.ex.webmarket.data.model;

import it.univaq.f4i.iw.framework.data.DataItem;


public interface Utente extends DataItem<Integer> {

    int getId();

    void setId(int id);
    
    String getUsername();
    
    void setUsername(String username);

    String getEmail();

    void setEmail(String email);

    String getPassword();

    void setPassword(String password);

    TipologiaUtente getTipologiaUtente();

    void setTipologiaUtente(TipologiaUtente tipologia);
}
