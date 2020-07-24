<%@page import="java.text.SimpleDateFormat"%>
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
                String dataSaida = "";
                String ultimaManutencao = "";
                int idEquipamento = -1; // da chave estrangeira
                int idOrdemServico = -1; // da chave estrangeira
                if (acao.equals("Editar")){
                    DespachoManutencao dm = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                    defeitoManutencao = dm.getDefeito();
                    
                    Date dataTemp = dm.getDataSaida();
                    
                    
                    
                  
                  
                    ultimaManutencao = dm.getUltimaManutencao();
                    idEquipamento = dm.getEquipamento().getId();
                    idOrdemServico = dm.getOrdemServico().getId(); //pegar id da ordem de servico
                }// if editar
        %>
        <form name="Salvar" action="cadastrar_despachomanutencao.jsp">
            <input type="hidden" name="idDespachoManutencao" value="<%=idDespachoManutencao%>" />
            <p class="text-center tituloFormulario">CADASTRO DE MANUTENÇÕES</p>
            
            <div class="form-group">
                <label class="control-label">Defeito</label>
                <input maxlength="1000" type="text" class="form-control" id="defeito" name="defeito" value="<%=defeitoManutencao%>" 
                       placeholder="Digite o defeito do equipamento." required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Data de saída</label>
                <input type="text" class="form-control" id="dataSaida" name="dataSaida" value="<%=dataSaida%>" 
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
                
            <div class="form-group"> 
                <label class="control-label">Ordem de Serviço</label>
                <select class="form-control" id="idOrdemServico" name="idOrdemServico" >
                    <%for (OrdemServico os : OrdemServicoDAO.listar(sessao)) { 
                        if (os.getId() == idOrdemServico){ %>
                            <option value="<%=os.getId()%>" selected><%=os.getOrdemServico()%></option>    
                      <%}else{ %>
                            <option value="<%=os.getId()%>"><%=os.getOrdemServico()%></option>    
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
                int ordemServicoId = Integer.parseInt(request.getParameter("idOrdemServico"));

                Equipamento e = EquipamentoDAO.retornarObjeto(sessao, equipamentoId);
                OrdemServico os = OrdemServicoDAO.retornarObjeto(sessao, equipamentoId);

                //Cria a instância do POJO
                DespachoManutencao dm; 
                
                if(idDespachoManutencao == 0){
                   dm = new DespachoManutencao();
                }else{
                    dm = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                }//else

                SimpleDateFormat formato = new SimpleDateFormat("yyyy-mm-dd");
                Date dataFormatada = formato.parse(dataSaida);

                //Popula o novo POJO
                dm.setDefeito(defeito);
                dm.setDataSaida(dataFormatada);                
                dm.setUltimaManutencao(ultimaManutencao);
                dm.setEquipamento(e);
                dm.setOrdemServico(os);
                

                //Salva no BD
                boolean retorno;
                retorno = DespachoManutencaoDAO.salvar(sessao, dm);

                 if (retorno) {%>
                <p class="text-center avisoSucesso">Manutenção salva com sucesso!</p>
                <a href="../gui/cadastrar_despachomanutencao.jsp?acao=Iniciar&idManutencao=0">Nova manutenção</a>
                 <%} else {%>
                <p class="text-center avisoErro">Manutenção não foi salva com sucesso!</p>
                <%}
               
            }else if (acao.equals("Excluir")) {
                DespachoManutencao dm = DespachoManutencaoDAO.retornarObjeto(sessao, idDespachoManutencao);
                //Salva no BD
                boolean retorno;
                retorno = DespachoManutencaoDAO.excluir(sessao, dm);

                if (retorno) {
                    out.print("Despacho de Manutenção excluída com sucesso!");
                } else {
                    out.print("Despacho de Manutenção não foi excluída com sucesso!");
                }//else
            }//else if
        %>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>