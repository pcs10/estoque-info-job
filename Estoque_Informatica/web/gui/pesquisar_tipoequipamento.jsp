<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

    <form name="pesquisarTipoEquipamento" method="POST" action="../relatorios/listagem.jsp" target="_blank">
        <div class="form-group">
            <label class="control-label">Tipo de Equipamento</label>
            <input type="text" class="form-control" id="nomeTipoEquipamento" name="nomeTipoEquipamento" value="" placeholder="Digite o tipo de equipamento que deseja pesquisar." />
        </div>

        <div id="divAjax" nome="divAjax">
            <div class="text-center form-group">
                <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('nomeTipoEquipamento').value, 'TipoEquipamento')" value="Pesquisar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </div>
    </form>

<jsp:include page="../includes/rodape.jsp"/>