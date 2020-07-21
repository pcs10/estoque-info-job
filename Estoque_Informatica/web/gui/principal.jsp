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

Principal

Aqui vai o conteúdo da página inicial.
<%
    String idSessaoMinha = sessaoHTTP.getAttribute("idSessao").toString();

%>
<jsp:include page="../includes/rodape.jsp"/>

<%}%>