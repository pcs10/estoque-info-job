<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="util.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page language="java" import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Session sessao = HibernateUtil.getSessionFactory().openSession();
    
    String valor = request.getParameter("valor");
    String objeto = request.getParameter("objeto");

%>

    <% if (objeto.equals("TipoEquipamento")) { 
        List<TipoEquipamento> lista = TipoEquipamentoDAO.listar(sessao, valor); %>
        
        <div class="text-center form-group">
            <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('nomeTipoEquipamento').value, 'TipoEquipamento')" value="Pesquisar" id="acao" name="acao"/>
            <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            <%if (!lista.isEmpty()){ %>
                <input type="submit" class="btn btn-primary cor-botoes" value="Imprimir" id="acao" name="acao"/>
            <%}%>
        </div>

        <%if (lista.isEmpty()){ %>
            <p class="text-center avisoErro">
                Nenhum registro encontrado.
            <p>        
        <% } else { %>
            <input type="hidden" id="tipo" name="tipo" value="TipoEquipamento" />
            
            <table class="table-striped table-bordered" width="100%">
                <thead>
                    <tr align="center">
                        <td>Ord.</td>
                        <td>Tipo de Equipamento</td>
                    </tr>
                </thead>
                <tbody > 
                    <% int i = 1; 
                        for(TipoEquipamento te : lista){ %>
                        <tr class="resultadosTabelaPesquisar" align="center">
                            <td><%out.print(i++);%></td>
                            <td><%out.print(te.getNome());%></td>
                            <td id="linhaIcones"><a class="btn-sm btn-danger glyphicon glyphicon-trash" onclick="return confirmarExcluir()"  
                                   href="cadastrar_tipoequipamento.jsp?acao=Excluir&idTipoEquipamento=<%=te.getId()%>"></a></td>
                            <td id="linhaIcones"><a class="btn-sm btn-warning glyphicon glyphicon-edit " 
                               href="cadastrar_tipoequipamento.jsp?acao=Editar&idTipoEquipamento=<%=te.getId()%>"></a></td>
                             <td id="linhaIcones"><a class="btn-sm btn-primary glyphicon glyphicon-print not-active"
                               href="teste.jsp?acao=Editar&idTipoEquipamento=<%=te.getId()%>"></a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%}
    } else if (objeto.equals("Equipamento")) { 
        List<Equipamento> lista = EquipamentoDAO.listar(sessao, valor); %>
        
        <div class="text-center form-group">
            <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('serialEquipamento').value, 'Equipamento')" value="Pesquisar" id="acao" name="acao"/>
            <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            <%if (!lista.isEmpty()){ %>
                <input type="submit" class="btn btn-primary cor-botoes" value="Imprimir" id="acao" name="acao"/>
            <%}%>
        </div>

        <%if (lista.isEmpty()){ %>
            <p class="text-center avisoErro">
                Nenhum registro encontrado.
            <p>        
        <% } else { %>
            <input type="hidden" id="tipo" name="tipo" value="Equipamento" />
            
            <table class="table-striped table-bordered" width="100%">
                <thead>
                    <tr align="center">
                        <td>Ord.</td>
                        <td>Serial</td>
                        <td>Descrição</td>
                        <td>Aquisição</td>
                        <td>Disponível</td>
                        <td>Tp. Equi.</td>
                    </tr>
                </thead>
                <tbody> 
                    <% int i = 1; 
                        for(Equipamento e : lista){ %>
                        <tr class="resultadosTabelaPesquisar" align="center">
                            <td><%out.print(i++);%></td>
                            <td><%out.print(e.getSerial());%></td>
                            <td><%out.print(e.getDescricao());%></td>
                            <td><%out.print(e.getAquisicao());%></td>
                            <td><%out.print(e.getFlDisponivel());%></td>
                            <td><%out.print(e.getTipoEquipamento().getNome());%></td>
                            <td id="linhaIcones"><a class="btn-sm btn-danger glyphicon glyphicon-trash" onclick="return confirmarExcluir()"   
                                   href="cadastrar_equipamento.jsp?acao=Excluir&idEquipamento=<%=e.getId()%>"></a></td>
                            <td id="linhaIcones"><a class="btn-sm btn-warning glyphicon glyphicon-edit " 
                               href="cadastrar_equipamento.jsp?acao=Editar&idEquipamento=<%=e.getId()%>"></a></td>
                             <td id="linhaIcones"><a class="btn-sm btn-primary glyphicon glyphicon-print not-active" 
                               href="teste.jsp?acao=Editar&idTipoEquipamento=<%=e.getId()%>"></a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%}
    }else if (objeto.equals("DespachoManutencao")) { 
        List<DespachoManutencao> lista = DespachoManutencaoDAO.listar(sessao, valor); %>
        
        <div class="text-center form-group">
            <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('defeitoDespachoManutencao').value, 'DespachoManutencao')" value="Pesquisar" id="acao" name="acao"/>
            <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            <%if (!lista.isEmpty()){ %>
                <input type="submit" class="btn btn-primary cor-botoes" value="Imprimir" id="acao" name="acao"/>
            <%}%>
        </div>

        <%if (lista.isEmpty()){ %>
            <p class="text-center avisoErro">
                Nenhum registro encontrado.
            <p>        
        <% } else { %>
            <input type="hidden" id="tipo" name="tipo" value="DespachoManutencao" />
            
            <table class="table-striped table-bordered" width="100%">
                <thead>
                    <tr align="center">
                        <td>Ord.</td>
                        <td>Defeito</td>
                        <td>Data Saida</td>
                        <td>Ult. Manut.</td>
                        <td>Equip.</td>
                        <td>Ord. Serv.</td>
                    </tr>
                </thead>
                <tbody> 
                    <% int i = 1; 
                        for(DespachoManutencao dm : lista){ %>
                        <tr class="resultadosTabelaPesquisar" align="center">
                            <td><%out.print(i++);%></td>
                            <td><%out.print(dm.getDefeito());%></td>
                            <td><%out.print(dm.getDataSaida());%></td>
                            <td><%out.print(dm.getUltimaManutencao());%></td>
                            <td><%out.print(dm.getEquipamento().getSerial());%></td>
                            
                            <% 
                                String tempResult;
                                if (dm.getOrdemServico().getOrdemServico().equals(null)) { 
                                      tempResult = "-1";
                                }else{
                                      tempResult = dm.getOrdemServico().getOrdemServico();
                                }//else
                                

                            %>
                            <td><% out.print(tempResult); %></td>
                            <td id="linhaIcones"><a class="btn-sm btn-danger glyphicon glyphicon-trash" onclick="return confirmarExcluir()"   
                                   href="cadastrar_despachomanutencao.jsp?acao=Excluir&idDespachoManutencao=<%=dm.getId()%>"></a></td>
                            <td id="linhaIcones"><a class="btn-sm btn-warning glyphicon glyphicon-edit " 
                               href="cadastrar_despachomanutencao.jsp?acao=Editar&idDespachoManutencao=<%=dm.getId()%>"></a></td>
                             <td id="linhaIcones"><a class="btn-sm btn-primary glyphicon glyphicon-print not-active" 
                               href="cadastrar_despachomanutencao.jsp?acao=Editar&idDespachoManutencao=<%=dm.getId()%>"></a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%}
    }else if (objeto.equals("RetornoManutencao")) { 
        List<RetornoManutencao> lista = RetornoManutencaoDAO.listar(sessao, valor); %>
        
        <div class="text-center form-group">
            <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('laudoRetornoManutencao').value, 'RetornoManutencao')" value="Pesquisar" id="acao" name="acao"/>
            <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            <%if (!lista.isEmpty()){ %>
                <input type="submit" class="btn btn-primary cor-botoes" value="Imprimir" id="acao" name="acao"/>
            <%}%>
        </div>

        <%if (lista.isEmpty()){ %>
            <p class="text-center avisoErro">
                Nenhum registro encontrado.
            <p>        
        <% } else { %>
            <input type="hidden" id="tipo" name="tipo" value="RetornoManutencao" />
            
            <table class="table-striped table-bordered" width="100%">
                <thead>
                    <tr align="center">
                        <td>Ord.</td>
                        <td>Laudo Retorno</td>
                        <td>Data Retorno</td>
                        <td>Equip.</td>
                        <td>Ord. Serv.</td>
                    </tr>
                </thead>
                <tbody> 
                    <% int i = 1; 
                        for(RetornoManutencao rm : lista){ %>
                        <tr class="resultadosTabelaPesquisar" align="center">
                            <td><%out.print(i++);%></td>
                            <td><%out.print(rm.getLaudoRetorno());%></td>
                            <td><%out.print(rm.getDataRetorno());%></td>
                            <td><%out.print(rm.getEquipamento().getSerial());%></td>
                            <td><%out.print(rm.getOrdemServico().getOrdemServico());%></td>
                            <td id="linhaIcones"><a class="btn-sm btn-danger glyphicon glyphicon-trash" onclick="return confirmarExcluir()"   
                                   href="cadastrar_retornomanutencao.jsp?acao=Excluir&idDespachoManutencao=<%=rm.getId()%>"></a></td>
                            <td id="linhaIcones"><a class="btn-sm btn-warning glyphicon glyphicon-edit " 
                               href="cadastrar_retornomanutencao.jsp?acao=Editar&idDespachoManutencao=<%=rm.getId()%>"></a></td>
                             <td id="linhaIcones"><a class="btn-sm btn-primary glyphicon glyphicon-print not-active" 
                               href="cadastrar_retornomanutencao.jsp?acao=Editar&idDespachoManutencao=<%=rm.getId()%>"></a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%}
    } // fim else if
    sessao.close();    
%>
        
            
            
            
 