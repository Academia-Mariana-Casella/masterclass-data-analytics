-- ============================================================================
-- Proyecto 2: Ventas por mes con SQL (PostgreSQL)
-- Masterclass Data Analytics con Python — Academia MC
-- Parte C del guion: "Comparación con SQL" (3 min)
--
-- Resuelve exactamente la misma pregunta que el notebook de Pandas
-- (notebook_pandas.ipynb), pero desde una base de datos en vez de un CSV.
-- ============================================================================

-- --------------------------------------------------------------------------
-- 0. Preparación (correr una sola vez, antes de la clase)
-- --------------------------------------------------------------------------

DROP TABLE IF EXISTS ventas;

CREATE TABLE ventas (
    id_venta    TEXT PRIMARY KEY,
    fecha       DATE NOT NULL,
    canal       TEXT NOT NULL,
    categoria   TEXT NOT NULL,
    monto       NUMERIC,              -- puede ser NULL: ventas sin monto registrado
    vendedor    TEXT NOT NULL
);

-- Postgres necesita saber que la fecha del CSV viene en formato día/mes/año
-- ANTES de cargar los datos, si no los interpreta mal (o directamente falla).
SET datestyle = 'ISO, DMY';

-- Cargar el mismo archivo ventas.csv que se usa en el notebook de Pandas.
-- Ajustar la ruta si el archivo está en otra carpeta.
\COPY ventas FROM 'ventas.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');


-- --------------------------------------------------------------------------
-- 1. Entender el archivo (equivalente a ventas.head() y ventas.dtypes)
-- --------------------------------------------------------------------------

SELECT * FROM ventas LIMIT 8;

SELECT
    COUNT(*)                                   AS filas,
    MIN(fecha)                                 AS fecha_desde,
    MAX(fecha)                                 AS fecha_hasta
FROM ventas;


-- --------------------------------------------------------------------------
-- 2. Revisar los montos faltantes (equivalente a ventas['monto'].isna().sum())
-- --------------------------------------------------------------------------

SELECT
    COUNT(*) FILTER (WHERE monto IS NULL)                              AS ventas_sin_monto,
    COUNT(*)                                                           AS total_ventas,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE monto IS NULL) / COUNT(*), 1
    )                                                                   AS porcentaje_faltante
FROM ventas;

-- Igual que en Pandas: estas filas NO se completan con 0. Al agrupar y sumar
-- con SUM(monto), SQL ya ignora los NULL automáticamente (no hace falta filtrar
-- a mano), pero las dejamos documentadas arriba.


-- --------------------------------------------------------------------------
-- 3. Ventas por mes (equivalente a ventas.groupby('mes')['monto'].sum())
-- --------------------------------------------------------------------------

SELECT
    TO_CHAR(fecha, 'YYYY-MM')          AS mes,
    SUM(monto)                         AS monto_total,
    COUNT(*)                           AS cantidad_ventas,
    COUNT(*) FILTER (WHERE monto IS NULL) AS ventas_sin_monto_en_el_mes
FROM ventas
GROUP BY TO_CHAR(fecha, 'YYYY-MM')
ORDER BY mes;


-- --------------------------------------------------------------------------
-- 4. Mes de mayor venta (equivalente a ventas_por_mes.idxmax())
-- --------------------------------------------------------------------------

SELECT
    TO_CHAR(fecha, 'YYYY-MM')  AS mes,
    SUM(monto)                 AS monto_total
FROM ventas
GROUP BY TO_CHAR(fecha, 'YYYY-MM')
ORDER BY monto_total DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- 5. Chequeo de períodos completos (equivalente al chequeo de "último día con
--    datos por mes" del notebook) — para no comparar un mes completo contra
--    uno que recién empezó.
-- --------------------------------------------------------------------------

SELECT
    TO_CHAR(fecha, 'YYYY-MM')   AS mes,
    MAX(EXTRACT(DAY FROM fecha)) AS ultimo_dia_con_datos
FROM ventas
GROUP BY TO_CHAR(fecha, 'YYYY-MM')
ORDER BY mes;

-- ============================================================================
-- Para la clase en vivo: mostrar el punto 3 al lado del gráfico que salió del
-- notebook de Pandas. Los números de monto_total por mes tienen que coincidir
-- (son el mismo dataset, mismo criterio de montos faltantes).
-- ============================================================================
