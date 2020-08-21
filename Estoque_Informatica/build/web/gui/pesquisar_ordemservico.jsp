<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

    <form name="pesquisarManutencao" method="POST" action="../relatorios/listagem.jsp" target="_blank">
        <div class="form-group">
            <label class="control-label">Ordem Serviço</label>
            <input type="text" class="form-control" id="numOrdemServico" name="numOrdemServico" value="" placeholder="Digite a OS que deseja pesquisar." />
        </div>

        <div id="divAjax" nome="divAjax">
            <div class="text-center form-group">
                <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('numOrdemServico').value, 'OrdemServico')" value="Pesquisar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </div>
    </form>

<jsp:include page="../includes/rodape.jsp"/>