-- =========================================
-- REMOVER TABELAS ANTIGAS
-- =========================================

DROP TABLE IF EXISTS utiliza CASCADE;
DROP TABLE IF EXISTS participa CASCADE;
DROP TABLE IF EXISTS frequencia CASCADE;
DROP TABLE IF EXISTS aula_coletiva CASCADE;
DROP TABLE IF EXISTS equipamento CASCADE;
DROP TABLE IF EXISTS treino CASCADE;
DROP TABLE IF EXISTS pagamento CASCADE;
DROP TABLE IF EXISTS plano CASCADE;
DROP TABLE IF EXISTS instrutor CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;

-- =========================================
-- TABELA ALUNO
-- =========================================

CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE NOT NULL,
    rua VARCHAR(100),
    numero INT,
    bairro VARCHAR(100),
    cidade VARCHAR(100)
);

COMMENT ON TABLE aluno IS 'Tabela responsável pelo cadastro dos alunos';

COMMENT ON COLUMN aluno.id_aluno IS 'Identificador do aluno';
COMMENT ON COLUMN aluno.nome IS 'Nome completo do aluno';
COMMENT ON COLUMN aluno.cpf IS 'CPF do aluno';
COMMENT ON COLUMN aluno.email IS 'Email do aluno';

-- =========================================
-- TABELA INSTRUTOR
-- =========================================

CREATE TABLE instrutor (
    id_instrutor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

COMMENT ON TABLE instrutor IS 'Tabela responsável pelos instrutores';

-- =========================================
-- TABELA PLANO
-- =========================================

CREATE TABLE plano (
    id_plano SERIAL PRIMARY KEY,
    nome_plano VARCHAR(100) NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    duracao_meses INT NOT NULL,
    descricao VARCHAR(255)
);

COMMENT ON TABLE plano IS 'Tabela dos planos da academia';

-- =========================================
-- TABELA PAGAMENTO
-- =========================================

CREATE TABLE pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    data_pagamento DATE NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    forma_pagamento VARCHAR(50),
    status VARCHAR(50),
    id_aluno INT NOT NULL,
    
    CONSTRAINT fk_pagamento_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno)
);

COMMENT ON TABLE pagamento IS 'Tabela de pagamentos dos alunos';

-- =========================================
-- TABELA TREINO
-- =========================================

CREATE TABLE treino (
    id_treino SERIAL PRIMARY KEY,
    nome_treino VARCHAR(100) NOT NULL,
    objetivo VARCHAR(255),
    nivel VARCHAR(50),
    id_instrutor INT NOT NULL,
    id_aluno INT NOT NULL,

    CONSTRAINT fk_treino_instrutor
        FOREIGN KEY (id_instrutor)
        REFERENCES instrutor(id_instrutor),

    CONSTRAINT fk_treino_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno)
);

COMMENT ON TABLE treino IS 'Tabela responsável pelos treinos';

-- =========================================
-- TABELA EQUIPAMENTO
-- =========================================

CREATE TABLE equipamento (
    id_equipamento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(100),
    status VARCHAR(50),
    data_manutencao DATE
);

COMMENT ON TABLE equipamento IS 'Tabela de equipamentos da academia';

-- =========================================
-- TABELA UTILIZA
-- =========================================

CREATE TABLE utiliza (
    id_treino INT NOT NULL,
    id_equipamento INT NOT NULL,
    observacao VARCHAR(255),

    PRIMARY KEY (id_treino, id_equipamento),

    CONSTRAINT fk_utiliza_treino
        FOREIGN KEY (id_treino)
        REFERENCES treino(id_treino),

    CONSTRAINT fk_utiliza_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES equipamento(id_equipamento)
);

COMMENT ON TABLE utiliza IS 'Relacionamento entre treino e equipamento';

-- =========================================
-- TABELA AULA_COLETIVA
-- =========================================

