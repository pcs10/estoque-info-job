package dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pojos.TipoEquipamento;

public class TipoEquipamentoDAO {

    public static TipoEquipamento retornarObjeto(Session sessao, int id) {
        Query q = null;
        List<TipoEquipamento> lista = null;
        try {
            String HQL = "FROM TipoEquipamento obj WHERE obj.id = " + id;
            q = sessao.createQuery(HQL); 
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return (lista.get(0));
    }

    public static List<TipoEquipamento> listar(Session sessao) {
        Query q = null;
        List<TipoEquipamento> lista = null;
        try {
            String HQL = "FROM TipoEquipamento obj ORDER BY obj.nome ASC";
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }
    
    public static List<TipoEquipamento> listar(Session sessao, String valor) {
        Query q = null;
        List<TipoEquipamento> lista = null;
        try {
            String HQL = "FROM TipoEquipamento obj WHERE obj.nome LIKE '%" + valor + "%' ORDER BY obj.nome ASC";
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }

    public static boolean salvar(Session s, TipoEquipamento obj) {
        boolean sucesso = true;
        try {
            s.saveOrUpdate(obj);
            s.flush();
        } catch (HibernateException ex) {
            sucesso = false;
            System.out.println("Erro:" + ex.getMessage());
        } finally {
            return (sucesso);
        }
    }

    public static boolean excluir(Session s, TipoEquipamento obj) {
        boolean sucesso = true;
        try {
            s.delete(obj);
            s.flush();
        } catch (HibernateException ex) {
            sucesso = false;
            System.out.println("Erro:" + ex.getMessage());
        } finally {
            return (sucesso);
        }
    }
}
