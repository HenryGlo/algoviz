# Brief de diseño — algoviz

> Para pasarle a un agente/skill de diseño. Autocontenido: describe el producto,
> la dirección visual deseada para la **landing** y el **dashboard**, el sistema
> visual (temas light/dark) y —importante— las **animaciones** esperadas.

---

## 1. Qué es algoviz

algoviz es una **plataforma web pública y open source** (portfolio) que explica
**algoritmos de machine learning** y **patrones / anti-patrones de software**
**animándolos paso a paso**, con la implementación en varios lenguajes al lado
(hoy: ML en **Python**, algoritmos y patrones en **Ruby**).

La idea técnica que la define: **el algoritmo no anima nada**. Corre en el server
(Ruby) y emite un `trace` — un array de pasos. Ese trace viaja al navegador y un
**Player** (un reproductor con play / pausa / paso / velocidad) lo reproduce,
dibujando cada paso en un `<svg>`. Es como un "video scrubbeable" del algoritmo,
pero generado desde el código real.

Está hecha en **Rails 8 + Hotwire** (Turbo + Stimulus), server-rendered, sin build
de Node. Cualquiera puede contribuir sumando el algoritmo en su lenguaje.

**Tono:** técnico pero amigable y divertido. Debe transmitir "esto lo hizo alguien
que sabe", sin ser frío ni corporativo. Juguetón, con movimiento, "vivo".

---

## 2. Público

- Devs y estudiantes que quieren *entender* un algoritmo, no sólo leer código.
- Reclutadores / colegas mirando el portfolio → tiene que impresionar en 5 segundos.
- Contribuidores open source → el CTA de "sumá tu lenguaje" tiene que ser claro.

---

## 3. Principios de diseño

1. **El movimiento es el producto.** El sitio trata sobre cosas que se animan; la
   UI debería sentirse igual de viva (micro-interacciones, transiciones suaves).
2. **La visualización manda.** El `<svg>` del Player es el héroe de cada pantalla.
   Todo lo demás lo enmarca, no compite.
3. **Amigable > denso.** Aire, jerarquía clara, un paso a la vez.
4. **Dos temas de primera.** Dark y light igual de cuidados, con toggle.
5. **Color con propósito.** Cada categoría tiene su acento; se usa para orientar,
   no para decorar de más.

---

## 4. Landing (home `/`)

**Objetivo:** en un scroll, explicar qué es, mostrarlo funcionando, e invitar a
explorar/contribuir.

Estructura sugerida (podés mejorarla):

1. **Hero split (2 columnas).** Izquierda: título grande con una palabra en
   gradiente animado ("animan solos"), subtítulo, y 2 CTAs (Explorar / Contribuí
   en GitHub). Derecha: **un demo VIVO** — un algoritmo (bubble sort) que se
   ordena solo, en loop, dentro de una "pantalla" oscura con caption "● en vivo".
2. **Cómo funciona** — 3 pasos (trace → Player → renderer) como tarjetas.
3. **Cobertura hoy** — filas Área × Lenguaje, con chips "Python/Ruby" y un chip
   punteado "+ tu lenguaje" que invita a contribuir.
4. **Colaborá (open source)** — bloque con fondo de gradientes suaves y CTA a
   CONTRIBUTING.
5. **Categorías** y **Destacados** — grillas de tarjetas.

**Estilo deseado:** moderno, tipo "dev tool bonito" (piensa Linear / Vercel /
Rauno), tipografía sans grande + detalles en monospace, bordes sutiles, tarjetas
con hover que levanta. Fondo oscuro profundo por defecto.

---

## 5. Dashboard (listado de una categoría `/:categoria` y detalle `/:categoria/:entrada`)

Es donde el usuario navega los algoritmos. Hoy es funcional pero quiero que sea
**más amigable y pulido**.

### Listado de categoría
- **Banner de categoría** arriba: nombre, descripción, contador de entradas, con
  el color de acento de la categoría como toque (gradiente sutil, no invasivo).
