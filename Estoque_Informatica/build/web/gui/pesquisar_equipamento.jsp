<%@page language="java" import="util.*"%>
<%@page language="java" import="pojos.*"%>
<%@page language="java" import="dao.*"%>
<%@page language="java" import="org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="../includes/cabecalho.jsp"/>

    <form name="pesquisarEquipamento" method="POST" action="../relatorios/listagem.jsp" target="_blank">
        <div class="form-group">
            <label class="control-label">Equipamento</label>
            <input type="text" class="form-control" id="serialEquipamento" name="serialEquipamento" value="" placeholder="Digite o equipamento que deseja pesquisar." />
        </div>

        <div id="divAjax" nome="divAjax">
            <div class="text-center form-group">
                <input type="button" class="btn btn-primary cor-botoes" onclick="pesquisar(document.getElementById('serialEquipamento').value, 'Equipamento')" value="Pesquisar" id="acao" name="acao"/>
                <input type="reset" class="btn btn-primary cor-botoes" value="Limpar" id="limpar" name="limpar" />
            </div>
        </div>
    </form>

<jsp:include page="../includes/rodape.jsp"/>