function confirmarExcluir() {
    var resposta = confirm("Deseja realmente excluir esse registro?");

    return(resposta);
} // confirmarExcluir()


function pesquisar(valor, objeto) {
    var requisicao;

    if (window.XMLHttpRequest) {
        requisicao = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        requisicao = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert("Seu navegador não tem suporte a AJAX.");
    }

    requisicao.onreadystatechange = function () {
        if (requisicao.readyState == 1) {
            document.getElementById('divAjax').innerHTML = '<p class="text-center avisoSucesso">Buscando registros... Aguarde!</p>';
        } else if (requisicao.readyState == 4) {
            document.getElementById('divAjax').innerHTML = requisicao.responseText;
        }
    };
    requisicao.open("POST", '../ajax/pesquisar.jsp?valor=' + valor + '&objeto=' + objeto, true);
    requisicao.send(null);
} // pesquisar()
