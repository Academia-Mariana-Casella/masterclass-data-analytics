# Masterclass Data Analytics con Python — Academia MC

Una misma pregunta de negocio, **"¿cómo venimos? ¿en qué mes vendimos más?"**, sobre un mismo archivo de ventas (`ventas.csv`), resuelta con tres herramientas distintas. No son tres análisis diferentes: son tres caminos hacia el mismo resultado.

| # | Proyecto | Archivo | Abrir en Colab |
|---|----------|---------|----------------|
| 1 | Análisis con Python y Pandas | `notebook_pandas.ipynb` | [![Abrir en Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Academia-Mariana-Casella/masterclass-data-analytics/blob/main/notebook_pandas.ipynb) |
| 2 | La misma consulta con SQL (PostgreSQL) | `analisis_sql.sql` | — |
| 2b | La misma consulta con SQL (DuckDB, sin instalar nada) | `sql_duckdb.ipynb` | [![Abrir en Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Academia-Mariana-Casella/masterclass-data-analytics/blob/main/sql_duckdb.ipynb) |
| 3 | Mini reporte con indicadores + asistencia de IA | `mini_reporte_ia.ipynb` | [![Abrir en Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Academia-Mariana-Casella/masterclass-data-analytics/blob/main/mini_reporte_ia.ipynb) |

---

## Opción A: Google Colab (recomendada, no hay que instalar nada)

1. Hacé clic en el botón **Abrir en Colab** del proyecto que quieras.
2. Si Colab lo pide, iniciá sesión con tu cuenta de Google.
3. Corré las celdas en orden con **Shift + Enter**, o con *Entorno de ejecución → Ejecutar todas*.

Los notebooks descargan `ventas.csv` directamente desde este repositorio, así que no hace falta subir ningún archivo.

> Para guardar tus cambios, usá *Archivo → Guardar una copia en Drive*.

## Opción B: En tu computadora

Necesitás [Python 3.9 o superior](https://www.python.org/downloads/) y [Git](https://git-scm.com/downloads), o podés descargar el ZIP desde el botón verde **Code → Download ZIP**.

```bash
git clone https://github.com/Academia-Mariana-Casella/masterclass-data-analytics.git
cd masterclass-data-analytics

python -m venv .venv
# Windows:
.venv\Scripts\activate
# Mac / Linux:
source .venv/bin/activate

pip install -r requirements.txt
jupyter lab
```

Se abre el navegador: elegí el notebook y corré las celdas en orden.

## Proyecto 2 con PostgreSQL (opcional)

Si tenés PostgreSQL instalado, desde la carpeta del repo:

```bash
createdb masterclass
psql -d masterclass -f analisis_sql.sql
```

El script crea la tabla `ventas`, carga `ventas.csv` y corre las consultas. Si no tenés Postgres, usá `sql_duckdb.ipynb`: tiene las mismas consultas y da los mismos resultados.

---

## Qué tiene cada proyecto

**1. Pandas:** cargamos el CSV crudo, revisamos columnas y tipos de dato, convertimos la fecha de texto a fecha real y tratamos los montos faltantes sin asumir que valen $0. Después agrupamos por mes y lo graficamos. Ojo: solo tiene sentido comparar meses completos.

**2. SQL:** si los datos estuvieran en una base de datos en vez de un archivo, esta consulta `GROUP BY` responde la misma pregunta. Los totales por mes **coinciden exactamente** con los de Pandas.

**3. Mini reporte + IA:** calculamos tres indicadores (ventas totales, ticket promedio y mes de mayor venta) y le pedimos a una IA que los explique. Después revisamos la respuesta contra los datos. La respuesta de la IA es una ejecución guardada de antemano, así que no necesitás clave de API.

## Los datos

`ventas.csv` es un dataset de ventas ficticio con estas columnas: `id_venta`, `fecha` (día/mes/año), `canal`, `categoria`, `monto` y `vendedor`. Algunas ventas no tienen monto registrado, y eso es a propósito.
