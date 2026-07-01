-- Projeto Fundamentos de Bancos de Dados - Sistema de Gerenciamento de Eventos
-- Script de povoamento do banco de dados
-- Execute somente depois de executar criacao.sql.
-- Cada tabela recebe pelo menos 10 registros.

BEGIN;

-- Dados da tabela usuario
INSERT INTO public.usuario (id_usuario, nome, cpf, email, telefone, data_nascimento) VALUES
    (1, 'Ana Lima', '11122233344', 'ana.lima@email.com', '(85) 91111-1111', '1995-03-12'),
    (2, 'Bruno Sousa', '22233344455', 'bruno.sousa@email.com', '(85) 92222-2222', '1998-07-24'),
    (3, 'Carla Mendes', '33344455566', 'carla.mendes@email.com', '(85) 93333-3333', '2000-01-05'),
    (4, 'Diego Ferreira', '44455566677', 'diego.ferreira@email.com', '(85) 94444-4444', '1997-11-30'),
    (5, 'Eduarda Costa', '55566677788', 'eduarda.costa@email.com', '(85) 95555-5555', '2001-06-18'),
    (6, 'Felipe Araújo', '66677788899', 'felipe.araujo@email.com', '(85) 96666-6666', '1999-09-09'),
    (7, 'Gabriela Rocha', '77788899900', 'gabriela.rocha@email.com', '(85) 97777-7777', '2002-04-22'),
    (8, 'Henrique Oliveira', '88899900011', 'henrique.o@email.com', '(85) 98888-8888', '1996-12-03'),
    (9, 'Isabela Martins', '99900011122', 'isabela.m@email.com', '(85) 99999-9999', '2003-08-14'),
    (10, 'João Pedro Silva', '10011122233', 'joao.pedro@email.com', '(85) 90000-0000', '1994-02-27'),
    (11, 'Lívia Almada', '12312312300', 'livia.almada@ufc.br', '(85) 93100-0001', '1985-05-10'),
    (12, 'Marcos Vinicius', '32132132100', 'marcos.v@ufc.br', '(85) 93100-0002', '1980-11-20'),
    (13, 'Patrícia Duarte', '45645645600', 'patricia.d@ufc.br', '(85) 93100-0003', '1978-03-15'),
    (14, 'Ricardo Nunes', '78978978900', 'ricardo.n@ufc.br', '(85) 93100-0004', '1990-07-07'),
    (15, 'Sabrina Torres', '98798798700', 'sabrina.t@ufc.br', '(85) 93100-0005', '1983-09-01');

-- Dados da tabela categoria
INSERT INTO public.categoria (id_categoria, nome_categoria, descricao) VALUES
    (2, 'Saúde', 'Congressos, workshops e palestras na área da saúde'),
    (3, 'Educação', 'Seminários, cursos e feiras educacionais'),
    (4, 'Cultura', 'Festivais, exposições e eventos culturais diversos'),
    (5, 'Esporte', 'Competições, maratonas e eventos esportivos'),
    (6, 'Negócios', 'Feiras de negócios, empreendedorismo e finanças'),
    (7, 'Meio Ambiente', 'Eventos sobre sustentabilidade e ecologia'),
    (8, 'Gastronomia', 'Festivais gastronômicos, cursos de culinária'),
    (9, 'Música', 'Shows, recitais e festivais musicais'),
    (10, 'Ciência', 'Simpósios, feiras científicas e eventos acadêmicos'),
    (1, 'Tecnologia', 'Eventos relacionados a TI, programação e inovação');

-- Dados da tabela local
INSERT INTO public.local (id_local, nome_local, logradouro, numero, bairro, cep, cidade, capacidade) VALUES
    (1, 'Auditório UFC Quixadá', 'Rua Estevão Remígio de Farias', '1145', 'Centro', '63902373', 'Quixadá', 300),
    (2, 'Centro de Convenções CE', 'Av. Washington Soares', '999', 'Edson Queiroz', '60811341', 'Fortaleza', 2000),
    (4, 'Arena Castelão', 'Av. Alberto Craveiro', '2901', 'Castelão', '60863240', 'Fortaleza', 63000),
    (5, 'Sala de Aulas UFC Quixadá', 'Rua Estevão Remígio de Farias', '1145', 'Centro', '63902373', 'Quixadá', 60),
    (6, 'Espaço Cultural Unifor', 'Av. Washington Soares', '1321', 'Edson Queiroz', '60811905', 'Fortaleza', 400),
    (7, 'Ginásio SESI Quixadá', 'Av. João Pessoa', '500', 'Santo Antônio', '63900000', 'Quixadá', 800),
    (8, 'Hub de Inovação Ceará', 'Av. Heráclito Graça', '330', 'Centro', '60140061', 'Fortaleza', 150),
    (9, 'Parque Adahil Barreto', 'Av. Padre Cícero', 's/n', 'Jardim das Oliveiras', '63905490', 'Quixadá', 500),
    (10, 'Biblioteca Universitária', 'Rua Estevão Remígio de Farias', '1145', 'Centro', '63902373', 'Quixadá', 80),
    (11, 'local novo', 'teste', '111', 'salviano carlos', '63800000', 'quixada', 777);

