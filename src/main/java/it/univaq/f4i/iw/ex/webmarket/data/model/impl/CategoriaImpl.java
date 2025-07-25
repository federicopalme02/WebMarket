package it.univaq.f4i.iw.ex.webmarket.data.model.impl;

import it.univaq.f4i.iw.ex.webmarket.data.model.Caratteristica;
import it.univaq.f4i.iw.ex.webmarket.data.model.Categoria;
import it.univaq.f4i.iw.framework.data.DataItemImpl;
import java.util.List;


public class CategoriaImpl extends DataItemImpl<Integer> implements Categoria {

    private String nome;
    private Integer padre;
    private List<Caratteristica> caratteristiche;


    public CategoriaImpl() {
        super();
        nome = "";
        padre = null;
    }

    public CategoriaImpl(String nome, int padre) {
        this.nome= nome;
        this.padre= padre;
    }

    @Override
    public int getId() {
        return this.getKey();
    }

    @Override
    public void setId(int id) {
        this.setKey(id);
    }

    @Override
    public String getNome() {
        return nome;
    }

    @Override
    public void setNome(String nome) {
        this.nome= nome;
    }

    @Override
    public int getPadre() {
        return padre;
    }

    @Override
    public void setPadre(int padre) {
        this.padre = padre;
    }

    @Override
    public List<Caratteristica> getCaratteristiche() {
        return caratteristiche;
    }

    @Override
    public void setCaratteristiche(List<Caratteristica> caratteristiche) {
        this.caratteristiche = caratteristiche;
    }
}