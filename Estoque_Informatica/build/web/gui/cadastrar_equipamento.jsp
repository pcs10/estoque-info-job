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
            int idEquipamento = Integer.parseInt(request.getParameter("idEquipamento"));
        
            if (acao.equals("Iniciar") || acao.equals("Editar")) {
                String serialEquipamento = "";
                String descricaoEquipamento = "";
                String aquisicaoEquipamento = "";
                String flDisponivel = "N";
                int idTipoEquipamento = -1;
                if (acao.equals("Editar")){
                    Equipamento e = EquipamentoDAO.retornarObjeto(sessao, idEquipamento);
                    serialEquipamento = e.getSerial();
                    descricaoEquipamento = e.getDescricao();
                    aquisicaoEquipamento = e.getAquisicao();
                    flDisponivel = e.getFlDisponivel();
                    idTipoEquipamento = e.getTipoEquipamento().getId();
                }// if editar
        %>
        <form name="Salvar" action="cadastrar_equipamento.jsp">
            <input type="hidden" name="idEquipamento" value="<%=idEquipamento%>" />
            <p class="text-center tituloFormulario">CADASTRO DE EQUIPAMENTOS</p>
            
            <div class="form-group">
                <label class="control-label">Serial</label>
                <input maxlength="50" type="text" class="form-control" id="serial" name="serial" value="<%=serialEquipamento%>" 
                       placeholder="Digite o serial do equipamento." required/>
            </div>
                    
            <div class="form-group">
                <label class="control-label">Descrição</label>
                <input maxlength="50" type="text" class="form-control" id="descricao" name="descricao" value="<%=descricaoEquipamento%>" 
                       placeholder="Digite a descrição do equipamento." required/>
            </div>
            
            <div class="form-group">
                <label class="control-label">Aquisição</label>
                <input maxlength="20" type="text" class="form-control" id="aquisicao" name="aquisicao" value="<%=aquisicaoEquipamento%>" 
                       placeholder="Informe quando o equipamento foi adquirido" required/>
            </div>
                       
           <div class="form-group">
                <label class="control-label">Disponivel [S/N]</label>
                <input maxlength="1" type="text" class="form-control" id="flDisponivel" name="flDisponivel" value="<%=flDisponivel%>" 
                       placeholder="Equipamento Disponivel?" required/>
            </div>
                       
            <div class="form-group"> 
                <label class="control-label">Tipo de Equipamento</label>
                <select class="form-control" id="idTipoEquipamento" name="idTipoEquipamento" >
                    <%for (TipoEquipamento te : TipoEquipamentoDAO.listar(sessao)) { 
                        if (te.getId() == idTipoEquipamento){ %>
                            <option value="<%=te.getId()%>" selected><%=te.getNome()%></option>    
                      <%}else{ %>
                            <option value="<%=te.getId()%>"><%=te.getNome()%></option>    
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

                String serial = request.getParameter("serial").toUpperCase();
                String descricao = request.getParameter("descricao").toUpperCase();
                String aquisicao = request.getParameter("aquisicao").toUpperCase();
                String flDisponivel = request.getParameter("flDisponivel").toUpperCase();
                int tipoEquipamentoId = Integer.parseInt(request.getParameter("idTipoEquipamento"));

                TipoEquipamento te = TipoEquipamentoDAO.retornarObjeto(sessao, tipoEquipamentoId);

               // out.print("O valor de nome enviado foi: " + serial + "<br>"); 
               // out.print("O valor de estadoId enviado foi: " + tipoEquipamentoId+ "<br>");

                //Cria a instância do POJO
                Equipamento e; 
                
                if(idEquipamento == 0){
                   e = new Equipamento();
                }else{
                    e = EquipamentoDAO.retornarObjeto(sessao, idEquipamento);
                }//else

                //Popula o novo POJO
                e.setSerial(serial);
                e.setDescricao(descricao);                
                e.setTipoEquipamento(te);
                e.setAquisicao(aquisicao);
                e.setFlDisponivel(flDisponivel);

                //Salva no BD
                boolean retorno;
                retorno = EquipamentoDAO.salvar(sessao, e);

                 if (retorno) {%>
                     <p class="text-center avisoSucesso">Equipamento salvo com sucesso!</p>
                     <a href="../gui/cadastrar_equipamento.jsp?acao=Iniciar&idEquipamento=0">Novo Equipamento</a>
                 <%} else {%>
                    <p class="text-center avisoErro">Equipamento não foi salvo com sucesso!</p>
                <%}
               
            }else if (acao.equals("Excluir")) {
            
                Equipamento e = EquipamentoDAO.retornarObjeto(sessao, idEquipamento);
                //Salva no BD
                boolean retorno;
                retorno = EquipamentoDAO.excluir(sessao, e);

                if (retorno) {
                    out.print("Equipamento excluído com sucesso!");
                } else {
                    out.print("Equipamento não foi excluído com sucesso!");
                }//else

            }//else if
        %>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>