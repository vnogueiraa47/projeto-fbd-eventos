-- Projeto Fundamentos de Bancos de Dados - Sistema de Gerenciamento de Eventos
-- Script de criação do esquema relacional
-- Execute em um banco PostgreSQL vazio.

BEGIN;

-- Tabelas
CREATE TABLE public.avaliacao (
    id_avaliacao integer NOT NULL,
    nota numeric(3,1) NOT NULL,
    comentario text,
    id_inscricao integer NOT NULL,
    CONSTRAINT avaliacao_nota_check CHECK (((nota >= (0)::numeric) AND (nota <= (10)::numeric)))
);

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nome_categoria character varying(80) NOT NULL,
    descricao text
);

CREATE TABLE public.entra_lista_espera (
    id_participante integer NOT NULL,
    id_evento integer NOT NULL,
    data_solicitacao date DEFAULT CURRENT_DATE NOT NULL,
    posicao_fila integer NOT NULL,
    CONSTRAINT entra_lista_espera_posicao_fila_check CHECK ((posicao_fila > 0))
);

CREATE TABLE public.evento (
    id_evento integer NOT NULL,
    titulo character varying(150) NOT NULL,
    descricao text,
    data date NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fim time without time zone NOT NULL,
    status character varying(30) DEFAULT 'planejado'::character varying NOT NULL,
    capacidade_max integer,
    id_local integer,
    id_categoria integer,
    CONSTRAINT evento_capacidade_max_check CHECK ((capacidade_max > 0)),
    CONSTRAINT evento_status_check CHECK (((status)::text = ANY ((ARRAY['planejado'::character varying, 'em andamento'::character varying, 'concluido'::character varying, 'cancelado'::character varying])::text[])))
);

CREATE TABLE public.inscricao (
    id_inscricao integer NOT NULL,
    data_inscricao date DEFAULT CURRENT_DATE NOT NULL,
    status_inscricao character varying(30) DEFAULT 'ativa'::character varying NOT NULL,
    situacao_presenca character varying(30) DEFAULT 'pendente'::character varying,
    data_hora_presenca timestamp without time zone,
    id_participante integer NOT NULL,
    id_evento integer NOT NULL,
    CONSTRAINT inscricao_situacao_presenca_check CHECK (((situacao_presenca)::text = ANY ((ARRAY['pendente'::character varying, 'presente'::character varying, 'ausente'::character varying])::text[]))),
    CONSTRAINT inscricao_status_inscricao_check CHECK (((status_inscricao)::text = ANY ((ARRAY['ativa'::character varying, 'cancelada'::character varying, 'confirmada'::character varying])::text[])))
);

CREATE TABLE public.local (
    id_local integer NOT NULL,
    nome_local character varying(100) NOT NULL,
    logradouro character varying(150),
    numero character varying(10),
    bairro character varying(80),
    cep character(8),
    cidade character varying(80),
    capacidade integer,
    CONSTRAINT local_capacidade_check CHECK ((capacidade > 0))
);

CREATE TABLE public.organiza (
    id_organizador integer NOT NULL,
    id_evento integer NOT NULL,
    funcao_no_evento character varying(80)
);

CREATE TABLE public.organizador (
    id_usuario integer NOT NULL,
    data_vinculacao date DEFAULT CURRENT_DATE NOT NULL,
    area_responsavel character varying(100)
);

CREATE TABLE public.participante (
    id_usuario integer NOT NULL,
    data_cadastro date DEFAULT CURRENT_DATE NOT NULL
);

CREATE TABLE public.recurso (
    id_recurso integer NOT NULL,
    nome_recurso character varying(100) NOT NULL,
    tipo character varying(60),
    descricao text,
    qtde_disponivel integer NOT NULL,
    CONSTRAINT recurso_qtde_disponivel_check CHECK ((qtde_disponivel >= 0))
);

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character(11) NOT NULL,
    email character varying(100) NOT NULL,
    telefone character varying(20),
    data_nascimento date
);

CREATE TABLE public.utiliza (
    id_evento integer NOT NULL,
    id_recurso integer NOT NULL,
    qtd_utilizada integer NOT NULL,
    CONSTRAINT utiliza_qtd_utilizada_check CHECK ((qtd_utilizada > 0))
);

-- Sequências das chaves geradas automaticamente
CREATE SEQUENCE public.avaliacao_id_avaliacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.evento_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.inscricao_id_inscricao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.local_id_local_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.recurso_id_recurso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Associação entre sequências e colunas
ALTER SEQUENCE public.avaliacao_id_avaliacao_seq OWNED BY public.avaliacao.id_avaliacao;

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;

ALTER SEQUENCE public.evento_id_evento_seq OWNED BY public.evento.id_evento;

ALTER SEQUENCE public.inscricao_id_inscricao_seq OWNED BY public.inscricao.id_inscricao;

ALTER SEQUENCE public.local_id_local_seq OWNED BY public.local.id_local;

ALTER SEQUENCE public.recurso_id_recurso_seq OWNED BY public.recurso.id_recurso;

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;

-- Valores padrão para as chaves geradas automaticamente
ALTER TABLE ONLY public.avaliacao ALTER COLUMN id_avaliacao SET DEFAULT nextval('public.avaliacao_id_avaliacao_seq'::regclass);

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);

ALTER TABLE ONLY public.evento ALTER COLUMN id_evento SET DEFAULT nextval('public.evento_id_evento_seq'::regclass);

ALTER TABLE ONLY public.inscricao ALTER COLUMN id_inscricao SET DEFAULT nextval('public.inscricao_id_inscricao_seq'::regclass);

ALTER TABLE ONLY public.local ALTER COLUMN id_local SET DEFAULT nextval('public.local_id_local_seq'::regclass);

ALTER TABLE ONLY public.recurso ALTER COLUMN id_recurso SET DEFAULT nextval('public.recurso_id_recurso_seq'::regclass);

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);

-- Chaves primárias, chaves únicas e chaves estrangeiras
ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_id_inscricao_key UNIQUE (id_inscricao);

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_pkey PRIMARY KEY (id_avaliacao);

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_pkey PRIMARY KEY (id_participante, id_evento);

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_participante_id_evento_key UNIQUE (id_participante, id_evento);

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (id_inscricao);

ALTER TABLE ONLY public.local
    ADD CONSTRAINT local_pkey PRIMARY KEY (id_local);

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_pkey PRIMARY KEY (id_organizador, id_evento);

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_pkey PRIMARY KEY (id_usuario);

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_pkey PRIMARY KEY (id_usuario);

ALTER TABLE ONLY public.recurso
    ADD CONSTRAINT recurso_pkey PRIMARY KEY (id_recurso);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_pkey PRIMARY KEY (id_evento, id_recurso);

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_id_inscricao_fkey FOREIGN KEY (id_inscricao) REFERENCES public.inscricao(id_inscricao) ON DELETE CASCADE;

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria) ON DELETE SET NULL;

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_id_local_fkey FOREIGN KEY (id_local) REFERENCES public.local(id_local) ON DELETE SET NULL;

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_id_organizador_fkey FOREIGN KEY (id_organizador) REFERENCES public.organizador(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES public.recurso(id_recurso) ON DELETE CASCADE;

COMMIT;