CREATE TABLE aula_coletiva (
    id_aula SERIAL PRIMARY KEY,
    nome_aula VARCHAR(100) NOT NULL,
    horario TIMESTAMP NOT NULL,
    capacidade_maxima INT,
    id_instrutor INT NOT NULL,

    CONSTRAINT fk_aula_instrutor
        FOREIGN KEY (id_instrutor)
        REFERENCES instrutor(id_instrutor)
);

COMMENT ON TABLE aula_coletiva IS 'Tabela das aulas coletivas';

-- =========================================
-- TABELA PARTICIPA
-- =========================================

CREATE TABLE participa (
    id_aluno INT NOT NULL,
    id_aula INT NOT NULL,
    presenca BOOLEAN,
    data_participacao DATE,

    PRIMARY KEY (id_aluno, id_aula),

    CONSTRAINT fk_participa_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno),

    CONSTRAINT fk_participa_aula
        FOREIGN KEY (id_aula)
        REFERENCES aula_coletiva(id_aula)
);

COMMENT ON TABLE participa IS 'Tabela de participação dos alunos nas aulas';

-- =========================================
-- TABELA FREQUENCIA
-- =========================================

CREATE TABLE frequencia (
    id_frequencia SERIAL PRIMARY KEY,
    data_entrada TIMESTAMP NOT NULL,
    data_saida TIMESTAMP,
    id_aluno INT NOT NULL,

    CONSTRAINT fk_frequencia_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno)
);

COMMENT ON TABLE frequencia IS 'Tabela de frequência dos alunos';







-- =========================================
-- DADOS DE TESTE — ALUNO
-- =========================================

INSERT INTO aluno
(nome, cpf, email, telefone, data_nascimento, rua, numero, bairro, cidade)
VALUES
('Lucas Costa', '11111111111', 'lucas@gmail.com', '31999990001', '2003-05-10', 'Rua A', 10, 'Centro', 'Belo Horizonte'),
('Mariana Silva', '22222222222', 'mariana@gmail.com', '31999990002', '2001-08-15', 'Rua B', 20, 'Savassi', 'Belo Horizonte'),
('João Pedro', '33333333333', 'joao@gmail.com', '31999990003', '1999-02-20', 'Rua C', 30, 'Buritis', 'Belo Horizonte'),
('Fernanda Lima', '44444444444', 'fernanda@gmail.com', '31999990004', '2000-12-01', 'Rua D', 40, 'Centro', 'Contagem'),
('Carlos Henrique', '55555555555', 'carlos@gmail.com', '31999990005', '1998-11-30', 'Rua E', 50, 'Eldorado', 'Contagem'),
('Juliana Souza', '66666666666', 'juliana@gmail.com', '31999990006', '2002-03-11', 'Rua F', 60, 'Funcionários', 'Belo Horizonte'),
('Ricardo Alves', '77777777777', 'ricardo@gmail.com', '31999990007', '1997-07-25', 'Rua G', 70, 'Lourdes', 'Belo Horizonte'),
('Patricia Gomes', '88888888888', 'patricia@gmail.com', '31999990008', '2004-01-05', 'Rua H', 80, 'Alvorada', 'Betim'),
('Gabriel Martins', '99999999999', 'gabriel@gmail.com', '31999990009', '2001-09-09', 'Rua I', 90, 'Industrial', 'Contagem'),
('Amanda Rocha', '10101010101', 'amanda@gmail.com', '31999990010', '2000-06-18', 'Rua J', 100, 'Cabral', 'Contagem');

-- =========================================
-- DADOS DE TESTE — INSTRUTOR
-- =========================================

INSERT INTO instrutor
(nome, cpf, especialidade, telefone, email)
VALUES
('Bruno Oliveira', '11122233344', 'Musculação', '31988880001', 'bruno@academia.com'),
('Camila Fernandes', '22233344455', 'Crossfit', '31988880002', 'camila@academia.com'),
('Diego Martins', '33344455566', 'Pilates', '31988880003', 'diego@academia.com'),
('Larissa Souza', '44455566677', 'Funcional', '31988880004', 'larissa@academia.com'),
('Felipe Rocha', '55566677788', 'Cardio', '31988880005', 'felipe@academia.com');

