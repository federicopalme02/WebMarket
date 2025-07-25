package it.univaq.f4i.iw.ex.webmarket.data.model;


import java.util.Date;

import it.univaq.f4i.iw.ex.webmarket.data.model.impl.StatoOrdine;
import it.univaq.f4i.iw.framework.data.DataItem;


public interface Ordine extends DataItem<Integer> {
  
    int getId();
    void setId(int id);

    StatoOrdine getStato ();
    void setStato(StatoOrdine stato);
    
    Proposta getProposta();
    void setProposta(Proposta proposta);

    Date getData ();
    void setData(Date data);
}