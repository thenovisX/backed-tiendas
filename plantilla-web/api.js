/* ==========================================================
   Backend tiendas · ejemplo mínimo de web que usa la API
   Copia lo que necesites a tu script.js. Todas las rutas están en
   docs/REFERENCIA.md → "Referencia de la API".
   ========================================================== */

const API = "api"; // misma web; para otra web: "https://otrodominio.com/api" + CORS_ALLOWED_ORIGINS

async function apiFetch(path, options = {}) {
  const res = await fetch(`${API}/${path}`, {
    ...options,
    headers: { Accept: "application/json", ...(options.body ? { "Content-Type": "application/json" } : {}) },
  });
  const json = await res.json().catch(() => null);
  // Web recién subida sin instalar: primero el instalador
  if (json?.error?.code === "not_installed") location.replace("admin/setup.html");
  if (!res.ok || !json) {
    const err = new Error(json?.error?.message || "No se pudo conectar. Inténtalo de nuevo en unos minutos.");
    err.status = res.status;
    err.fields = json?.error?.fields || {}; // errores por campo (422) para marcar el formulario
    throw err;
  }
  return json.data;
}
const apiPost = (path, body) => apiFetch(path, { method: "POST", body: JSON.stringify(body) });

const esc = (v) => String(v ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const euros = (cents) => (cents / 100).toLocaleString("es-ES", { style: "currency", currency: "EUR" });

/* ---------- Tienda: <div data-catalog></div> ---------- */
async function renderProducts() {
  const box = document.querySelector("[data-catalog]");
  if (!box) return;
  const products = await apiFetch("products");
  box.innerHTML = products.map((p) => `
    <article class="product">
      <img src="${esc(p.images[0]?.url)}" alt="${esc(p.images[0]?.alt || p.title)}" loading="lazy">
      <h3>${esc(p.title)}</h3>
      <p>${p.discount_percent ? `<s>${euros(p.price_cents)}</s> ` : ""}${euros(p.final_price_cents)}</p>
      ${p.sold_out ? "<span>Agotado</span>" : `<button type="button" data-add="${p.id}">Añadir a la cesta</button>`}
    </article>`).join("");
  // cart.js expone window.Cart: la cesta, el envío y el pago con Stripe ya funcionan
  box.addEventListener("click", (e) => {
    const btn = e.target.closest("[data-add]");
    if (!btn) return;
    const p = products.find((x) => x.id === Number(btn.dataset.add));
    window.Cart.add({ id: p.id, title: p.title, price_cents: p.final_price_cents, img: p.images[0]?.url || "" });
  });
}

/* ---------- Galería: <div data-gallery></div> ---------- */
async function renderGallery() {
  const box = document.querySelector("[data-gallery]");
  if (!box) return;
  const items = await apiFetch("gallery");
  box.innerHTML = items.map((g) => `
    <figure><img src="${esc(g.image.thumb_url)}" alt="${esc(g.image.alt || g.title)}" loading="lazy">
      <figcaption>${esc(g.title)} · ${esc(g.technique)} · ${esc(g.year)}</figcaption></figure>`).join("");
}

/* ---------- Clases en grupo: <div data-classes></div> ---------- */
async function renderClasses() {
  const box = document.querySelector("[data-classes]");
  if (!box) return;
  const { group } = await apiFetch("classes");
  box.innerHTML = group.map((c) => `
    <article>
      <h3>${esc(c.title)}</h3><p>${esc(c.description)}</p>
      <ul>${c.sessions.map((s) => `
        <li>${esc(s.starts_at)} · ${euros(s.price_cents)} · ${s.seats_left} plazas
          ${s.seats_left > 0 ? `<button type="button" data-book="${s.id}">Reservar</button>` : "Completo"}</li>`).join("")}
      </ul>
    </article>`).join("");
  box.addEventListener("click", async (e) => {
    const btn = e.target.closest("[data-book]");
    if (!btn) return;
    // En una web real, pide nombre y email en un formulario
    const name = prompt("Tu nombre");
    const email = prompt("Tu email");
    if (!name || !email) return;
    try {
      const res = await apiPost("bookings", { session_id: Number(btn.dataset.book), seats: 1, customer: { name, email, phone: "" } });
      location.href = res.checkout_url; // pago en Stripe → vuelve a gracias.html
    } catch (err) { alert(err.message); }
  });
}

/* ---------- Datos de la web (Panel → Ajustes): <span data-site="phone"></span> ---------- */
async function renderSite() {
  const site = await apiFetch("site");
  document.querySelectorAll("[data-site]").forEach((el) => {
    const value = site[el.dataset.site];
    if (value) el.textContent = value; // vacío en el panel = se queda el texto del HTML
  });
}

/* ---------- Contacto: <form data-contact> con name, email, reason, message ---------- */
document.querySelector("[data-contact]")?.addEventListener("submit", async (e) => {
  e.preventDefault();
  const f = e.target.elements;
  try {
    await apiPost("contact", { name: f.name.value, email: f.email.value, reason: f.reason.value, message: f.message.value });
    e.target.reset();
    alert("Mensaje enviado");
  } catch (err) { alert(err.message); }
});

Promise.all([renderProducts(), renderGallery(), renderClasses(), renderSite()]).catch((err) => console.error(err));