-- =========================================
-- DADOS DE TESTE — PLANO
-- =========================================

INSERT INTO plano
(nome_plano, valor, duracao_meses, descricao)
VALUES
('Plano Mensal', 120.00, 1, 'Plano válido por 1 mês'),
('Plano Trimestral', 330.00, 3, 'Plano válido por 3 meses'),
('Plano Semestral', 600.00, 6, 'Plano válido por 6 meses'),
('Plano Anual', 1100.00, 12, 'Plano válido por 12 meses');

-- =========================================
-- DADOS DE TESTE — PAGAMENTO
-- =========================================

INSERT INTO pagamento
(data_pagamento, valor, forma_pagamento, status, id_aluno)
VALUES
('2026-05-01', 120.00, 'Cartão', 'Pago', 1),
('2026-05-02', 330.00, 'PIX', 'Pago', 2),
('2026-05-03', 600.00, 'Dinheiro', 'Pago', 3),
('2026-05-04', 1100.00, 'Cartão', 'Pago', 4),
('2026-05-05', 120.00, 'PIX', 'Pendente', 5),
('2026-05-06', 330.00, 'Cartão', 'Pago', 6),
('2026-05-07', 600.00, 'Dinheiro', 'Pago', 7),
('2026-05-08', 120.00, 'PIX', 'Pendente', 8);

-- =========================================
-- DADOS DE TESTE — TREINO
-- =========================================

INSERT INTO treino
(nome_treino, objetivo, nivel, id_instrutor, id_aluno)
VALUES
('Hipertrofia A', 'Ganho de massa', 'Intermediário', 1, 1),
('Emagrecimento', 'Perda de peso', 'Iniciante', 2, 2),
('Funcional Completo', 'Condicionamento', 'Avançado', 4, 3),
('Cardio Intenso', 'Resistência', 'Intermediário', 5, 4),
('Pilates Básico', 'Flexibilidade', 'Iniciante', 3, 5),
('Treino ABC', 'Hipertrofia', 'Avançado', 1, 6),
('Crossfit Power', 'Explosão muscular', 'Avançado', 2, 7),
('Mobilidade', 'Alongamento', 'Iniciante', 3, 8);

-- =========================================
-- DADOS DE TESTE — EQUIPAMENTO
-- =========================================

INSERT INTO equipamento
(nome, tipo, status, data_manutencao)
VALUES
('Esteira', 'Cardio', 'Ativo', '2026-04-10'),
('Bicicleta', 'Cardio', 'Ativo', '2026-04-15'),
('Supino', 'Musculação', 'Ativo', '2026-04-20'),
('Leg Press', 'Musculação', 'Manutenção', '2026-04-05'),
('Halteres', 'Musculação', 'Ativo', '2026-04-25');

-- =========================================
-- DADOS DE TESTE — UTILIZA
-- =========================================

INSERT INTO utiliza
(id_treino, id_equipamento, observacao)
VALUES
(1, 3, 'Uso intenso'),
(1, 5, 'Complemento'),
(2, 1, 'Cardio inicial'),
(2, 2, 'Aquecimento'),
(3, 5, 'Alongamento'),
(4, 1, 'Resistência'),
(5, 5, 'Leve'),
(6, 3, 'Carga pesada');

-- =========================================
-- DADOS DE TESTE — AULA_COLETIVA
-- =========================================

INSERT INTO aula_coletiva
(nome_aula, horario, capacidade_maxima, id_instrutor)
VALUES
('Crossfit', '2026-05-20 08:00:00', 20, 2),
('Pilates', '2026-05-20 10:00:00', 15, 3),
('Funcional', '2026-05-20 18:00:00', 25, 4),
('Spinning', '2026-05-20 19:00:00', 20, 5),
('Musculação Guiada', '2026-05-20 07:00:00', 30, 1);

-- =========================================
-- DADOS DE TESTE — PARTICIPA
-- =========================================

