<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema ELFSM - Login</title>
    
        <link rel="stylesheet" href="../includes/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../includes/css/estilo.css">
        <link rel="icon" type="image/x-icon" href="../imagens/favicon.ico">

        <script src="../includes/jquery/jquery-3.1.1.min.js"></script>
        <script src="../includes/bootstrap/js/bootstrap.min.js"></script>
        <script src="../includes/javascript.js"></script>
    
    </head>
    <body>
        <div class="container corpoFormulario">
            <div class="row">
                <div class="col-sm-4"></div>

                <div class="col-sm-4">
                    
                    <% 
                        String acao = request.getParameter("acao");
                        HttpSession sessaoHTTP = request.getSession();
                        //out.print("id de sessao retornado pelo servidor: " + sessaoHTTP.getId());
                        Session sessao = HibernateUtil.getSessionFactory().openSession();
     
                        if (acao.equals("Iniciar")) {%> 
                        <br><br><br><br><br>
                            <form name="Login" action="login.jsp">
                                <div class="login" >
                                    <img src="../imagens/logo-elfsm.png">
                                </div>
                                <br> 
                                
                                <div class="iconInput">
                                    <i class="glyphicon glyphicon-user"></i>
                                    <input type="text" class="form-control" id="login" name="login" value="" placeholder="Usuário" required/>
                                </div><br>
                                
                                <div class="iconInput">
                                    <i class="glyphicon glyphicon-lock"></i>
                                    <input type="password" class="form-control" id="senha" name="senha" value="" placeholder="Senha" required/>
                                </div><br>
                                

                                <div id ="btnLogin" class="text-center form-group">
                                    <input type="submit" class="btn btn-primary cor-botoes"  value="Login" id="acao" name="acao"/>
                                    <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
                                </div>
                            </form>
                
                        <%} else if (acao.equals("Login")) {
                            String login = request.getParameter("login");
                            String senha = request.getParameter("senha");

                            if (login.equals("patrick") && senha.equals("123")) {
                                sessaoHTTP.setAttribute("idSessao", sessaoHTTP.getId());
                                sessaoHTTP.setAttribute("usuario", login);

                                response.sendRedirect("principal.jsp");
                            } else {
                                response.sendRedirect("login.jsp?acao=Invalido");
                            }
                        } else if (acao.equals("Invalido")) {%>
                            <p class="text-center avisoErro">
                                Verifique se o seu login e sua senha estão corretos.
                            </p> 
                            <a href="../index.html">Fazer login</a>
                        <%} else if (acao.equals("SemLogin")) {  %>
                            <p class="text-center avisoErro">
                                Você precisa fazer o login.
                            </p> 
                            <a href="../index.html">Fazer login</a>
                        <%}else if (acao.equals("Logout")){
                           // sessao.disconnect();
                            sessaoHTTP.setAttribute("idSessao", null);
                            response.sendRedirect("login.jsp?acao=Iniciar"); 
                             
                        }%>
                
                </div>

                <div class="col-sm-4"></div>
            </div>
    </body>
</html>
