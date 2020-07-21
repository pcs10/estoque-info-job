package dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pojos.RetornoManutencao;

public class RetornoManutencaoDAO {

    public static RetornoManutencao retornarObjeto(Session sessao, int id) {
        Query q = null;
        List<RetornoManutencao> lista = null;
        try {
            String HQL = "FROM RetornoManutencao obj WHERE obj.id = " + id;
            q = sessao.createQuery(HQL); 
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return (lista.get(0));
    }

    public static List<RetornoManutencao> listar(Session sessao) {
        Query q = null;
        List<RetornoManutencao> lista = null;
        try {
            //String HQL = "FROM RetornoManutencao obj ORDER BY obj.nome ASC"; 
            String HQL = "FROM RetornoManutencao obj ORDER BY obj.id ASC"; 
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }
    
    public static List<RetornoManutencao> listar(Session sessao, String valor) {
        Query q = null;
        List<RetornoManutencao> lista = null;
        try {
            //String HQL = "FROM RetornoManutencao obj WHERE obj.nome LIKE '%" + valor + "%' ORDER BY obj.nome ASC";
            String HQL = "FROM RetornoManutencao obj WHERE obj.laudoRetorno LIKE '%" + valor + "%' ORDER BY obj.id ASC";
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }

    public static boolean salvar(Session s, RetornoManutencao obj) {
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

    public static boolean excluir(Session s, RetornoManutencao obj) {
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
