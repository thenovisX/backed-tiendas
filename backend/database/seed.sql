-- ==========================================================
-- Datos de ejemplo para ver la web llena nada más instalar
-- (se marca la casilla en el instalador). Se pueden borrar después desde el panel.
-- Solo se insertan si las tablas están vacías (lo hace /api/setup).
-- ==========================================================

SET NAMES utf8mb4;

INSERT INTO images (id, kind, url, width, height, alt) VALUES
  (1,  'product', 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (2,  'product', 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (3,  'product', 'https://images.unsplash.com/photo-1612196808214-b8e1d6145a8c?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (4,  'product', 'https://images.unsplash.com/photo-1604335399105-a0c585fd81a1?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (5,  'product', 'https://images.unsplash.com/photo-1594732832278-abd644401426?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (6,  'product', 'https://images.unsplash.com/photo-1590422749897-47036da0b0ff?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (7,  'product', 'https://images.unsplash.com/photo-1610701596061-2ecf227e85b2?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (8,  'product', 'https://images.unsplash.com/photo-1578500494198-246f612d3b3d?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (9,  'product', 'https://images.unsplash.com/photo-1603204077779-bed963ea7d0e?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (10, 'product', 'https://images.unsplash.com/photo-1631125915902-d8abe9225ff2?auto=format&fit=crop&w=900&q=80', 900, 1125, 'Producto de ejemplo'),
  (11, 'gallery', 'https://images.unsplash.com/photo-1578500494198-246f612d3b3d?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (12, 'gallery', 'https://images.unsplash.com/photo-1610701596061-2ecf227e85b2?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (13, 'gallery', 'https://images.unsplash.com/photo-1603204077779-bed963ea7d0e?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (14, 'gallery', 'https://images.unsplash.com/photo-1631125915902-d8abe9225ff2?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (15, 'gallery', 'https://images.unsplash.com/photo-1607344645866-009c320b63e0?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (16, 'gallery', 'https://images.unsplash.com/photo-1571950484368-7b15b0a5ad46?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (17, 'gallery', 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (18, 'gallery', 'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=1600&q=80', 1600, 1000, 'Foto de ejemplo'),
  (19, 'class',   'https://images.unsplash.com/photo-1544967082-d9d25d867d66?auto=format&fit=crop&w=700&q=80', 700, 875, 'Clase de ejemplo'),
  (20, 'class',   'https://images.unsplash.com/photo-1493106641515-6b5631de4bb9?auto=format&fit=crop&w=700&q=80', 700, 875, 'Clase de ejemplo'),
  (21, 'class',   'https://images.unsplash.com/photo-1556011284-54aa6466d402?auto=format&fit=crop&w=700&q=80', 700, 875, 'Clase de ejemplo'),
  (22, 'class',   'https://images.unsplash.com/photo-1525974160448-038dacadcc71?auto=format&fit=crop&w=700&q=80', 700, 875, 'Clase de ejemplo');

INSERT INTO products (id, slug, title, description, category, price_cents, stock, weight_grams, created_at) VALUES
  (1, 'producto-uno', 'Producto Uno', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría A',  3800,  3, 600,  '2026-10-20 10:00:00'),
  (2, 'producto-dos', 'Producto Dos', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría B', 7200,  2, 1400, '2026-10-18 10:00:00'),
  (3, 'producto-tres', 'Producto Tres', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría C',    2600,  6, 350,  '2026-10-15 10:00:00'),
  (4, 'producto-cuatro', 'Producto Cuatro', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría C',   3200,  5, 800,  '2026-10-12 10:00:00'),
  (5, 'pack-cinco', 'Pack Cinco', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Packs',     11000, 2, 2200, '2026-10-08 10:00:00'),
  (6, 'producto-seis', 'Producto Seis', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría B', 5400,  1, 900,  '2026-10-02 10:00:00'),
  (7, 'producto-siete', 'Producto Siete', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría A',  3400,  4, 550,  '2026-09-26 10:00:00'),
  (8, 'producto-ocho', 'Producto Ocho', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría B', 9500,  1, 2000, '2026-09-19 10:00:00'),
  (9, 'producto-nueve', 'Producto Nueve', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Categoría B', 8400,  1, 1800, '2026-09-10 10:00:00'),
  (10, 'pack-diez', 'Pack Diez', 'Descripción de ejemplo. Cámbiala desde el panel.', 'Packs',     14000, 1, 4000, '2026-09-01 10:00:00');

INSERT INTO product_images (product_id, image_id, sort_order) VALUES
  (1, 1, 0), (2, 2, 0), (3, 3, 0), (4, 4, 0), (5, 5, 0), (6, 6, 0), (7, 7, 0), (8, 8, 0), (9, 9, 0), (10, 10, 0);

INSERT INTO gallery_items (image_id, title, technique, year, sort_order) VALUES
  (11, 'Obra de ejemplo 1', 'Técnica o descripción breve',           '2025', 1),
  (12, 'Obra de ejemplo 2', 'Técnica o descripción breve',  '2025', 2),
  (13, 'Obra de ejemplo 3', 'Técnica o descripción breve',   '2025', 3),
  (14, 'Obra de ejemplo 4', 'Técnica o descripción breve',   '2024', 4),
  (15, 'Obra de ejemplo 5', 'Técnica o descripción breve',      '2024', 5),
  (16, 'Obra de ejemplo 6', 'Técnica o descripción breve',       '2024', 6),
  (17, 'Obra de ejemplo 7', 'Técnica o descripción breve',             '2024', 7),
  (18, 'Obra de ejemplo 8', 'Técnica o descripción breve',              '2023', 8);

INSERT INTO classes (id, slug, kind, title, description, duration_minutes, price_cents, capacity, image_id, sort_order) VALUES
  (1, 'taller-iniciacion', 'group', 'Taller de iniciación', 'Primera toma de contacto: clase práctica en grupo reducido.', 180, 6500,  6, 19, 1),
  (2, 'taller-tecnicas', 'group', 'Taller de técnicas', 'Aprende técnicas básicas para crear tus propias piezas.',       150, 5500,  6, 20, 2),
  (3, 'taller-avanzado', 'group', 'Taller avanzado', 'Sesión para quienes ya tienen experiencia.',  180, 7000,  6, 21, 3),
  (4, 'curso-trimestral', 'group', 'Curso trimestral', 'Doce sesiones semanales para avanzar paso a paso.',                     120, 39000, 6, 22, 4),
  (5, 'privada-1-persona',  'private', '1 persona · 2 h',                    'Clase privada para una persona.',                                    120, 9000,  1, NULL, 10),
  (6, 'privada-2-personas', 'private', '2 personas · 2 h',                   'Clase privada para dos personas.',                                   120, 15000, 2, NULL, 11),
  (7, 'privada-pack-4',     'private', 'Pack 4 sesiones',                    'Cuatro sesiones privadas de 2 horas.',                               480, 32000, 1, NULL, 12);

-- Fechas relativas al día de la instalación para que siempre salgan en el futuro
INSERT INTO class_sessions (class_id, starts_at, label, capacity) VALUES
  (1, TIMESTAMP(CURDATE() + INTERVAL 14 DAY, '10:00:00'), '', 4),
  (2, TIMESTAMP(CURDATE() + INTERVAL 19 DAY, '18:30:00'), '', 2),
  (3, TIMESTAMP(CURDATE() + INTERVAL 28 DAY, '11:00:00'), '', NULL),
  (4, TIMESTAMP(CURDATE() + INTERVAL 10 DAY, '19:00:00'), 'Martes · 12 sesiones', NULL);
