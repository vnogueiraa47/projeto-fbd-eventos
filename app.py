import pandas as pd
import panel as pn
import psycopg2
from sqlalchemy import text

from conexao import CONFIG_BANCO, engine


pn.extension("tabulator")
pn.config.sizing_mode = "stretch_width"


def criar_tela_crud(
    titulo,
    nome_tabela,
    coluna_id,
    configuracao_campos,
    campos_obrigatorios,
    campos_inteiros=None
):
    campos_inteiros = set(campos_inteiros or [])
    colunas = [campo["coluna"] for campo in configuracao_campos]
    rotulos = {
        campo["coluna"]: campo["rotulo"]
        for campo in configuracao_campos
    }

    campo_id = pn.widgets.IntInput(
        name="ID",
        value=0,
        start=0,
        disabled=True
    )

    campos = {}

    for campo in configuracao_campos:
        if campo["tipo"] == "area":
            campos[campo["coluna"]] = pn.widgets.TextAreaInput(
                name=campo["rotulo"],
                placeholder=campo.get("placeholder", ""),
                height=100
            )
        else:
            campos[campo["coluna"]] = pn.widgets.TextInput(
                name=campo["rotulo"],
                placeholder=campo.get("placeholder", "")
            )

    tabela = pn.widgets.Tabulator(
        pd.DataFrame(columns=[coluna_id] + colunas),
        pagination="local",
        page_size=10,
        selectable=1,
        show_index=False,
        height=350
    )

    mensagem = pn.pane.Alert("", alert_type="primary")

    def mostrar_mensagem(texto, tipo="success"):
        mensagem.object = texto
        mensagem.alert_type = tipo

    def buscar_registros():
        colunas_sql = ", ".join([coluna_id] + colunas)

        with psycopg2.connect(**CONFIG_BANCO) as conexao:
            with conexao.cursor() as cursor:
                cursor.execute(f"""
                    SELECT {colunas_sql}
                    FROM {nome_tabela}
                    ORDER BY {coluna_id};
                """)

                registros = cursor.fetchall()
                nomes_colunas = [
                    descricao[0] for descricao in cursor.description
                ]

        return pd.DataFrame(registros, columns=nomes_colunas)

    def atualizar_tabela():
        try:
            tabela.value = buscar_registros()
            tabela.selection = []
        except Exception as erro:
            mostrar_mensagem(
                f"Erro ao listar registros: {erro}",
                "danger"
            )

    def limpar_campos():
        campo_id.value = 0

        for campo in campos.values():
            campo.value = ""

        tabela.selection = []

    def obter_valores_formulario():
        valores = {}

        for coluna in colunas:
            valor = campos[coluna].value

            if coluna in campos_inteiros:
                texto_valor = str(valor).strip()

                if texto_valor == "":
                    valores[coluna] = None
                else:
                    try:
                        numero = int(texto_valor)

                        if numero < 0:
                            raise ValueError

                        valores[coluna] = numero

                    except ValueError:
                        raise ValueError(
                            f'O campo "{rotulos[coluna]}" deve ser '
                            "um número inteiro não negativo."
                        )

            else:
                texto_valor = str(valor).strip()
                valores[coluna] = texto_valor or None

        for coluna in campos_obrigatorios:
            if valores[coluna] is None:
                raise ValueError(
                    f'Preencha o campo obrigatório: "{rotulos[coluna]}".'
                )

        return valores

    def inserir(evento):
        try:
            valores = obter_valores_formulario()

            colunas_insert = ", ".join(colunas)
            parametros = ", ".join(
                [f":{coluna}" for coluna in colunas]
            )

            with engine.begin() as conexao:
                conexao.execute(
                    text(f"""
                        INSERT INTO {nome_tabela} ({colunas_insert})
                        VALUES ({parametros});
                    """),
                    valores
                )

            atualizar_tabela()
            limpar_campos()
            mostrar_mensagem("Registro inserido com sucesso.")

        except Exception as erro:
            mostrar_mensagem(
                f"Erro ao inserir registro: {erro}",
                "danger"
            )

    def atualizar(evento):
        if campo_id.value == 0:
            mostrar_mensagem(
                "Selecione um registro na tabela para atualizar.",
                "warning"
            )
            return

        try:
            valores = obter_valores_formulario()
            valores[coluna_id] = campo_id.value

            campos_update = ", ".join(
                [f"{coluna} = :{coluna}" for coluna in colunas]
            )

            with engine.begin() as conexao:
                resultado = conexao.execute(
                    text(f"""
                        UPDATE {nome_tabela}
                        SET {campos_update}
                        WHERE {coluna_id} = :{coluna_id};
                    """),
                    valores
                )

            if resultado.rowcount == 0:
                mostrar_mensagem("Registro não encontrado.", "warning")
                return

            atualizar_tabela()
            limpar_campos()
            mostrar_mensagem("Registro atualizado com sucesso.")

        except Exception as erro:
            mostrar_mensagem(
                f"Erro ao atualizar registro: {erro}",
                "danger"
            )

    def remover(evento):
        if campo_id.value == 0:
            mostrar_mensagem(
                "Selecione um registro na tabela para remover.",
                "warning"
            )
            return

        try:
            with engine.begin() as conexao:
                resultado = conexao.execute(
                    text(f"""
                        DELETE FROM {nome_tabela}
                        WHERE {coluna_id} = :id;
                    """),
                    {"id": campo_id.value}
                )

            if resultado.rowcount == 0:
                mostrar_mensagem("Registro não encontrado.", "warning")
                return

            atualizar_tabela()
            limpar_campos()
            mostrar_mensagem("Registro removido com sucesso.")

        except Exception as erro:
            mostrar_mensagem(
                "Não foi possível remover este registro. "
                "Ele pode estar sendo usado em outra tabela. "
                f"Erro: {erro}",
                "danger"
            )

    def carregar_registro_selecionado(evento):
        if not evento.new:
            return

        indice = evento.new[0]

        if indice >= len(tabela.value):
            return

        linha = tabela.value.iloc[indice]

        campo_id.value = int(linha[coluna_id])

        for coluna in colunas:
            valor = linha[coluna]

            if pd.isna(valor):
                campos[coluna].value = ""
            else:
                campos[coluna].value = str(valor)

    tabela.param.watch(carregar_registro_selecionado, "selection")

    botao_inserir = pn.widgets.Button(
        name="Inserir",
        button_type="success"
    )

    botao_atualizar = pn.widgets.Button(
        name="Atualizar",
        button_type="primary"
    )

    botao_remover = pn.widgets.Button(
        name="Remover",
        button_type="danger"
    )

    botao_limpar = pn.widgets.Button(
        name="Limpar campos"
    )

    botao_inserir.on_click(inserir)
    botao_atualizar.on_click(atualizar)
    botao_remover.on_click(remover)
    botao_limpar.on_click(lambda evento: limpar_campos())

    atualizar_tabela()

    formulario = pn.Column(
        f"## Dados de {titulo}",
        campo_id,
        *[campos[coluna] for coluna in colunas],
        pn.Row(
            botao_inserir,
            botao_atualizar,
            botao_remover,
            botao_limpar
        ),
        width=430
    )

    return pn.Column(
        f"# CRUD de {titulo}",
        "Selecione uma linha da tabela para editar ou remover.",
        mensagem,
        pn.Row(
            formulario,
            pn.Column(
                "## Registros cadastrados",
                tabela
            )
        )
    )


