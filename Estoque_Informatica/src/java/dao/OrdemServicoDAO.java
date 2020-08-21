package dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import pojos.OrdemServico;

public class OrdemServicoDAO {

    public static OrdemServico retornarObjeto(Session sessao, int id) {
        Query q = null;
        List<OrdemServico> lista = null;
        try {
            String HQL = "FROM OrdemServico obj WHERE obj.id = " + id;
            q = sessao.createQuery(HQL); 
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return (lista.get(0));
    }

    public static List<OrdemServico> listar(Session sessao) {
        Query q = null;
        List<OrdemServico> lista = null;
        try {
            //String HQL = "FROM OrdemServico obj ORDER BY obj.id ASC";
            String HQL = "FROM OrdemServico obj ORDER BY obj.numOrdemServico"; // primeiro tabela  (classe) e depois o campo (que ta minusculo             
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }
    
    public static List<OrdemServico> listar(Session sessao, String valor) {
        Query q = null;
        List<OrdemServico> lista = null;
        try {
            //String HQL = "FROM OrdemServico obj WHERE obj.nome LIKE '%" + valor + "%' ORDER BY obj.nome ASC";
            String HQL = "FROM OrdemServico obj WHERE obj.numOrdemServico LIKE '%" + valor + "%' ORDER BY obj.id ASC";
            q = sessao.createQuery(HQL);
            lista = q.list();
            sessao.flush();
        } catch (HibernateException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return (lista);
    }

    public static boolean salvar(Session s, OrdemServico obj) {
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

    public static boolean excluir(Session s, OrdemServico obj) {
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
