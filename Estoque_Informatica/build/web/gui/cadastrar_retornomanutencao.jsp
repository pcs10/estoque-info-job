<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            int idRetornoManutencao = Integer.parseInt(request.getParameter("idRetornoManutencao"));
        
            if (acao.equals("Iniciar") || acao.equals("Editar")) {
                String laudoRetornoManutencao = "";
                String dataRetornoManutencao = "";
                int idEquipamento = -1; // da chave estrangeira
                int idOrdemServico = -1; // da chave estrangeira
                
               // int manutencaoId = -1;
                if (acao.equals("Editar")){
                    RetornoManutencao rm = RetornoManutencaoDAO.retornarObjeto(sessao, idRetornoManutencao);
                    laudoRetornoManutencao = rm.getLaudoRetorno();
                    dataRetornoManutencao = rm.getDataRetorno().toString();
                    idEquipamento = rm.getEquipamento().getId();
                    idOrdemServico = rm.getOrdemServico().getId();
                }// if editar
        %>
        <form name="Salvar" action="cadastrar_retornomanutencao.jsp">
            <input type="hidden" name="idRetornoManutencao" value="<%=idRetornoManutencao%>" />
            <p class="text-center tituloFormulario">CADASTRAR RETORNO DA MANUTENÇÃO</p>
            
            <div class="form-group">
                <label class="control-label">Laudo retorno</label>
                <input maxlength="1000" type="text" class="form-control" id="laudoRetorno" name="laudoRetorno" value="<%=laudoRetornoManutencao%>" 
                       placeholder="Laudo de retorno do equipamento." required/>
            </div>
                    
            <div class="form-group">
                <label class="control-label">Data de retorno</label>
                <input maxlength="10" type="text" class="form-control" id="dataRetorno" name="dataRetorno" value="<%=dataRetornoManutencao%>" 
                       placeholder="Data de retorno do equipamento." required/>
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
                
            <div class="form-group">
                <label class="control-label">Ordem de Serviço</label>
                <input maxlength="1000" type="text" class="form-control" id="idOrdemServico" name="idOrdemServico" value="<%=idOrdemServico%>" 
                       placeholder="Digite a Ordem de Serviço" required/>
            </div>
                
            <div class="text-center form-group">
                <input type="submit" class="btn btn-primary cor-botoes" value="Salvar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </form>
        <% 
            } else if (acao.equals("Salvar")) {

                String laudoRetorno = request.getParameter("laudoRetorno").toUpperCase();
                String dataRetorno = request.getParameter("dataRetorno").toUpperCase();
                int equipamentoId = Integer.parseInt(request.getParameter("idEquipamento"));
              //  int ordemServicoId = Integer.parseInt(request.getParameter("idOrdemServico"));

                Equipamento e = EquipamentoDAO.retornarObjeto(sessao, equipamentoId);
                //OrdemServico os = OrdemServicoDAO.retornarObjeto(sessao, equipamentoId);

                //Cria a instância do POJO
                RetornoManutencao rm; 
                
                if(idRetornoManutencao == 0){
                   rm = new RetornoManutencao();
                }else{
                    rm = RetornoManutencaoDAO.retornarObjeto(sessao, idRetornoManutencao);
                }//else

                //converto a data de String para Date nesse formato.
                SimpleDateFormat formato = new SimpleDateFormat("yyyy-mm-dd");
                Date dataFormatada = formato.parse(dataRetorno);

                //Popula o novo POJO
                rm.setLaudoRetorno(laudoRetorno);
                rm.setDataRetorno(dataFormatada);                
                rm.setEquipamento(e);
               // rm.setOrdemServico(os);

                //Salva no BD
                boolean retorno;
                retorno = RetornoManutencaoDAO.salvar(sessao, rm);

                 if (retorno) {%>
                <p class="text-center avisoSucesso">Retorno salvo com sucesso!</p>
                <a href="../gui/cadastrar_retornomanutencao.jsp?acao=Iniciar&idRetornoManutencao=0">Novo retono da manutenção</a>
                 <%} else {%>
                <p class="text-center avisoErro">Retorno não foi salvo com sucesso!</p>
                <%}
               
            }else if (acao.equals("Excluir")) {
            
                RetornoManutencao rm = RetornoManutencaoDAO.retornarObjeto(sessao, idRetornoManutencao);
                //Salva no BD
                boolean retorno;
                retorno = RetornoManutencaoDAO.excluir(sessao, rm);

                if (retorno) {
                    out.print("Retorno excluído com sucesso!");
                } else {
                    out.print("Retorno não foi excluído com sucesso!");
                }//else

            }//else if
        %>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>