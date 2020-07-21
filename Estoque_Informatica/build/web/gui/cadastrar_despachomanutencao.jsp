<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
            int idDespachoManutencao = Integer.parseInt(request.getParameter("idDespachoManutencao"));
        
            if (acao.equals("Iniciar") || acao.equals("Editar")) {
                String defeitoManutencao = "";
                Date dataSaidaDespachoManutencao;
                String dataSaida = "";
                String ultimaManutencao = "";
                int idEquipamento = -1; // da chave estrangeira
                if (acao.equals("Editar")){
                    DespachoManutencao dm = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                    defeitoManutencao = dm.getDefeito();
                    dataSaidaDespachoManutencao = dm.getDataSaida();
                    
                    ultimaManutencao = dm.getUltimaManutencao();
                    idEquipamento = dm.getEquipamento().getId();
                }// if editar
        %>
        <form name="Salvar" action="cadastrar_manutencao.jsp">
            <input type="hidden" name="idDespachoManutencao" value="<%=idDespachoManutencao%>" />
            <p class="text-center tituloFormulario">CADASTRO DE MANUTENÇÕES</p>
            
            <div class="form-group">
                <label class="control-label">Defeito</label>
                <input maxlength="1000" type="text" class="form-control" id="defeito" name="defeito" value="<%=defeitoManutencao%>" 
                       placeholder="Digite o defeito do equipamento." required/>
            </div>
                 
            <div class="form-group">
                <label class="control-label">Data de saída</label>
                <input type="date" class="form-control" id="dataSaida" name="dataSaida" value="<%=dataSaidaDespachoManutencao%>" 
                       placeholder="Data de saída para manutenção." required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Ultima manutenção</label>
                <input maxlength="20" type="text" class="form-control" id="ultimaManutencao" name="ultimaManutencao" value="<%=ultimaManutencao%>" 
                       placeholder="Última manutenção." required/>
            </div>
            
            <div class="form-group"> 
                <label class="control-label">Equipamento</label>
                <select class="form-control" id="idEquipamento" name="idEquipamento" >
                    <%for (Equipamento e : EquipamentoDAO.listar(sessao)) { 
                        if (e.getId() == idEquipamento){ %>
                            <option value="<%=e.getId()%>" selected><%="[" + e.getTipoEquipamento().getNome() + "] - " + e.getSerial()%></option>    
                      <%}else{ %>
                            <option value="<%=e.getId()%>"><%="[" +e.getTipoEquipamento().getNome() + "] - " + e.getSerial()%></option>    
                      <%} //else
                    }// for
                 %>
                </select>
            </div>
                
            <div class="text-center form-group">
                <input type="submit" class="btn btn-primary cor-botoes" value="Salvar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </form>
        <% 
            } else if (acao.equals("Salvar")) {

                String defeito = request.getParameter("defeito").toUpperCase();
                String dataSaida = request.getParameter("dataSaida").toUpperCase();
                String ultimaManutencao = request.getParameter("ultimaManutencao").toUpperCase();
                int equipamentoId = Integer.parseInt(request.getParameter("idEquipamento"));

                Equipamento e = EquipamentoDAO.retornarObjeto(sessao, equipamentoId);

               // out.print("O valor de nome enviado foi: " + serial + "<br>"); 
               // out.print("O valor de estadoId enviado foi: " + tipoEquipamentoId+ "<br>");

                //Cria a instância do POJO
                DespachoManutencao m; 
                
                if(idDespachoManutencao == 0){
                   m = new DespachoManutencao();
                }else{
                    m = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                }//else

                //Popula o novo POJO
                m.setDefeito(defeito);
               // m.setDataSaida(dataSaida);                
                m.setUltimaManutencao(ultimaManutencao);
                m.setEquipamento(e);

                //Salva no BD
                boolean retorno;
                retorno = DespachoManutencaoDAO.salvar(sessao, m);

                 if (retorno) {%>
                <p class="text-center avisoSucesso">Manutenção salva com sucesso!</p>
                <a href="../gui/cadastrar_manutencao.jsp?acao=Iniciar&idManutencao=0">Nova manutenção</a>
                 <%} else {%>
                <p class="text-center avisoErro">Manutenção não foi salva com sucesso!</p>
                <%}
               
            }else if (acao.equals("Excluir")) {
            
                DespachoManutencao m = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                //Salva no BD
                boolean retorno;
                retorno = DespachoManutencaoDAO.excluir(sessao, m);

                if (retorno) {
                    out.print("Manutenção excluída com sucesso!");
                } else {
                    out.print("Manutenção não foi excluída com sucesso!");
                }//else

            }//else if
        %>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>