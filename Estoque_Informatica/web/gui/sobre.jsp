<%
    HttpSession sessaoHTTP = request.getSession();
    if (!sessaoHTTP.getId().equals(sessaoHTTP.getAttribute("idSessao"))) {
        response.sendRedirect("login.jsp?acao=SemLogin");
    } else { %>   
<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>

<jsp:include page="../includes/cabecalho.jsp"/>

<p>Sobre</p>

<p>Versão 1.4 <br>
    13/06/2020 </p>

<jsp:include page="../includes/rodape.jsp"/>

<%}%>