-- Dados da tabela recurso
INSERT INTO public.recurso (id_recurso, nome_recurso, tipo, descricao, qtde_disponivel) VALUES
    (1, 'Projetor Full HD', 'Audiovisual', 'Projetor 1080p com HDMI e VGA', 10),
    (2, 'Microfone sem fio', 'Audiovisual', 'Microfone UHF com receptor', 20),
    (3, 'Mesa de som', 'Audiovisual', 'Mesa de mixagem 16 canais', 5),
    (4, 'Cadeira auditório', 'Mobiliário', 'Cadeira estofada com braço retrátil', 500),
    (5, 'Mesa retangular', 'Mobiliário', 'Mesa 1,80m x 0,70m para palestras', 50),
    (6, 'Notebook', 'Informática', 'Notebook i5 com Windows 11', 15),
    (7, 'Ponto de acesso Wi-Fi', 'Informática', 'Access point com suporte a 100 conexões', 10),
    (8, 'Gerador de energia', 'Infraestrutura', 'Gerador a diesel 50 kVA', 3),
    (9, 'Tendas 5x5m', 'Infraestrutura', 'Tenda sanfonada resistente à chuva', 20),
    (10, 'Banner/Totem', 'Marketing', 'Banner retrátil 0,80m x 2,00m', 30);

-- Dados da tabela participante
INSERT INTO public.participante (id_usuario, data_cadastro) VALUES
    (1, '2025-01-10'),
    (2, '2025-02-15'),
    (3, '2025-03-01'),
    (4, '2025-03-20'),
    (5, '2025-04-05'),
    (6, '2025-04-18'),
    (7, '2025-05-02'),
    (8, '2025-05-25'),
    (9, '2025-06-10'),
    (10, '2025-06-22');

-- Dados da tabela organizador
INSERT INTO public.organizador (id_usuario, data_vinculacao, area_responsavel) VALUES
    (6, '2025-01-15', 'Logística'),
    (7, '2025-02-10', 'Comunicação'),
    (8, '2025-03-05', 'Infraestrutura'),
    (9, '2025-04-20', 'Credenciamento'),
    (10, '2025-05-12', 'Apoio Técnico'),
    (11, '2020-01-15', 'Tecnologia da Informação'),
    (12, '2018-03-10', 'Engenharia Civil'),
    (13, '2019-07-22', 'Ciências Biomédicas'),
    (14, '2021-09-05', 'Administração'),
    (15, '2022-02-28', 'Artes e Humanidades');

-- Dados da tabela evento
INSERT INTO public.evento (id_evento, titulo, descricao, data, hora_inicio, hora_fim, status, capacidade_max, id_local, id_categoria) VALUES
    (1, 'Hackathon UFC 2025', 'Maratona de programação com desafios reais', '2025-08-15', '08:00:00', '22:00:00', 'concluido', 150, 1, 1),
    (2, 'Semana da Saúde', 'Palestras e workshops sobre saúde preventiva', '2025-09-10', '09:00:00', '17:00:00', 'concluido', 200, 2, 2),
    (3, 'Feira de Educação Inovadora', 'Exposição de metodologias educacionais inovadoras', '2025-10-05', '08:00:00', '18:00:00', 'concluido', 300, 6, 3),
    (4, 'Festival Cultural Quixadá', 'Apresentações culturais e artísticas locais', '2025-11-20', '14:00:00', '22:00:00', 'concluido', 500, 9, 4),
    (5, 'Maratona Sertão Verde', 'Corrida de 10km em trilhas ecológicas', '2025-12-01', '06:00:00', '12:00:00', 'concluido', 400, 9, 5),
    (6, 'Fórum de Empreendedorismo', 'Painéis com empreendedores e investidores', '2026-02-18', '09:00:00', '17:00:00', 'concluido', 180, 8, 6),
    (7, 'Simpósio de IA e Dados', 'Apresentação de pesquisas em inteligência artificial', '2026-04-22', '08:30:00', '18:30:00', 'concluido', 120, 1, 1),
    (8, 'Workshop de Sustentabilidade', 'Oficinas sobre reciclagem e energia renovável', '2026-05-05', '14:00:00', '18:00:00', 'concluido', 80, 10, 7),
    (10, 'Rock no Sertão', 'Show com bandas locais e regionais', '2026-07-12', '18:00:00', '23:00:00', 'planejado', 800, 7, 9),
    (11, 'Congresso de Ciências UFC', 'Apresentações de TCC, IC e pós-graduação', '2026-08-03', '08:00:00', '18:00:00', 'planejado', 250, 1, 10),
    (12, 'Semana de TI Quixadá', 'Palestras e minicursos sobre computação', '2026-09-15', '08:00:00', '18:00:00', 'planejado', 200, 5, 1),
    (9, 'Festival Gastronômico CE', 'Culinária regional e demonstrações ao vivo', '2026-06-28', '11:00:00', '21:00:00', 'em andamento', 600, NULL, 8);

