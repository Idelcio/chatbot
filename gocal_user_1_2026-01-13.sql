-- ======================================================================
-- SQL de Importação de Instrumentos - Sistema Gocal
-- Gerado em: 2026-01-13 08:45:57
-- Total de instrumentos: 9
-- ======================================================================


SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET AUTOCOMMIT = 0;
START TRANSACTION;


-- ======================================================================
-- Instrumento #1: BL-002
-- =======================================================================

-- Instrumento: BL-002 - Balança - Digital Classe III
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('BL-002', 'Balança - Digital Classe III', 'METTLER TOLEDO', 'IND 236', 'B842619669', 'Balança - Digital Classe III', 12, 'AV UNISINOS, 950 Cristo Rei - São Leopoldo/RS', 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'Balança - Digital Classe III', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_0 = LAST_INSERT_ID();


-- Grandezas do instrumento BL-002

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_0, '["QPC023 - Calibração de Balança"]', '0,20', True, NULL, NULL, 'Método de comparação com pesos padrão e massas', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #2: BL-001
-- =======================================================================

-- Instrumento: BL-001 - Balança - Digital Classe I
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('BL-001', 'Balança - Digital Classe I', 'GEHAKA', 'AG200', '18030570001004', 'Balança - Digital Classe I', 12, 'AV UNISINOS, 950 Cristo Rei - São Leopoldo/RS', 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'Balança - Digital Classe I', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_1 = LAST_INSERT_ID();


-- Grandezas do instrumento BL-001

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_1, '["QPC023 - Calibração de Balança"]', '18030570001004', True, NULL, NULL, 'Método de comparação com pesos padrão e massas', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #3: ALT-001
-- =======================================================================

-- Instrumento: ALT-001 - Medidor de Altura de 0 a 300 mm, com resolução de 0,01 mm - Digital
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('ALT-001', 'Medidor de Altura de 0 a 300 mm, com resolução de 0,01 mm - Digital', 'DIGIMESS', NULL, '1804280', 'Medidor de Altura de 0 a 300 mm, com resolução de 0,01 mm - Digital', 12, 'AV UNISINOS, 950 Cristo Rei - São Leopoldo/RS', 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'Medidor de Altura de 0 a 300 mm, com resolução de 0,01 mm - Digital', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_2 = LAST_INSERT_ID();


-- Grandezas do instrumento ALT-001

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_2, '["QPC047 - Calibração de Micrometros Internos"]', '1804280', True, 'mm', 'mm 0,01', 'Comparação com anel liso cilíndrico / Comparação com máquina de medição linear', 1, '0 a 300 mm', NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #4: CVZ 002
-- =======================================================================

-- Instrumento: CVZ 002 - Medidor de vazão volumétrica de líquidos
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('CVZ 002', 'Medidor de vazão volumétrica de líquidos', NULL, NULL, NULL, 'Medidor de vazão volumétrica de líquidos', 12, 'AV UNISINOS, 950 São Leopoldo RS', 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'Medidor de vazão volumétrica de líquidos', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_3 = LAST_INSERT_ID();


-- Grandezas do instrumento CVZ 002

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_3, '["A calibração foi realizada conforme procedimento PSQ-VAZ.04 revisões 006, pelo método comparativo com medidor de vazão de"]', '0,20', True, NULL, NULL, 'comparativo com medidor de vazão de', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #5: PS001
-- =======================================================================

-- Instrumento: PS001 - PESO PADRÃO
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('PS001', 'PESO PADRÃO', 'NÃO IDENTIFICADO', NULL, NULL, 'PESO PADRÃO', 12, NULL, 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'PESO PADRÃO', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_4 = LAST_INSERT_ID();


-- Grandezas do instrumento PS001

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_4, '["PSQ-MAS.04 revisão 002, pelo método de substituição dupla \"ABBA\". O"]', '0,20', True, NULL, NULL, 'de substituição dupla "ABBA". O', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #6: PS003
-- =======================================================================

-- Instrumento: PS003 - PESO PADRÃO
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('PS003', 'PESO PADRÃO', 'NÃO IDENTIFICADO', NULL, NULL, 'PESO PADRÃO', 12, NULL, 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'PESO PADRÃO', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_5 = LAST_INSERT_ID();


-- Grandezas do instrumento PS003

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_5, '["PSQ-MAS.04 revisão 002, pelo método de substituição dupla \"ABBA\". O"]', '0,20', True, NULL, NULL, 'de substituição dupla "ABBA". O', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #7: PS002
-- =======================================================================

-- Instrumento: PS002 - PESO PADRÃO
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('PS002', 'PESO PADRÃO', 'NÃO IDENTIFICADO', NULL, NULL, 'PESO PADRÃO', 12, NULL, 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'PESO PADRÃO', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_6 = LAST_INSERT_ID();


-- Grandezas do instrumento PS002

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_6, '["PSQ-MAS.04 revisão 002, pelo método de substituição dupla \"ABBA\". O"]', '0,20', True, NULL, NULL, 'de substituição dupla "ABBA". O', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #8: CVZ 001
-- =======================================================================

-- Instrumento: CVZ 001 - Transmissor de vazão
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('CVZ 001', 'Transmissor de vazão', NULL, NULL, NULL, 'Transmissor de vazão', 12, 'Av. Unisinos, 950 - São Leopoldo - RS', 'OTIMIZARE SISTEMAS INTELIGENTE LTDA', 'Sem Calibração', 'Transmissor de vazão', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_7 = LAST_INSERT_ID();


-- Grandezas do instrumento CVZ 001

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_7, '["A calibração foi realizada conforme procedimento PSQ-VAZ.04 revisões 006, pelo método comparativo com medidor de vazão de"]', '0,20', True, NULL, NULL, 'comparativo com medidor de vazão de', 1, NULL, NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- ======================================================================
-- Instrumento #9: MU004
-- =======================================================================

-- Instrumento: MU004 - Multímetro
INSERT INTO instrumentos (identificacao, nome, fabricante, modelo, numero_serie, descricao, periodicidade, departamento, responsavel, status, tipo_familia, serie_desenv, criticidade, motivo_calibracao, quantidade, user_id, responsavel_cadastro_id, created_at, updated_at)
VALUES ('MU004', 'Multímetro', 'FLUKE', '15B+', '59055523WS', 'Multímetro', 12, 'AV UNISINOS, 950 Cristo Rei - São Leopoldo/RS', 'OTIMIZARE SISTEMAS INTELIGENTES LTDA', 'Sem Calibração', 'Multímetro', NULL, NULL, 'Calibração Periódica', 1, 1, 1, '2026-01-13 08:45:57', '2026-01-13 08:45:57');

SET @instrumento_id_8 = LAST_INSERT_ID();


-- Grandezas do instrumento MU004

INSERT INTO grandezas (instrumento_id, servicos, tolerancia_processo, tolerancia_simetrica, unidade, resolucao, criterio_aceitacao, regra_decisao_id, faixa_nominal, classe_norma, classificacao, faixa_uso, created_at, updated_at)
VALUES (@instrumento_id_8, '["QPC081 - Calibração de Instrumentos Analógicos e Digitais de Medição na Área de Eletricidade"]', '59055523', True, 'm', 'm 0,1', 'Comparação com padrão de referência.', 1, '0 a 400 m', NULL, NULL, NULL, '2026-01-13 08:45:57', '2026-01-13 08:45:57');


-- Finalização
COMMIT;
SET FOREIGN_KEY_CHECKS=1;


-- Resumo:
-- [OK] 9 instrumentos inseridos
-- [OK] 9 grandezas inseridas
