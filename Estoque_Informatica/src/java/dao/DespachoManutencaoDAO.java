package dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pojos.DespachoManutencao;

public class DespachoManutencaoDAO {

    public static DespachoManutencao retornarObjeto(Session sessao, int id) {
        Query q = null;
        List<DespachoManutencao> lista = null;
        try {
            String HQL = "FROM DespachoManutencao obj WHERE obj.id = " + id;
            q = sessao.createQuery(HQL); 
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return (lista.get(0));
    }

    public static List<DespachoManutencao> listar(Session sessao) {
        Query q = null;
        List<DespachoManutencao> lista = null;
        try {
            //String HQL = "FROM DespachoManutencao obj ORDER BY obj.nome ASC"; 
            String HQL = "FROM DespachoManutencao obj ORDER BY obj.id ASC"; 
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }
    
    public static List<DespachoManutencao> listar(Session sessao, String valor) {
        Query q = null;
        List<DespachoManutencao> lista = null;
        try {
            //String HQL = "FROM DespachoManutencao obj WHERE obj.nome LIKE '%" + valor + "%' ORDER BY obj.nome ASC";
            String HQL = "FROM DespachoManutencao obj WHERE obj.defeito LIKE '%" + valor + "%' ORDER BY obj.id ASC";
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }

    public static boolean salvar(Session s, DespachoManutencao obj) {
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

    public static boolean excluir(Session s, DespachoManutencao obj) {
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
