--- Objetivo: Listar os clientes que possuem telefone ou e-mail não preenchidos (nulos) e que já realizaram pedidos pagos via PIX.
SELECT 
    c.nome AS cliente,
    COALESCE(c.telefone, 'Telefone não informado') AS telefone,
    COALESCE(c.email, 'E-mail não informado') AS email
FROM cliente c
WHERE (c.telefone IS NULL OR c.email IS NULL)
  AND c.id_cliente IN (
      SELECT DISTINCT p.id_cliente
      FROM pedido p
      INNER JOIN pagamento pag ON p.id_pedido = pag.id_pedido
      WHERE pag.forma_pagamento = 'PIX'
        AND p.id_cliente IS NOT NULL
  )
ORDER BY c.nome ASC;