<%
    HttpSession sessaoHTTP = request.getSession();
    if (!sessaoHTTP.getId().equals(sessaoHTTP.getAttribute("idSessao"))) {%>
        <meta http-equiv="refresh" content="0; url=../gui/login.jsp?acao=SemLogin">
    <%} else { %>

<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="util.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page language="java" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes">
        
        
        <title>Listagem</title>
        
        <link rel="icon" type="image/x-icon" href="../imagens/favicon.ico">
        <link rel="stylesheet" href="../includes/css/estiloListagem.css">
    </head>
    
    <body class="corpo">
        <%
            Session sessao = HibernateUtil.getSessionFactory().openSession();
            String tipo = request.getParameter("tipo");
            String titulo = "";
            String valor = "";
            
            if(tipo.equals("TipoEquipamento")){
                titulo = "Tipos de Equipamentos"; // titulo da pagina do relatório
            }else if(tipo.equals("Equipamento")){
                titulo = "Equipamentos";
            }else if(tipo.equals("DespachoManutencao")){
                titulo = "Despacho Manutenção";
            }else if(tipo.equals("RetornoManutencao")){
                titulo = "Retorno da Manutenção";
            }else if(tipo.equals("RelatorioCompleto")){
                titulo = "Relatório Completo";
            }
        %>
        <table border="0" width="100%">
            <tr class="tituloListagem">
                <td align="left"><img src="../imagens/logomarca.png" height="80" onclick="window.close();"/></td>
                <td align="center"><%out.print(titulo);%></td>
            </tr>
        </table>
        <br>
        <%
            if (tipo.equals("TipoEquipamento")) {
                valor = request.getParameter("nomeTipoEquipamento");
                List<TipoEquipamento> lista = TipoEquipamentoDAO.listar(sessao, valor);
        %>

        <table border="1" width="100%">
            <thead>
                <tr class="tituloTabelaListagem" align="center">
                    <td>Ord.</td>
                    <td>Tipo de Equipamento</td>
                </tr>
            </thead>
            <tbody> 
            <%  int i = 1;
                for (TipoEquipamento te : lista) { 
            %>
                <tr class="resultadosListagem">
                    <td align="center"><%out.print(i++);%></td>
                    <td><%out.print(te.getNome());%></td>
                </tr>
            <%}%> 
            </tbody>
        </table>
       <%}else if (tipo.equals("Equipamento")) {
                valor = request.getParameter("serialEquipamento");
                List<Equipamento> lista = EquipamentoDAO.listar(sessao, valor);
        %>
        <table border="1" width="100%">
            <thead>
                <tr class="tituloTabelaListagem" align="center">
                    <td>Ord.</td>
                    <td>Serial</td>
                    <td>Tipo de Equip.</td>
                </tr>
            </thead>
            <tbody>
                <%  int i = 1;
                for (Equipamento e : lista) { %>
                <tr class="resultadosListagem">
                    <td align="center"><%out.print(i++);%></td>
                    <td><%out.print(e.getSerial());%></td>
                    <td><%out.print(e.getTipoEquipamento().getNome());%></td>
                </tr>
            <%}%> 
            </tbody>
        </table>
       <%}else if (tipo.equals("DespachoManutencao")) {
                valor = request.getParameter("defeitoDespachoManutencao");
                List<DespachoManutencao> lista = DespachoManutencaoDAO.listar(sessao, valor);
        %>
        <table border="1" width="100%">
            <thead>
                <tr class="tituloTabelaListagem" align="center">
                    <td>Ord.</td>
                    <td>Defeito</td>
                    <td>Data Saida</td>
                    <td>Ult. Manut.</td>
                    <td>Equip.</td>
                  <!--   <td>Ord. Serv.</td>  -->
                </tr>
            </thead>
            <tbody>
                <%  int i = 1;
                for (DespachoManutencao dm : lista) { %>
                <tr class="resultadosListagem">
                    <td align="center"><%out.print(i++);%></td>
                    <td><%out.print(dm.getDefeito());%></td>
                    <td><%out.print(dm.getDataSaida());%></td>
                    <td><%out.print(dm.getUltimaManutencao());%></td>
                    <td><%out.print(dm.getEquipamento().getSerial());%></td>
                    <!-- fazer aqui depois a ordem de servico -->
                </tr>
            <%}%> 
            </tbody>
        </table>
       <%}%>
    </div>
</html>
<%}%>