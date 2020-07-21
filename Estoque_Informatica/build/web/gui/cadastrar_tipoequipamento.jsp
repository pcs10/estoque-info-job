<%
    HttpSession sessaoHTTP = request.getSession();
    if (!sessaoHTTP.getId().equals(sessaoHTTP.getAttribute("idSessao"))) {
        response.sendRedirect("login.jsp?acao=SemLogin");
    } else { %>

<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

        <%
            Session sessao = HibernateUtil.getSessionFactory().openSession();
            String acao = request.getParameter("acao");
            int idTipoEquipamento = Integer.parseInt(request.getParameter("idTipoEquipamento"));
            
            if (acao.equals("Iniciar") || acao.equals("Editar")) {
                String nomeTipoEquipamento = "";

                if (acao.equals("Editar")){
                    TipoEquipamento te = TipoEquipamentoDAO.retornarObjeto(sessao, idTipoEquipamento);
                    nomeTipoEquipamento = te.getNome();
                }//if
        %>
            <form name="Salvar" action="cadastrar_tipoequipamento.jsp">
                <input type="hidden" name="idTipoEquipamento" value="<%=idTipoEquipamento%>" />
                
                <p class="text-center tituloFormulario">CADASTRO DOS TIPOS DE EQUIPAMENTOS</p>
                
                <div class="form-group">
                    <label class="control-label">Nome</label>
                    <input maxlength="50" type="text" class="form-control" id="nome" name="nome" value="<%=nomeTipoEquipamento%>" 
                           placeholder="Digite o nome do Tipo de Equipamento." required/>
                </div>
                
                <div class="text-center form-group">
                    <input type="submit" class="btn btn-primary cor-botoes" value="Salvar" id="acao" name="acao"/>
                    <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
                </div>
            </form>
                           
        <% } else if (acao.equals("Salvar")) {

            String nome = request.getParameter("nome").toUpperCase();

            //Cria a instância do POJO
            TipoEquipamento te;    
            
            if (idTipoEquipamento == 0 ){
                te = new TipoEquipamento();
            } else  {
                te = TipoEquipamentoDAO.retornarObjeto(sessao, idTipoEquipamento);
            }
            
            //Popula o POJO
            te.setNome(nome);

            //Salva no BD
            boolean retorno;
            retorno = TipoEquipamentoDAO.salvar(sessao, te);

            if (retorno) {%>
                <p class="text-center avisoSucesso">Tipo de equipamento salvo com sucesso!</p>
                <a href="../gui/cadastrar_tipoequipamento.jsp?acao=Iniciar&idTipoEquipamento=0">Novo Tipo de equipamento</a>
            <%} else {%>
                <p class="text-center avisoErro">Tipo de equipamento não foi salvo com sucesso!</p>
            <%}
        } else if (acao.equals("Excluir")) {
            
            TipoEquipamento e = TipoEquipamentoDAO.retornarObjeto(sessao, idTipoEquipamento);
            //Salva no BD
            boolean retorno;
            retorno = TipoEquipamentoDAO.excluir(sessao, e);

            if (retorno) {
                out.print("Tipo de Equipamento excluído com sucesso!");
            } else {
                out.print("Tipo de Equipamento não foi excluído com sucesso!");
            }

        }%>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>