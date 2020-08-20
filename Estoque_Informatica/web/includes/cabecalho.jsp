<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="util.*"%>
<%@page language="java" import="org.hibernate.*"%>
   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes">

        
        <title>Estoque Info Job</title>

        <link rel="stylesheet" href="../includes/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../includes/css/estilo.css">
        <link rel="icon" type="image/x-icon" href="../imagens/favicon.ico">

        <script src="../includes/jquery/jquery-3.1.1.min.js"></script>
        <script src="../includes/bootstrap/js/bootstrap.min.js"></script>
        <script src="../includes/javascript.js"></script>
    </head>

    <body class="corpo">    
        <div class="container corpoFormulario">
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8">
                    <table border="0" width="100%">
                        <tbody>
                            <tr>
                                <td align="left"><img src="../imagens/logomarca.png" height="80"/></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">Estoque Info Job</td>
                            </tr>
                        </tbody>
                    </table>
                    <nav class="navbar navbar-default">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="principal.jsp">Inicial</a>
                        </div>

                        <div id="navbar" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav ">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cadastrar <span class="caret"></span></a>
                                    <ul class="dropdown-menu itemMenu">
                                        <li><a href="../gui/cadastrar_tipoequipamento.jsp?acao=Iniciar&idTipoEquipamento=0">Tipo Equipamento</a></li>
                                        <li><a href="../gui/cadastrar_equipamento.jsp?acao=Iniciar&idEquipamento=0">Equipamento</a></li>
                                        <li><a href="../gui/cadastrar_despachomanutencao.jsp?acao=Iniciar&idDespachoManutencao=0">Despacho Manutenção</a></li>
                                        <li><a href="../gui/cadastrar_retornomanutencao.jsp?acao=Iniciar&idRetornoManutencao=0">Retorno Manutenção</a></li>
                                        <li><a href="../gui/cadastrar_ordemservico.jsp?acao=Iniciar&idOrdemServico=0">Ordem Serviço</a></li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Pesquisar <span class="caret"></span></a>
                                    <ul class="dropdown-menu itemMenu">
                                        <li><a href="../gui/pesquisar_tipoequipamento.jsp">Tipo Equipamento</a></li>
                                        <li><a href="../gui/pesquisar_equipamento.jsp">Equipamento</a></li>
                                        <li><a href="../gui/pesquisar_despachomanutencao.jsp">Despacho Manutenção</a></li>
                                        <li><a href="../gui/pesquisar_retornomanutencao.jsp">Retorno Manutenção</a></li>
                                        <li><a href="../gui/pesquisar_ordemservico.jsp">Ordem Serviço</a></li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Aplicativo <span class="caret"></span></a>
                                    <ul class="dropdown-menu itemMenu">
                                        <li><a href="../gui/sobre.jsp">Sobre</a></li>
                                        <li><a href="../gui/login.jsp?acao=Logout" onclick="return confirmarSair();">Sair</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </nav>
                    

    
                  