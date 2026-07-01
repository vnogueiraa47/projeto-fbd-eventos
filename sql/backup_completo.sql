--
-- PostgreSQL database dump
--

\restrict L9hePFWZhegtGtuJxMdQU4RCdcoUNJFvfmkRHXhcJl8PYGWVgk8036ipPvdSeLS

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-01 09:07:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 16629)
-- Name: avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao (
    id_avaliacao integer NOT NULL,
    nota numeric(3,1) NOT NULL,
    comentario text,
    id_inscricao integer NOT NULL,
    CONSTRAINT avaliacao_nota_check CHECK (((nota >= (0)::numeric) AND (nota <= (10)::numeric)))
);


ALTER TABLE public.avaliacao OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16628)
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avaliacao_id_avaliacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avaliacao_id_avaliacao_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 233
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avaliacao_id_avaliacao_seq OWNED BY public.avaliacao.id_avaliacao;


--
-- TOC entry 224 (class 1259 OID 16538)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nome_categoria character varying(80) NOT NULL,
    descricao text
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16537)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 235 (class 1259 OID 16648)
-- Name: entra_lista_espera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entra_lista_espera (
    id_participante integer NOT NULL,
    id_evento integer NOT NULL,
    data_solicitacao date DEFAULT CURRENT_DATE NOT NULL,
    posicao_fila integer NOT NULL,
    CONSTRAINT entra_lista_espera_posicao_fila_check CHECK ((posicao_fila > 0))
);


ALTER TABLE public.entra_lista_espera OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16572)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

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


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16571)
-- Name: evento_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evento_id_evento_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 229
-- Name: evento_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_id_evento_seq OWNED BY public.evento.id_evento;


--
-- TOC entry 232 (class 1259 OID 16600)
-- Name: inscricao; Type: TABLE; Schema: public; Owner: postgres
--

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


ALTER TABLE public.inscricao OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16599)
-- Name: inscricao_id_inscricao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscricao_id_inscricao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscricao_id_inscricao_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 231
-- Name: inscricao_id_inscricao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscricao_id_inscricao_seq OWNED BY public.inscricao.id_inscricao;


--
-- TOC entry 226 (class 1259 OID 16549)
-- Name: local; Type: TABLE; Schema: public; Owner: postgres
--

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


ALTER TABLE public.local OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16548)
-- Name: local_id_local_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.local_id_local_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.local_id_local_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 225
-- Name: local_id_local_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.local_id_local_seq OWNED BY public.local.id_local;


--
-- TOC entry 236 (class 1259 OID 16670)
-- Name: organiza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organiza (
    id_organizador integer NOT NULL,
    id_evento integer NOT NULL,
    funcao_no_evento character varying(80)
);


ALTER TABLE public.organiza OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16524)
-- Name: organizador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizador (
    id_usuario integer NOT NULL,
    data_vinculacao date DEFAULT CURRENT_DATE NOT NULL,
    area_responsavel character varying(100)
);


ALTER TABLE public.organizador OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16511)
-- Name: participante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participante (
    id_usuario integer NOT NULL,
    data_cadastro date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.participante OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16559)
-- Name: recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recurso (
    id_recurso integer NOT NULL,
    nome_recurso character varying(100) NOT NULL,
    tipo character varying(60),
    descricao text,
    qtde_disponivel integer NOT NULL,
    CONSTRAINT recurso_qtde_disponivel_check CHECK ((qtde_disponivel >= 0))
);


ALTER TABLE public.recurso OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16558)
-- Name: recurso_id_recurso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recurso_id_recurso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recurso_id_recurso_seq OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 227
-- Name: recurso_id_recurso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recurso_id_recurso_seq OWNED BY public.recurso.id_recurso;


--
-- TOC entry 220 (class 1259 OID 16497)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character(11) NOT NULL,
    email character varying(100) NOT NULL,
    telefone character varying(20),
    data_nascimento date
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16496)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 237 (class 1259 OID 16687)
-- Name: utiliza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utiliza (
    id_evento integer NOT NULL,
    id_recurso integer NOT NULL,
    qtd_utilizada integer NOT NULL,
    CONSTRAINT utiliza_qtd_utilizada_check CHECK ((qtd_utilizada > 0))
);


ALTER TABLE public.utiliza OWNER TO postgres;

