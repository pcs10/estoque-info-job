<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

    <form name="pesquisarManutencao" method="POST" action="../relatorios/listagem.jsp" target="_blank">
        <div class="form-group">
            <label class="control-label">Manutenção</label>
            <input type="text" class="form-control" id="defeitoManutencao" name="defeitoManutencao" value="" placeholder="Digite o defeito que deseja pesquisar." />
        </div>

        <div id="divAjax" nome="divAjax">
            <div class="text-center form-group">
                <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('defeitoManutencao').value, 'Manutencao')" value="Pesquisar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </div>
    </form>

<jsp:include page="../includes/rodape.jsp"/>