-- Dados da tabela inscricao
INSERT INTO public.inscricao (id_inscricao, data_inscricao, status_inscricao, situacao_presenca, data_hora_presenca, id_participante, id_evento) VALUES
    (1, '2025-08-01', 'confirmada', 'presente', '2025-08-15 08:10:00', 1, 1),
    (2, '2025-08-02', 'confirmada', 'presente', '2025-08-15 08:05:00', 2, 1),
    (3, '2025-08-03', 'confirmada', 'ausente', NULL, 3, 1),
    (4, '2025-09-01', 'confirmada', 'presente', '2025-09-10 09:02:00', 4, 2),
    (5, '2025-09-02', 'confirmada', 'presente', '2025-09-10 09:15:00', 5, 2),
    (6, '2025-09-03', 'cancelada', 'pendente', NULL, 6, 2),
    (7, '2025-10-01', 'confirmada', 'presente', '2025-10-05 08:20:00', 7, 3),
    (8, '2025-10-02', 'confirmada', 'presente', '2025-10-05 08:30:00', 8, 3),
    (9, '2025-11-10', 'confirmada', 'presente', '2025-11-20 14:05:00', 9, 4),
    (10, '2025-11-11', 'confirmada', 'ausente', NULL, 10, 4),
    (11, '2025-11-25', 'confirmada', 'presente', '2025-12-01 06:10:00', 1, 5),
    (12, '2026-02-10', 'confirmada', 'presente', '2026-02-18 09:00:00', 2, 6),
    (13, '2026-04-15', 'confirmada', 'presente', '2026-04-22 08:35:00', 3, 7),
    (14, '2026-05-01', 'ativa', 'pendente', NULL, 4, 9),
    (15, '2026-06-01', 'ativa', 'pendente', NULL, 5, 9);

-- Dados da tabela organiza
INSERT INTO public.organiza (id_organizador, id_evento, funcao_no_evento) VALUES
    (11, 1, 'Coordenador Geral'),
    (12, 2, 'Coordenador Geral'),
    (13, 3, 'Coordenador Geral'),
    (14, 4, 'Coordenador Geral'),
    (15, 5, 'Coordenador Geral'),
    (11, 6, 'Apoio Logístico'),
    (12, 7, 'Coordenador Geral'),
    (13, 8, 'Facilitador'),
    (14, 9, 'Coordenador Geral'),
    (15, 10, 'Produtor Musical');

-- Dados da tabela utiliza
INSERT INTO public.utiliza (id_evento, id_recurso, qtd_utilizada) VALUES
    (1, 1, 4),
    (1, 6, 30),
    (1, 7, 3),
    (2, 2, 5),
    (2, 4, 150),
    (3, 1, 2),
    (3, 5, 10),
    (4, 9, 8),
    (5, 9, 5),
    (6, 3, 1),
    (7, 1, 6),
    (9, 9, 10);

-- Dados da tabela entra_lista_espera
INSERT INTO public.entra_lista_espera (id_participante, id_evento, data_solicitacao, posicao_fila) VALUES
    (6, 1, '2025-08-10', 1),
    (7, 1, '2025-08-11', 2),
    (8, 2, '2025-09-05', 1),
    (9, 2, '2025-09-06', 2),
    (10, 3, '2025-10-03', 1),
    (1, 4, '2025-11-15', 1),
    (2, 5, '2025-11-28', 1),
    (3, 6, '2026-02-12', 1),
    (6, 9, '2026-06-10', 1),
    (7, 9, '2026-06-11', 2);

-- Dados da tabela avaliacao
INSERT INTO public.avaliacao (id_avaliacao, nota, comentario, id_inscricao) VALUES
    (1, 9.5, 'Evento excelente! Desafios muito criativos e equipe bem organizada.', 1),
    (2, 8.0, 'Ótima experiência, mas a comida poderia ser melhor.', 2),
    (3, 9.0, 'Palestras muito relevantes e instrutores qualificados.', 4),
    (4, 7.5, 'Bom conteúdo, porém o espaço estava quente demais.', 5),
    (5, 8.5, 'Exposição bem curada com projetos inovadores.', 7),
    (6, 9.0, 'Adorei as apresentações culturais locais, muito autêntico!', 9),
    (7, 8.0, 'Percurso bonito, mas sinalização poderia melhorar.', 11),
    (8, 9.5, 'Painéis muito ricos, com cases reais de sucesso.', 12),
    (9, 8.5, 'Pesquisas de ponta apresentadas de forma acessível.', 13),
    (10, 7.0, 'Boa organização geral, esperava mais diversidade nos temas.', 8);

-- Ajuste das sequências após os INSERTs
SELECT pg_catalog.setval('public.avaliacao_id_avaliacao_seq', 10, true);
SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 11, true);
SELECT pg_catalog.setval('public.evento_id_evento_seq', 12, true);
SELECT pg_catalog.setval('public.inscricao_id_inscricao_seq', 15, true);
SELECT pg_catalog.setval('public.local_id_local_seq', 11, true);
SELECT pg_catalog.setval('public.recurso_id_recurso_seq', 11, true);
SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 15, true);

COMMIT;
