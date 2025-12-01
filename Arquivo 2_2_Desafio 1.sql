DECLARE
  CURSOR cur_sac IS
    SELECT 
      sac.NR_SAC,
      sac.DT_ABERTURA_SAC,
      sac.HR_ABERTURA_SAC,
      sac.TP_SAC,
      prod.CD_PRODUTO,
      prod.DS_PRODUTO,
      prod.VL_UNITARIO,
      prod.VL_PERC_LUCRO,
      est.SG_ESTADO,
      est.NM_ESTADO,
      cli.NR_CLIENTE,
      cli.NM_CLIENTE
    FROM mc_sgv_sac sac
    JOIN mc_produto prod ON sac.CD_PRODUTO = prod.CD_PRODUTO
    JOIN mc_cliente cli ON sac.NR_CLIENTE = cli.NR_CLIENTE
    JOIN mc_end_cli endcli ON cli.NR_CLIENTE = endcli.NR_CLIENTE
    JOIN mc_logradouro log ON endcli.CD_LOGRADOURO_CLI = log.CD_LOGRADOURO
    JOIN mc_bairro bai ON log.CD_BAIRRO = bai.CD_BAIRRO
    JOIN mc_cidade cid ON bai.CD_CIDADE = cid.CD_CIDADE
    JOIN mc_estado est ON cid.SG_ESTADO = est.SG_ESTADO;

  -- Declaração das variáveis que irão receber os dados de cada linha do cursor
  v_nr_sac                mc_sgv_sac.NR_SAC%TYPE;
  v_dt_abertura           mc_sgv_sac.DT_ABERTURA_SAC%TYPE;
  v_hr_abertura           mc_sgv_sac.HR_ABERTURA_SAC%TYPE;
  v_tp_sac                mc_sgv_sac.TP_SAC%TYPE;
  v_cd_produto            mc_produto.CD_PRODUTO%TYPE;
  v_ds_produto            mc_produto.DS_PRODUTO%TYPE;
  v_vl_unitario_produto   mc_produto.VL_UNITARIO%TYPE;
  v_vl_perc_lucro         mc_produto.VL_PERC_LUCRO%TYPE;
  v_sg_estado             mc_estado.SG_ESTADO%TYPE;
  v_nm_estado             mc_estado.NM_ESTADO%TYPE;
  v_nr_cliente            mc_cliente.NR_CLIENTE%TYPE;
  v_nm_cliente            mc_cliente.NM_CLIENTE%TYPE;

   -- Transformações
   v_vl_unitario_lucro_produto_transformado      NUMBER(10,2);
   v_ds_tipo_classificacao_sac_transformado      VARCHAR2(20);
BEGIN
   OPEN cur_sac;
   LOOP
      FETCH cur_sac INTO
         v_nr_sac,
         v_dt_abertura,
         v_hr_abertura,
         v_tp_sac,
         v_cd_produto,
         v_ds_produto,
         v_vl_unitario_produto,
         v_vl_perc_lucro,
         v_sg_estado,
         v_nm_estado,
         v_nr_cliente,
         v_nm_cliente;

      EXIT WHEN cur_sac%NOTFOUND;

      -- Transformações
      v_vl_unitario_lucro_produto_transformado := (v_vl_perc_lucro / 100) * v_vl_unitario_produto;
      
      v_ds_tipo_classificacao_sac_transformado := CASE v_tp_sac
                                                        WHEN 'S' THEN 'Sugestão'
                                                        WHEN 'D' THEN 'Dúvida'
                                                        WHEN 'E' THEN 'Elogio'
                                                        ELSE 'CLASSIFICAÇÃO INVÁLIDA'
                                                    END;

      -- Inserção
      INSERT INTO MC_SGV_OCORRENCIA_SAC (
         NR_OCORRENCIA_SAC,
         DT_ABERTURA_SAC,
         HR_ABERTURA_SAC,
         DS_TIPO_CLASSIFICACAO_SAC,
         CD_PRODUTO,
         DS_PRODUTO,
         VL_UNITARIO_PRODUTO,
         VL_PERC_LUCRO,
         VL_UNITARIO_LUCRO_PRODUTO,
         SG_ESTADO,
         NM_ESTADO,
         NR_CLIENTE,
         NM_CLIENTE
      ) VALUES (
         v_nr_sac,
         v_dt_abertura,
         v_hr_abertura,
         v_ds_tipo_classificacao_sac_transformado,
         v_cd_produto,
         v_ds_produto,
         v_vl_unitario_produto,
         v_vl_perc_lucro,
         v_vl_unitario_lucro_produto_transformado,
         v_sg_estado,
         v_nm_estado,
         v_nr_cliente,
         v_nm_cliente
      );
   END LOOP;
   CLOSE cur_sac;

   COMMIT;
END;