- **Chips de filtro por subtipo** (ej: "comparación", "anti-patrón", "patrón"),
  con contador cada uno (ej: "Anti-patrones (4)"). El filtro NO recarga la página
  (usa Turbo Frame) → la transición del re-render debería sentirse suave.
- **Grilla de tarjetas de entrada:** cada tarjeta muestra título, intuición corta,
  nivel (básico/intermedio/avanzado) y tipo (▶ animado / ↔ antes-después).
  Hover con levantada + barra de acento.
- Estado vacío amable cuando un filtro no tiene resultados.

### Detalle de entrada
- Breadcrumb → título → intuición.
- **Player** (la visualización) protagonista, con controles claros (Play/Pausa,
  Paso, Reset, slider de velocidad, contador "5 / 26").
- **Tabs de lenguaje** (Python / Ruby / …) con el código resaltado.
- Nota de complejidad y prosa (Markdown).
- Para patrones Rails: layout "antes / después" a dos columnas (rojo → verde).

**Estilo deseado:** limpio, legible, la vista tiene que "respirar". Que se sienta
un dashboard de aprendizaje amigable, no una tabla de datos.

---

## 6. Sistema visual

- **Temas:** dark (default) y light, ambos completos. Toggle en el header,
  persistente (localStorage), sin flash al cargar. Respetar `prefers-color-scheme`
  cuando el usuario no eligió.
- **La visualización (`<svg>`) va siempre sobre una "pantalla" oscura**, en ambos
  temas, para que las barras/curvas de colores resalten. Sus colores no dependen
  del tema.
- **Color:** base neutra (grises/azulados en dark; casi-blancos en light). Acentos
  por categoría (ej. ML violeta `#b98bff`, Ordenamiento verde `#56d4a0`). Estados
  de la viz: comparar = ámbar, swap = rojo, ordenado = verde.
- **Tipografía:** sans del sistema para UI, monospace para código, captions,
  números y "chrome" técnico.
- **Formas:** radios generosos (10–14px), bordes de 1px sutiles, sombras suaves y
  coloreadas con el acento en hover.

---

## 7. Animaciones (IMPORTANTE — no puede faltar)

El sitio DEBE sentirse animado. Mínimo:

- **Gradiente del título** que se desplaza en loop lento.
- **Punto "pulse"** en el eyebrow y **"live dot"** parpadeando en el demo.
- **Demo del hero auto-reproduciéndose en loop** (el algoritmo ordenándose solo).
- **Hover de tarjetas:** translateY + aparición de barra de acento + sombra.
- **Toggle de tema** con una micro-rotación al hover.
- **Transición suave del filtro** (Turbo Frame) al cambiar de subtipo.
- **Entrada de secciones** al hacer scroll (fade/slide-in sutil), respetando
  `prefers-reduced-motion` (si está activo, sin movimiento).
- **Controles del Player** con feedback claro (estado play/pausa, slider).

Todas las animaciones: suaves, con propósito, nada que maree. `prefers-reduced-motion`
debe desactivar los movimientos no esenciales.

---

## 8. Restricciones técnicas (respetarlas)

- **Rails 8 + Hotwire**, server-rendered. Estilos en CSS plano (Propshaft), JS con
  Stimulus + importmap. **Sin build de Node, sin frameworks JS externos.**
- Las visualizaciones son **SVG** dibujado por módulos JS ("renderers"); un
  `player_controller` de Stimulus las reproduce. No romper esa arquitectura.
- Nada de dependencias pesadas; que siga siendo liviano y rápido.

---

## 9. Entregables esperados del diseño

1. Dirección visual (light + dark) para landing y dashboard.
2. Tokens: paleta, tipografía, espaciado, radios, sombras, duraciones de animación.
3. Specs de componentes: hero, tarjeta de entrada, chips, Player + controles,
   tabs de código, bloque antes/después, banner de categoría.
4. Lista de animaciones con timing/easing.
5. Notas de accesibilidad (contraste AA, foco visible, reduced-motion).
