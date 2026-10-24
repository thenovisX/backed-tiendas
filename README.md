# Backend tiendas

Backend reutilizable para webs de tienda + clases/talleres + galería, pensado para **Hostinger** (hosting compartido, sin Composer ni dependencias). Es el mismo backend de la web de Charria Ceramics, sin datos ni marca, listo para montarlo en la próxima web del mismo estilo.

**Qué incluye**

- API REST en **PHP 8 + MySQL** (`api/` + `backend/`).
- **Instalador web**: la primera vez que se abre la web pide los datos de MySQL y crea el usuario del panel. No hay que tocar el `.env`.
- **Tienda**: productos, stock, descuentos, interruptor “Agotado”, cesta lateral y pago con **Stripe Checkout**. Los precios se calculan solo en el servidor.
- **Envíos** con **Packlink PRO** (o tarifa plana / recogida en tienda si no hay Packlink).
- **Clases**: en grupo con plazas por horario, **clases semanales** (todas las semanas de un curso a la vez) y solicitudes de clase privada.
- **Galería** con validación de formato, peso y proporción de las fotos.
- **Panel `/admin`**: pedidos, productos, clases y horarios, reservas, galería, clientes y **Ajustes** (nombre de la tienda, datos de contacto, Stripe, Packlink, envíos y emails). Funciona en el móvil y se puede **instalar como app** (PWA).
- Plantilla de frontend (`plantilla-web/`): cesta (`cart.js` + `cart.css`), página de gracias y un ejemplo de cómo pintar productos, galería, clases y datos de contacto.
- Tests de extremo a extremo (57 comprobaciones) con un Stripe simulado.

La documentación técnica completa (todas las rutas de la API, base de datos, seguridad, variables de entorno) está en **[docs/REFERENCIA.md](docs/REFERENCIA.md)**.

---

## Montarlo en una web nueva

### 1. Copiar el backend al repo de la web

En la raíz del repo de la web nueva (lo que acabará en `public_html`), copia de este repo:

```
.htaccess   .gitignore   api/   backend/   admin/   uploads/
```

y de `plantilla-web/`: `cart.js`, `cart.css`, `gracias.js` y `gracias.html` (adapta esta última al diseño de la web).

No copies `docs/`, `tools/`, `plantilla-web/api.js` ni este README (`.htaccess` bloquea los `.md` igualmente).

### 2. Lo que tiene que tener la web

| Fichero | Para qué |
|---|---|
| `index.html` | Portada. El `.htaccess` la usa como página de inicio. |
| `404.html` | Página de error (la usa el `.htaccess`). |
| `gracias.html` | Stripe vuelve aquí después de pagar. Necesita los elementos `data-thanks-*` (ver la plantilla). |
| `productos.html` | La cesta enlaza aquí cuando está vacía (cámbialo en `cart.js` si la tienda está en otra página). |
| `cart.js` + `cart.css` | Cesta lateral. Cualquier botón con la clase `.cart-btn` la abre, `[data-cart-count]` muestra el número de productos y `window.Cart.add({ id, title, price_cents, img })` añade uno. |
| Tu `script.js` | Pide los datos a `/api` y los pinta. Copia lo que necesites de `plantilla-web/api.js`. |

Rutas que más se usan (todas devuelven `{ "data": … }`):

- `GET /api/products`, `GET /api/gallery`, `GET /api/classes`, `GET /api/site` (nombre y datos de contacto del panel)
- `POST /api/bookings` (reservar plazas → devuelve `checkout_url` de Stripe), `POST /api/bookings/private`, `POST /api/contact`
- La cesta (`cart.js`) ya usa `POST /api/cart/quote`, `/shipping/quote` y `/checkout`.

### 3. Hostinger

1. **hPanel → Bases de datos**: crea una base de datos MySQL y su usuario (apunta nombre, usuario y contraseña).
2. **hPanel → Avanzado → GIT**: conecta el repo de la web a `public_html` y pulsa **Deploy**.
3. Activa el **SSL** del dominio (los pagos lo necesitan).

### 4. Instalar (una sola vez)

Abre la web: te lleva sola a `/admin/setup.html`. Escribe los datos de MySQL y tu email y contraseña para el panel. Si quieres ver la web llena desde el principio, marca “Cargar datos de ejemplo” (luego se borran desde el panel).

### 5. Panel → Ajustes