tela_categoria = criar_tela_crud(
    titulo="Categorias",
    nome_tabela="categoria",
    coluna_id="id_categoria",
    configuracao_campos=[
        {
            "coluna": "nome_categoria",
            "rotulo": "Nome da categoria",
            "tipo": "texto",
            "placeholder": "Ex.: Tecnologia"
        },
        {
            "coluna": "descricao",
            "rotulo": "Descrição",
            "tipo": "area",
            "placeholder": "Descrição da categoria"
        }
    ],
    campos_obrigatorios=["nome_categoria"]
)


tela_local = criar_tela_crud(
    titulo="Locais",
    nome_tabela="local",
    coluna_id="id_local",
    configuracao_campos=[
        {
            "coluna": "nome_local",
            "rotulo": "Nome do local",
            "tipo": "texto",
            "placeholder": "Ex.: Auditório Central"
        },
        {
            "coluna": "logradouro",
            "rotulo": "Logradouro",
            "tipo": "texto",
            "placeholder": "Ex.: Rua Principal"
        },
        {
            "coluna": "numero",
            "rotulo": "Número",
            "tipo": "texto",
            "placeholder": "Ex.: 100"
        },
        {
            "coluna": "bairro",
            "rotulo": "Bairro",
            "tipo": "texto",
            "placeholder": "Ex.: Centro"
        },
        {
            "coluna": "cep",
            "rotulo": "CEP",
            "tipo": "texto",
            "placeholder": "Somente números"
        },
        {
            "coluna": "cidade",
            "rotulo": "Cidade",
            "tipo": "texto",
            "placeholder": "Ex.: Quixadá"
        },
        {
            "coluna": "capacidade",
            "rotulo": "Capacidade",
            "tipo": "texto",
            "placeholder": "Ex.: 100"
        }
    ],
    campos_obrigatorios=["nome_local", "capacidade"],
    campos_inteiros=["capacidade"]
)


tela_recurso = criar_tela_crud(
    titulo="Recursos",
    nome_tabela="recurso",
    coluna_id="id_recurso",
    configuracao_campos=[
        {
            "coluna": "nome_recurso",
            "rotulo": "Nome do recurso",
            "tipo": "texto",
            "placeholder": "Ex.: Projetor"
        },
        {
            "coluna": "tipo",
            "rotulo": "Tipo",
            "tipo": "texto",
            "placeholder": "Ex.: Equipamento"
        },
        {
            "coluna": "descricao",
            "rotulo": "Descrição",
            "tipo": "area",
            "placeholder": "Descrição do recurso"
        },
        {
            "coluna": "qtde_disponivel",
            "rotulo": "Quantidade disponível",
            "tipo": "texto",
            "placeholder": "Ex.: 10"
        }
    ],
    campos_obrigatorios=[
        "nome_recurso",
	"tipo",
        "qtde_disponivel"
    ],
    campos_inteiros=["qtde_disponivel"]
)


abas = pn.Tabs(
    ("Categorias", tela_categoria),
    ("Locais", tela_local),
    ("Recursos", tela_recurso)
)

aplicacao = pn.Column(
    "# Sistema de Gerenciamento de Eventos",
    "Protótipo CRUD desenvolvido em Python, Panel, psycopg2 e SQLAlchemy.",
    abas
)

aplicacao.servable()