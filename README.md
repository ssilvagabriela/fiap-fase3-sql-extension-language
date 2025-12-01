# Fase 3 – SQL Extension Language (FIAP)

## Sobre o Projeto

Nesta fase avançamos para o uso de **SQL estendido (PL/SQL)**, aprofundando conceitos essenciais de governança, integridade, segurança da informação e consistência do negócio.

A atividade da fase desafiou o grupo a:

* escrever um **bloco PL/SQL completo**, com cursor nomeado, loop, transformações e INSERT;
* criar consultas de **agrupamento e contagem de chamados** por categoria;
* elaborar uma **análise de LGPD**, sigilo e proteção de dados;
* aplicar recomendações reais de segurança e boas práticas.

O resultado fortaleceu competências como:
- programação procedural SQL
- análise crítica do ciclo de vida dos dados
- segurança e privacidade
- consistência transacional
- sigilo e propriedade dos dados
- governança alinhada à LGPD

---

## Estrutura do Repositório

```
/sql
   Arquivo_2_2_Desafio1.sql           → Bloco PL/SQL completo (cursor + loop + transformações + insert)
   Arquivo_3_2_Desafio2 (DQL).sql     → Consulta SQL com agrupamento e contagem por categoria

/docs
   Arquivo_1_1_componentes.txt        → Componentes do grupo
   Arquivo 2_1_Desafio1.docx          → Evidências do bloco PL/SQL
   Arquivo 3_1_Desafio2 (DQL).docx    → Evidências das consultas SQL
   Arquivo 4_Ampliando a consistencia do negocio.docx → Análise LGPD e recomendações de segurança

README.md
```

---

# Bloco PL/SQL – Cursor, Loop e Transformações

O arquivo **Arquivo_2_2_Desafio1.sql** contém o bloco PL/SQL criado pelo grupo:

Ele:

* declara um cursor combinando **produto, cliente, SAC e localização**;
* utiliza `LOOP ... FETCH` para processar cada registro;
* transforma os dados:

  * cálculo de lucro unitário
  * reclassificação textual do tipo de SAC (`'S' → Sugestão`, `'D' → Dúvida`, `'E' → Elogio`)
* insere tudo na tabela **MC_SGV_OCORRENCIA_SAC**;
* finaliza com `COMMIT`.

Exemplo real do bloco (trecho):

```sql
DECLARE
  CURSOR cur_sac IS
    SELECT 
      sac.NR_SAC, sac.DT_ABERTURA_SAC, sac.HR_ABERTURA_SAC,
      sac.TP_SAC, prod.CD_PRODUTO, prod.DS_PRODUTO,
      prod.VL_UNITARIO, prod.VL_PERC_LUCRO,
      est.SG_ESTADO, est.NM_ESTADO,
      cli.NR_CLIENTE, cli.NM_CLIENTE
    FROM mc_sgv_sac sac
    JOIN mc_produto prod ON sac.CD_PRODUTO = prod.CD_PRODUTO
    ...
```



Esse exercício representa um cenário real de **ETL dentro do banco**, reforçando lógica procedural e consistência de negócio.

---

# Consultas SQL com Agrupamento (DQL)

O arquivo **Arquivo_3_2_Desafio 2 (DQL).sql** contém uma consulta completa que:

* agrupa ocorrências por **categoria de produto**;
* faz LEFT JOIN para incluir categorias sem chamados;
* retorna contagem total de SAC por categoria;
* ordena as categorias por código.

Trecho real:

```sql
SELECT
    cp.cd_categoria,
    cp.ds_categoria,
    COUNT(s.nr_sac) AS total_chamados
FROM mc_categoria_prod cp
LEFT JOIN mc_produto p ON cp.cd_categoria = p.cd_categoria
LEFT JOIN mc_sgv_sac s ON p.cd_produto = s.cd_produto
GROUP BY cp.cd_categoria, cp.ds_categoria
ORDER BY cp.cd_categoria;
```



Essa consulta demonstra domínio de:
- agrupamento
- contagem
- LEFT JOIN
- ordenação
- leitura crítica de dados

---

# Análise LGPD & Recomendações de Segurança

O documento **Arquivo 4_Ampliando a consistencia do negocio.docx** contém:

* explicação sobre o papel da TI na LGPD
* aplicação prática em plataformas de e-commerce
* boas práticas como MFA, backup criptografado, data mapping, privacy by design
* recomendações acionáveis
* definição de dados sensíveis
* exemplos de anonimização (CPF, endereço)

O conteúdo reforça o que o PPC do curso aponta como fundamental:
**ética, proteção de dados, governança, segurança e responsabilidade social**.

---

# Componentes do Grupo

* Carlos Vinícius Rodrigues Silva
* Gabriela Sena da Silva
* Gustavo Almeira Scardini
* Tatiana Espinola
* Vitor Fernandes Antunes

---

# Principais Aprendizados da Fase

✔ Criar blocos PL/SQL com cursor, loop, transformação e insert

✔ Elaborar consultas avançadas com agrupamento e JOIN

✔ Tratar dados com foco em segurança e confiabilidade

✔ Aplicar princípios de governança e LGPD

✔ Relacionar práticas de segurança à realidade de e-commerce

✔ Interpretar regras de negócio e convertê-las em lógica procedural

✔ Compreender o papel da TI na privacidade e proteção de dados

---

# 📩 Contato

**Gabriela Sena da Silva**

🔗 LinkedIn: [https://www.linkedin.com/in/gabrielasena](https://www.linkedin.com/in/gabrielasena)

📧 [gabisena@outlook.com](mailto:gabisena@outlook.com)


Se quiser trocar ideias sobre PL/SQL, governança, LGPD ou Data Science, estou à disposição!