1. **Datos de la web**: **nombre de la tienda** (sale en el panel, en los emails a clientes y como remitente de los envíos), dirección, horario, email, teléfono y redes.
2. **Stripe**: clave secreta `sk_test_…` y el secreto del webhook `https://tudominio.com/api/webhooks/stripe`. Prueba con la tarjeta `4242 4242 4242 4242`; para cobrar de verdad, cambia a `sk_live_…`.
3. **Packlink PRO** (opcional): API key y remitente. Sin ella se usa la tarifa plana.
4. **Emails**: un buzón del dominio (hPanel → Emails) como remitente y para recibir avisos.

Detalle de cada paso en [docs/REFERENCIA.md → Puesta en marcha](docs/REFERENCIA.md#puesta-en-marcha-en-hostinger-paso-a-paso).

### 6. Personalizar para cada web

| Qué | Dónde |
|---|---|
| Nombre de la tienda | Panel → Ajustes → Datos de la web (no hace falta tocar código) |
| Colores y fuentes del panel | `admin/admin.css` (variables al principio) y la línea de Google Fonts en `admin/index.html` y `admin/setup.html` |
| Icono del panel instalado como app | `admin/icons/*.png` y `admin/manifest.webmanifest` |
| Textos de los emails | `backend/src/Services/Fulfillment.php` y `backend/src/Controllers/BookingController.php` |
| Estilo de la cesta | `cart.css` (variables en `:root`) |
| Prefijos de las referencias | `PE-` pedidos, `CL-` reservas, `CP-` privadas (`Settings::reference(...)` en los controladores) |

---

## Mantenerlo al día con Charria

El backend se sigue desarrollando en la web de Charria (`thenovisX/charriaceramics`). Este repo es una copia genérica: mismo código con estos cambios fijos:

- namespace PHP `Charria\…` → `App\…`, variable `CHARRIA_ENV_FILE` → `APP_ENV_FILE`, claves del navegador `charria-…` → `tienda-…`;
- la marca se sustituye por el ajuste **`SITE_NAME`** (nuevo campo “Nombre de la tienda”);
- iconos, textos del instalador, `.env.example` y datos de ejemplo genéricos.

El fichero **`.charria-sync`** guarda el último commit de Charria incorporado. Para traer los cambios nuevos:

```bash
tools/sincronizar-desde-charria.sh /ruta/a/charriaceramics
git diff            # revisar
git commit -am "Sincronizar con Charria"
```

El script saca el diff del backend de Charria desde ese commit, le aplica los mismos renombres y lo aplica aquí. Lo que no encaje (casi siempre una línea con el nombre de la marca) queda en ficheros `.rej` para resolverlo a mano, y avisa si ha entrado algún texto con “Charria”. También se le puede pedir a Claude: “sincroniza backed-tiendas con Charria”.

Reglas para que no se separen:

- Los cambios del **backend** que sirvan para cualquier web se hacen primero en Charria y se sincronizan aquí.
- Lo que sea solo de Charria (textos, diseño de la web) no pasa por aquí: el script solo mira `admin/`, `api/`, `backend/`, `uploads/`, `.htaccess`, `.gitignore`, `cart.js` y `gracias.js`.
- Si una web nueva mejora el backend, se pasa aquí y, si sirve, también a Charria.

**Estado actual**: incluye Charria hasta `e65694a` (rama de Hostinger con los PR #7 “clases semanales + datos de la web” y #9 “panel en el móvil / app” ya fusionados).

## Pendiente conocido

La revisión de seguridad del backend de Charria señaló dos cosas que todavía no están corregidas en ninguno de los dos repos: el instalador acepta cualquier servidor de base de datos mientras la web no está instalada (debería aceptar solo `localhost`) y se puede acaparar stock o plazas con pagos sin terminar. Cuando se corrijan en Charria, llegarán aquí con la sincronización.

## Desarrollo local y tests

```bash
export APP_ENV_FILE=/ruta/a/mi.env                  # dónde lee/escribe el .env
php -S localhost:8000 backend/dev-router.php        # abre http://localhost:8000 → instalador
```

Tests (crean y borran datos: usa una base de datos de pruebas). En el `.env` de pruebas: `STRIPE_SECRET_KEY=sk_test_mock`, `STRIPE_WEBHOOK_SECRET=whsec_test`, `STRIPE_API_BASE=http://127.0.0.1:8099`, `MAIL_DISABLED=true`.

```bash
php -S 127.0.0.1:8099 -t backend/tests backend/tests/mock-stripe.php &
php -S 127.0.0.1:8000 backend/dev-router.php &
php backend/tests/api-test.php http://127.0.0.1:8000 whsec_test http://127.0.0.1:8099 admin@email contraseña
```