INSERT INTO participa
(id_aluno, id_aula, presenca, data_participacao)
VALUES
(1, 1, TRUE, '2026-05-20'),
(2, 1, TRUE, '2026-05-20'),
(3, 2, TRUE, '2026-05-20'),
(4, 3, FALSE, '2026-05-20'),
(5, 4, TRUE, '2026-05-20'),
(6, 5, TRUE, '2026-05-20'),
(7, 3, TRUE, '2026-05-20'),
(8, 2, FALSE, '2026-05-20');

-- =========================================
-- DADOS DE TESTE — FREQUENCIA
-- =========================================

INSERT INTO frequencia
(data_entrada, data_saida, id_aluno)
VALUES
('2026-05-20 07:00:00', '2026-05-20 08:30:00', 1),
('2026-05-20 08:00:00', '2026-05-20 09:00:00', 2),
('2026-05-20 09:00:00', '2026-05-20 10:30:00', 3),
('2026-05-20 18:00:00', '2026-05-20 19:30:00', 4),
('2026-05-20 19:00:00', '2026-05-20 20:00:00', 5),
('2026-05-20 06:30:00', '2026-05-20 08:00:00', 6),
('2026-05-20 17:00:00', '2026-05-20 18:00:00', 7),
('2026-05-20 20:00:00', '2026-05-20 21:00:00', 8);









-- Q1
-- Listar os alunos da cidade de Belo Horizonte

SELECT nome, email, cidade
FROM aluno
WHERE cidade = 'Belo Horizonte';


-- Q2
-- Listar instrutores das áreas de Musculação e Crossfit

SELECT nome, especialidade
FROM instrutor
WHERE especialidade IN ('Musculação', 'Crossfit');


-- Q3
-- Listar alunos e seus pagamentos

SELECT aluno.nome, pagamento.valor, pagamento.status
FROM aluno
INNER JOIN pagamento
ON aluno.id_aluno = pagamento.id_aluno;


-- Q4
-- Listar alunos participantes das aulas e seus instrutores

SELECT
    aluno.nome AS aluno,
    aula_coletiva.nome_aula,
    instrutor.nome AS instrutor
FROM participa
INNER JOIN aluno
ON participa.id_aluno = aluno.id_aluno
INNER JOIN aula_coletiva
ON participa.id_aula = aula_coletiva.id_aula
INNER JOIN instrutor
ON aula_coletiva.id_instrutor = instrutor.id_instrutor;


-- Q5
-- Listar alunos que não possuem pagamento registrado

SELECT aluno.nome, pagamento.id_pagamento
FROM aluno
LEFT OUTER JOIN pagamento
ON aluno.id_aluno = pagamento.id_aluno
WHERE pagamento.id_pagamento IS NULL;


-- Q6
-- Mostrar quantidade de alunos por cidade

SELECT cidade, COUNT(*) AS quantidade
FROM aluno
GROUP BY cidade
HAVING COUNT(*) >= 1;


-- Q7
-- Listar alunos com pagamentos acima da média

SELECT nome
FROM aluno
WHERE id_aluno IN (
    SELECT id_aluno
    FROM pagamento
    WHERE valor > (
        SELECT AVG(valor)
        FROM pagamento
    )
);


-- Q8
-- Listar alunos que participam de aulas coletivas

SELECT nome
FROM aluno a
WHERE EXISTS (
    SELECT 1
    FROM participa p
    WHERE p.id_aluno = a.id_aluno
);


-- Q9
-- Criar view de pagamentos realizados

DROP VIEW IF EXISTS view_pagamentos_pagos;

CREATE VIEW view_pagamentos_pagos AS
SELECT
    aluno.nome,
    pagamento.valor,
    pagamento.data_pagamento
FROM aluno
INNER JOIN pagamento
ON aluno.id_aluno = pagamento.id_aluno
WHERE pagamento.status = 'Pago';


-- Q10
-- Mostrar quantidade de acessos dos alunos na academia

SELECT
    aluno.nome,
    COUNT(frequencia.id_frequencia) AS total_acessos
FROM aluno
INNER JOIN frequencia
ON aluno.id_aluno = frequencia.id_aluno
GROUP BY aluno.nome
ORDER BY total_acessos DESC;


