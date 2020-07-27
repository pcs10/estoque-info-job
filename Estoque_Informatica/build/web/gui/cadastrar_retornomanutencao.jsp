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
                int equipamentoId = -1;
                int ordemServicoId = -1;
                
               // int manutencaoId = -1;
                if (acao.equals("Editar")){
                    RetornoManutencao rm = RetornoManutencaoDAO.retornarObjeto(sessao, idRetornoManutencao);
                    laudoRetornoManutencao = rm.getLaudoRetorno();
                    dataRetornoManutencao = rm.getDataRetorno().toString();
                    equipamentoId = rm.getEquipamento().getId();
                    ordemServicoId = rm.getOrdemServico().getId();
                   // manutencaoId = rm.getManutencao().getId();
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
                <label class="control-label">Saida pra manutenção</label>
                <select class="form-control" id="manutencaoId" name="manutencaoId" >
                    <%for (Equipamento m : EquipamentoDAO.listar(sessao)) { 
                        if (m.getId() == equipamentoId){ %>
                            <option value="<%=m.getId()%>" selected><%="["+ m.getEquipamento().getTipoEquipamento().getNome() + " - " + m.getEquipamento().getSerial() + "] - " +  m.getDataSaida()%></option>    
                      <%}else{ %>
                            <option value="<%=m.getId()%>"><%="[" + m.getEquipamento().getTipoEquipamento().getNome() + " - " +  m.getEquipamento().getSerial() + "] - " +  m.getDataSaida()%></option>    
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

                String laudoRetorno = request.getParameter("laudoRetorno").toUpperCase();
                String dataRetorno = request.getParameter("dataRetorno").toUpperCase();
                int manutencaoId = Integer.parseInt(request.getParameter("manutencaoId"));

                Manutencao m = ManutencaoDAO.retornarObjeto(sessao, manutencaoId);

               // out.print("O valor de nome enviado foi: " + serial + "<br>"); 
               // out.print("O valor de estadoId enviado foi: " + tipoEquipamentoId+ "<br>");

                //Cria a instância do POJO
                RetornoManutencao rm; 
                
                if(idRetornoManutencao == 0){
                   rm = new RetornoManutencao();
                }else{
                    rm = RetornoManutencaoDAO.retornarObjeto(sessao, idRetornoManutencao);
                }//else

                //Popula o novo POJO
                rm.setLaudoRetorno(laudoRetorno);
                rm.setDataRetorno(dataRetorno);                
                rm.setManutencao(m);

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