<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

    <form name="pesquisarRetornoManutencao" method="POST" action="../relatorios/listagem.jsp" target="_blank">
        <div class="form-group">
            <label class="control-label">Retorno Manutenção</label>
            <input type="text" class="form-control" id="laudoRetornoManutencao" name="laudoRetornoManutencao" value="" placeholder="Digite o laudo que deseja pesquisar." />
        </div>

        <div id="divAjax" nome="divAjax">
            <div class="text-center form-group">
                <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('laudoRetornoManutencao').value, 'RetornoManutencao')" value="Pesquisar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </div>
    </form>

<jsp:include page="../includes/rodape.jsp"/>