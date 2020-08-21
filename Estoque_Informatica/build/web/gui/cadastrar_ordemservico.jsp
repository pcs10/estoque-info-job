<%@page import="java.math.BigDecimal"%>
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
            int idOrdemServico = Integer.parseInt(request.getParameter("idOrdemServico"));
        
            if (acao.equals("Iniciar") || acao.equals("Editar")) {
                String numOrdemServico = "";
                String dataEntrada = "";
                String dataDevolucao = "";
                int idEquipamento = -1; // da chave estrangeira
                String numNfEnvio = "";
                String observacoes = "";
                String servico = "";
                float valor = 0;
                //int idOrdemServico = -1; // da chave estrangeira
                if (acao.equals("Editar")){
                    OrdemServico os = OrdemServicoDAO.retornarObjeto(sessao, idOrdemServico);
                    numOrdemServico = os.getNumOrdemServico();
                    
                    try{
                        dataEntrada = os.getDataEntrada().toString(); //converter campo data em string
                    }catch(Exception ex){
                        out.print("Erro na data de entrada");
                    } //catch
                    
                    try{
                        dataDevolucao = os.getDataDevolucao().toString(); //converter campo data em string
                    }catch(Exception ex){
                        out.print("Erro na data de devolução");
                    } //catch
                    
                    idEquipamento = os.getEquipamento().getId();
                    numNfEnvio = os.getNumNfEnvio();
                    observacoes = os.getObservacoes();
                    servico = os.getServicos();
                    valor = Float.parseFloat(os.getValor().toString());
                    
                }// if editar
        %>
        <form name="Salvar" action="cadastrar_ordemservico.jsp">
            <input type="hidden" name="idOrdemServico" value="<%=idOrdemServico%>" />
            <p class="text-center tituloFormulario">CADASTRO DE ORDEM DE SERVIÇO</p>
            
            <div class="form-group">
                <label class="control-label">Ordem de Serviço</label>
                <input maxlength="1000" type="text" class="form-control" id="numOrdemServico" name="numOrdemServico" value="<%=numOrdemServico%>" 
                       placeholder="Digite o numero da ordem de serviço" required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Data de Entrada</label>
                <input type="text" class="form-control" id="dataEntrada" name="dataEntrada" value="<%=dataEntrada%>" 
                       placeholder="Data entrada" required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Data de Devolução</label>
                <input type="text" class="form-control" id="dataDevolucao" name="dataDevolucao" value="<%=dataDevolucao%>" 
                       placeholder="Data devolução" required/>
            </div>
                       
            <div class="form-group"> 
                <label class="control-label">NF de Envio</label>
                <input maxlength="20" type="text" class="form-control" id="numNfEnvio" name="numNfEnvio" value="<%=numNfEnvio%>" 
                       placeholder="Número da NF de envio" required/>
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
                <label class="control-label">Observações</label>
                <input maxlength="1000" type="text" class="form-control" id="observacoes" name="observacoes" value="<%=observacoes%>" 
                       placeholder="Observações" required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Serviços</label>
                <input maxlength="1000" type="text" class="form-control" id="servico" name="servico" value="<%=servico%>" 
                       placeholder="Serviços feitos" required/>
            </div>
                       
            <div class="form-group">
                <label class="control-label">Valor</label>
                <input maxlength="1000" type="text" class="form-control" id="valor" name="valor" value="<%=valor%>" 
                       placeholder="Valor" required/>
            </div>
                
            <div class="text-center form-group">
                <input type="submit" class="btn btn-primary cor-botoes" value="Salvar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </form>
        <% 
            } else if (acao.equals("Salvar")) {

                String numOrdemServico = request.getParameter("numOrdemServico").toUpperCase();
                String dataEntrada = request.getParameter("dataEntrada").toUpperCase();
                String dataDevolucao = request.getParameter("dataDevolucao").toUpperCase();
                String numNfEnvio = request.getParameter("numNfEnvio").toUpperCase();
                int equipamentoId = Integer.parseInt(request.getParameter("idEquipamento")); // chave estrangeira
                String observacoes = request.getParameter("observacoes").toUpperCase();
                String servico = request.getParameter("servico").toUpperCase();
                float valor = Float.parseFloat(request.getParameter("valor"));

                Equipamento e = EquipamentoDAO.retornarObjeto(sessao, equipamentoId);
                //OrdemServico os = OrdemServicoDAO.retornarObjeto(sessao, equipamentoId);

                //Cria a instância do POJO
                OrdemServico os; 
                
                if(idOrdemServico == 0){
                   os = new OrdemServico();
                }else{
                    os = OrdemServicoDAO.retornarObjeto(sessao, idOrdemServico);
                }//else

                //converto a data de String para Date nesse formato.
                SimpleDateFormat formato1 = new SimpleDateFormat("yyyy-mm-dd");
                Date dataEntradaFormatada = formato1.parse(dataEntrada);

                //converto a data de String para Date nesse formato.
                SimpleDateFormat formato2 = new SimpleDateFormat("yyyy-mm-dd");
                Date dataDevolucaoFormatada = formato2.parse(dataDevolucao);


                //Popula o novo POJO
                os.setNumOrdemServico(numOrdemServico);
                os.setDataEntrada(dataEntradaFormatada);
                os.setDataEntrada(dataDevolucaoFormatada);
                os.setEquipamento(e);
                os.setNumNfEnvio(numNfEnvio);
                os.setObservacoes(observacoes);
                os.setServicos(servico);
                os.setValor(BigDecimal.valueOf(valor)); // trsnsformar float em decimal

                //Salva no BD
                boolean retorno;
                retorno = OrdemServicoDAO.salvar(sessao, os);

                 if (retorno) {%>
                <p class="text-center avisoSucesso">Ordem de Serviço salva com sucesso!</p>
                <a href="../gui/cadastrar_ordemservico.jsp?acao=Iniciar&idOrdemServico=0">Nova Ordem de Serviço</a>
                 <%} else {%>
                <p class="text-center avisoErro">Ordem de Serviço não foi salva com sucesso!</p>
                <%}
               
            }else if (acao.equals("Excluir")) {
                OrdemServico os = OrdemServicoDAO.retornarObjeto(sessao, idOrdemServico);
                //Salva no BD
                boolean retorno;
                retorno = OrdemServicoDAO.excluir(sessao, os);

                if (retorno) {
                    out.print("Ordem de Serviço excluída com sucesso!");
                } else {
                    out.print("Ordem de Serviço não foi excluída com sucesso!");
                }//else
            }//else if
        %>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>