--
-- TOC entry 4918 (class 2604 OID 16632)
-- Name: avaliacao id_avaliacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao ALTER COLUMN id_avaliacao SET DEFAULT nextval('public.avaliacao_id_avaliacao_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16541)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 16575)
-- Name: evento id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento ALTER COLUMN id_evento SET DEFAULT nextval('public.evento_id_evento_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 16603)
-- Name: inscricao id_inscricao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao ALTER COLUMN id_inscricao SET DEFAULT nextval('public.inscricao_id_inscricao_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 16552)
-- Name: local id_local; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.local ALTER COLUMN id_local SET DEFAULT nextval('public.local_id_local_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16562)
-- Name: recurso id_recurso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso ALTER COLUMN id_recurso SET DEFAULT nextval('public.recurso_id_recurso_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 16500)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5136 (class 0 OID 16629)
-- Dependencies: 234
-- Data for Name: avaliacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avaliacao (id_avaliacao, nota, comentario, id_inscricao) FROM stdin;
1	9.5	Evento excelente! Desafios muito criativos e equipe bem organizada.	1
2	8.0	Ótima experiência, mas a comida poderia ser melhor.	2
3	9.0	Palestras muito relevantes e instrutores qualificados.	4
4	7.5	Bom conteúdo, porém o espaço estava quente demais.	5
5	8.5	Exposição bem curada com projetos inovadores.	7
6	9.0	Adorei as apresentações culturais locais, muito autêntico!	9
7	8.0	Percurso bonito, mas sinalização poderia melhorar.	11
8	9.5	Painéis muito ricos, com cases reais de sucesso.	12
9	8.5	Pesquisas de ponta apresentadas de forma acessível.	13
10	7.0	Boa organização geral, esperava mais diversidade nos temas.	8
\.


--
-- TOC entry 5126 (class 0 OID 16538)
-- Dependencies: 224
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id_categoria, nome_categoria, descricao) FROM stdin;
2	Saúde	Congressos, workshops e palestras na área da saúde
3	Educação	Seminários, cursos e feiras educacionais
4	Cultura	Festivais, exposições e eventos culturais diversos
5	Esporte	Competições, maratonas e eventos esportivos
6	Negócios	Feiras de negócios, empreendedorismo e finanças
7	Meio Ambiente	Eventos sobre sustentabilidade e ecologia
8	Gastronomia	Festivais gastronômicos, cursos de culinária
9	Música	Shows, recitais e festivais musicais
10	Ciência	Simpósios, feiras científicas e eventos acadêmicos
1	Tecnologia	Eventos relacionados a TI, programação e inovação
\.


--
-- TOC entry 5137 (class 0 OID 16648)
-- Dependencies: 235
-- Data for Name: entra_lista_espera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entra_lista_espera (id_participante, id_evento, data_solicitacao, posicao_fila) FROM stdin;
6	1	2025-08-10	1
7	1	2025-08-11	2
8	2	2025-09-05	1
9	2	2025-09-06	2
10	3	2025-10-03	1
1	4	2025-11-15	1
2	5	2025-11-28	1
3	6	2026-02-12	1
6	9	2026-06-10	1
7	9	2026-06-11	2
\.


--
-- TOC entry 5132 (class 0 OID 16572)
-- Dependencies: 230
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento (id_evento, titulo, descricao, data, hora_inicio, hora_fim, status, capacidade_max, id_local, id_categoria) FROM stdin;
1	Hackathon UFC 2025	Maratona de programação com desafios reais	2025-08-15	08:00:00	22:00:00	concluido	150	1	1
2	Semana da Saúde	Palestras e workshops sobre saúde preventiva	2025-09-10	09:00:00	17:00:00	concluido	200	2	2
3	Feira de Educação Inovadora	Exposição de metodologias educacionais inovadoras	2025-10-05	08:00:00	18:00:00	concluido	300	6	3
4	Festival Cultural Quixadá	Apresentações culturais e artísticas locais	2025-11-20	14:00:00	22:00:00	concluido	500	9	4
5	Maratona Sertão Verde	Corrida de 10km em trilhas ecológicas	2025-12-01	06:00:00	12:00:00	concluido	400	9	5
6	Fórum de Empreendedorismo	Painéis com empreendedores e investidores	2026-02-18	09:00:00	17:00:00	concluido	180	8	6
7	Simpósio de IA e Dados	Apresentação de pesquisas em inteligência artificial	2026-04-22	08:30:00	18:30:00	concluido	120	1	1
8	Workshop de Sustentabilidade	Oficinas sobre reciclagem e energia renovável	2026-05-05	14:00:00	18:00:00	concluido	80	10	7
10	Rock no Sertão	Show com bandas locais e regionais	2026-07-12	18:00:00	23:00:00	planejado	800	7	9
11	Congresso de Ciências UFC	Apresentações de TCC, IC e pós-graduação	2026-08-03	08:00:00	18:00:00	planejado	250	1	10
12	Semana de TI Quixadá	Palestras e minicursos sobre computação	2026-09-15	08:00:00	18:00:00	planejado	200	5	1
9	Festival Gastronômico CE	Culinária regional e demonstrações ao vivo	2026-06-28	11:00:00	21:00:00	em andamento	600	\N	8
\.


--
-- TOC entry 5134 (class 0 OID 16600)
-- Dependencies: 232
-- Data for Name: inscricao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscricao (id_inscricao, data_inscricao, status_inscricao, situacao_presenca, data_hora_presenca, id_participante, id_evento) FROM stdin;
1	2025-08-01	confirmada	presente	2025-08-15 08:10:00	1	1
2	2025-08-02	confirmada	presente	2025-08-15 08:05:00	2	1
3	2025-08-03	confirmada	ausente	\N	3	1
4	2025-09-01	confirmada	presente	2025-09-10 09:02:00	4	2
5	2025-09-02	confirmada	presente	2025-09-10 09:15:00	5	2
6	2025-09-03	cancelada	pendente	\N	6	2
7	2025-10-01	confirmada	presente	2025-10-05 08:20:00	7	3
8	2025-10-02	confirmada	presente	2025-10-05 08:30:00	8	3
9	2025-11-10	confirmada	presente	2025-11-20 14:05:00	9	4
10	2025-11-11	confirmada	ausente	\N	10	4
11	2025-11-25	confirmada	presente	2025-12-01 06:10:00	1	5
12	2026-02-10	confirmada	presente	2026-02-18 09:00:00	2	6
13	2026-04-15	confirmada	presente	2026-04-22 08:35:00	3	7
14	2026-05-01	ativa	pendente	\N	4	9
15	2026-06-01	ativa	pendente	\N	5	9
\.


--
-- TOC entry 5128 (class 0 OID 16549)
-- Dependencies: 226
-- Data for Name: local; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.local (id_local, nome_local, logradouro, numero, bairro, cep, cidade, capacidade) FROM stdin;
1	Auditório UFC Quixadá	Rua Estevão Remígio de Farias	1145	Centro	63902373	Quixadá	300
2	Centro de Convenções CE	Av. Washington Soares	999	Edson Queiroz	60811341	Fortaleza	2000
4	Arena Castelão	Av. Alberto Craveiro	2901	Castelão	60863240	Fortaleza	63000
5	Sala de Aulas UFC Quixadá	Rua Estevão Remígio de Farias	1145	Centro	63902373	Quixadá	60
6	Espaço Cultural Unifor	Av. Washington Soares	1321	Edson Queiroz	60811905	Fortaleza	400
7	Ginásio SESI Quixadá	Av. João Pessoa	500	Santo Antônio	63900000	Quixadá	800
8	Hub de Inovação Ceará	Av. Heráclito Graça	330	Centro	60140061	Fortaleza	150
9	Parque Adahil Barreto	Av. Padre Cícero	s/n	Jardim das Oliveiras	63905490	Quixadá	500
10	Biblioteca Universitária	Rua Estevão Remígio de Farias	1145	Centro	63902373	Quixadá	80
11	local novo	teste	111	salviano carlos	63800000	quixada	777
\.


--
-- TOC entry 5138 (class 0 OID 16670)
-- Dependencies: 236
-- Data for Name: organiza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organiza (id_organizador, id_evento, funcao_no_evento) FROM stdin;
11	1	Coordenador Geral
12	2	Coordenador Geral
13	3	Coordenador Geral
14	4	Coordenador Geral
15	5	Coordenador Geral
11	6	Apoio Logístico
12	7	Coordenador Geral
13	8	Facilitador
14	9	Coordenador Geral
15	10	Produtor Musical
\.


--
-- TOC entry 5124 (class 0 OID 16524)
-- Dependencies: 222
-- Data for Name: organizador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizador (id_usuario, data_vinculacao, area_responsavel) FROM stdin;
11	2020-01-15	Tecnologia da Informação
12	2018-03-10	Engenharia Civil
13	2019-07-22	Ciências Biomédicas
14	2021-09-05	Administração
15	2022-02-28	Artes e Humanidades
6	2025-01-15	Logística
7	2025-02-10	Comunicação
8	2025-03-05	Infraestrutura
9	2025-04-20	Credenciamento
10	2025-05-12	Apoio Técnico
\.


--
-- TOC entry 5123 (class 0 OID 16511)
-- Dependencies: 221
-- Data for Name: participante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participante (id_usuario, data_cadastro) FROM stdin;
1	2025-01-10
2	2025-02-15
3	2025-03-01
4	2025-03-20
5	2025-04-05
6	2025-04-18
7	2025-05-02
8	2025-05-25
9	2025-06-10
10	2025-06-22
\.


--
-- TOC entry 5130 (class 0 OID 16559)
-- Dependencies: 228
-- Data for Name: recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recurso (id_recurso, nome_recurso, tipo, descricao, qtde_disponivel) FROM stdin;
1	Projetor Full HD	Audiovisual	Projetor 1080p com HDMI e VGA	10
2	Microfone sem fio	Audiovisual	Microfone UHF com receptor	20
3	Mesa de som	Audiovisual	Mesa de mixagem 16 canais	5
4	Cadeira auditório	Mobiliário	Cadeira estofada com braço retrátil	500
5	Mesa retangular	Mobiliário	Mesa 1,80m x 0,70m para palestras	50
6	Notebook	Informática	Notebook i5 com Windows 11	15
7	Ponto de acesso Wi-Fi	Informática	Access point com suporte a 100 conexões	10
8	Gerador de energia	Infraestrutura	Gerador a diesel 50 kVA	3
9	Tendas 5x5m	Infraestrutura	Tenda sanfonada resistente à chuva	20
10	Banner/Totem	Marketing	Banner retrátil 0,80m x 2,00m	30
\.


--
-- TOC entry 5122 (class 0 OID 16497)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nome, cpf, email, telefone, data_nascimento) FROM stdin;
1	Ana Lima	11122233344	ana.lima@email.com	(85) 91111-1111	1995-03-12
2	Bruno Sousa	22233344455	bruno.sousa@email.com	(85) 92222-2222	1998-07-24
3	Carla Mendes	33344455566	carla.mendes@email.com	(85) 93333-3333	2000-01-05
4	Diego Ferreira	44455566677	diego.ferreira@email.com	(85) 94444-4444	1997-11-30
5	Eduarda Costa	55566677788	eduarda.costa@email.com	(85) 95555-5555	2001-06-18
6	Felipe Araújo	66677788899	felipe.araujo@email.com	(85) 96666-6666	1999-09-09
7	Gabriela Rocha	77788899900	gabriela.rocha@email.com	(85) 97777-7777	2002-04-22
8	Henrique Oliveira	88899900011	henrique.o@email.com	(85) 98888-8888	1996-12-03
9	Isabela Martins	99900011122	isabela.m@email.com	(85) 99999-9999	2003-08-14
10	João Pedro Silva	10011122233	joao.pedro@email.com	(85) 90000-0000	1994-02-27
11	Lívia Almada	12312312300	livia.almada@ufc.br	(85) 93100-0001	1985-05-10
12	Marcos Vinicius	32132132100	marcos.v@ufc.br	(85) 93100-0002	1980-11-20
13	Patrícia Duarte	45645645600	patricia.d@ufc.br	(85) 93100-0003	1978-03-15
14	Ricardo Nunes	78978978900	ricardo.n@ufc.br	(85) 93100-0004	1990-07-07
15	Sabrina Torres	98798798700	sabrina.t@ufc.br	(85) 93100-0005	1983-09-01
\.


--
-- TOC entry 5139 (class 0 OID 16687)
-- Dependencies: 237
-- Data for Name: utiliza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utiliza (id_evento, id_recurso, qtd_utilizada) FROM stdin;
1	1	4
1	6	30
1	7	3
2	2	5
2	4	150
3	1	2
3	5	10
4	9	8
5	9	5
6	3	1
7	1	6
9	9	10
\.


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 233
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avaliacao_id_avaliacao_seq', 10, true);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 11, true);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 229
-- Name: evento_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_id_evento_seq', 12, true);


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 231
-- Name: inscricao_id_inscricao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_id_inscricao_seq', 15, true);


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 225
-- Name: local_id_local_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.local_id_local_seq', 11, true);


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 227
-- Name: recurso_id_recurso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recurso_id_recurso_seq', 11, true);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 15, true);


--
-- TOC entry 4952 (class 2606 OID 16642)
-- Name: avaliacao avaliacao_id_inscricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_id_inscricao_key UNIQUE (id_inscricao);


--
-- TOC entry 4954 (class 2606 OID 16640)
-- Name: avaliacao avaliacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_pkey PRIMARY KEY (id_avaliacao);


--
-- TOC entry 4940 (class 2606 OID 16547)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4956 (class 2606 OID 16658)
-- Name: entra_lista_espera entra_lista_espera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_pkey PRIMARY KEY (id_participante, id_evento);


--
-- TOC entry 4946 (class 2606 OID 16588)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4948 (class 2606 OID 16617)
-- Name: inscricao inscricao_id_participante_id_evento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_participante_id_evento_key UNIQUE (id_participante, id_evento);


--
-- TOC entry 4950 (class 2606 OID 16615)
-- Name: inscricao inscricao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (id_inscricao);


--
-- TOC entry 4942 (class 2606 OID 16557)
-- Name: local local_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.local
    ADD CONSTRAINT local_pkey PRIMARY KEY (id_local);


--
-- TOC entry 4958 (class 2606 OID 16676)
-- Name: organiza organiza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_pkey PRIMARY KEY (id_organizador, id_evento);


--
-- TOC entry 4938 (class 2606 OID 16531)
-- Name: organizador organizador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4936 (class 2606 OID 16518)
-- Name: participante participante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4944 (class 2606 OID 16570)
-- Name: recurso recurso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recurso
    ADD CONSTRAINT recurso_pkey PRIMARY KEY (id_recurso);


--
-- TOC entry 4930 (class 2606 OID 16508)
-- Name: usuario usuario_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);


--
-- TOC entry 4932 (class 2606 OID 16510)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4934 (class 2606 OID 16506)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4960 (class 2606 OID 16695)
-- Name: utiliza utiliza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_pkey PRIMARY KEY (id_evento, id_recurso);


--
-- TOC entry 4967 (class 2606 OID 16643)
-- Name: avaliacao avaliacao_id_inscricao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_id_inscricao_fkey FOREIGN KEY (id_inscricao) REFERENCES public.inscricao(id_inscricao) ON DELETE CASCADE;


--
-- TOC entry 4968 (class 2606 OID 16664)
-- Name: entra_lista_espera entra_lista_espera_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 4969 (class 2606 OID 16659)
-- Name: entra_lista_espera entra_lista_espera_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entra_lista_espera
    ADD CONSTRAINT entra_lista_espera_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4963 (class 2606 OID 16594)
-- Name: evento evento_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria) ON DELETE SET NULL;


--
-- TOC entry 4964 (class 2606 OID 16589)
-- Name: evento evento_id_local_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_id_local_fkey FOREIGN KEY (id_local) REFERENCES public.local(id_local) ON DELETE SET NULL;


--
-- TOC entry 4965 (class 2606 OID 16623)
-- Name: inscricao inscricao_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 4966 (class 2606 OID 16618)
-- Name: inscricao inscricao_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4970 (class 2606 OID 16682)
-- Name: organiza organiza_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 4971 (class 2606 OID 16677)
-- Name: organiza organiza_id_organizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organiza
    ADD CONSTRAINT organiza_id_organizador_fkey FOREIGN KEY (id_organizador) REFERENCES public.organizador(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4962 (class 2606 OID 16532)
-- Name: organizador organizador_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4961 (class 2606 OID 16519)
-- Name: participante participante_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4972 (class 2606 OID 16696)
-- Name: utiliza utiliza_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 4973 (class 2606 OID 16701)
-- Name: utiliza utiliza_id_recurso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_id_recurso_fkey FOREIGN KEY (id_recurso) REFERENCES public.recurso(id_recurso) ON DELETE CASCADE;


-- Completed on 2026-07-01 09:07:24

--
-- PostgreSQL database dump complete
--

\unrestrict L9hePFWZhegtGtuJxMdQU4RCdcoUNJFvfmkRHXhcJl8PYGWVgk8036ipPvdSeLS

