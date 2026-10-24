#!/usr/bin/env bash
# ==========================================================
# Backend tiendas · trae a este repo los cambios del backend de Charria
#
#   tools/sincronizar-desde-charria.sh /ruta/a/charriaceramics [commit]
#
# - Lee en .charria-sync el último commit de Charria ya incorporado.
# - Saca el diff de Charria desde ese commit hasta [commit] (por defecto HEAD)
#   solo de admin/ api/ backend/ uploads/ .htaccess .gitignore cart.js gracias.js
#   (cart.js y gracias.js van a plantilla-web/).
# - Le aplica los mismos cambios de nombre que se hicieron al copiarlo
#   (namespace Charria → App, CHARRIA_ENV_FILE → APP_ENV_FILE, charria- → tienda-).
# - Lo aplica con --reject: lo que no encaje queda en ficheros *.rej para
#   revisarlo a mano (normalmente líneas con el nombre de la marca).
# - Si todo va bien, guarda el nuevo commit en .charria-sync.
# Revisa siempre el resultado (git diff) antes de hacer commit.
# ==========================================================
set -euo pipefail

SRC="${1:?Uso: $0 /ruta/a/charriaceramics [commit]}"
HERE="$(cd "$(dirname "$0")/.." && pwd)"
STATE="$HERE/.charria-sync"
FROM="$(tr -d '[:space:]' < "$STATE")"
TO="$(git -C "$SRC" rev-parse "${2:-HEAD}")"

if [ "$FROM" = "$TO" ]; then
  echo "Ya está al día con Charria ($TO)."
  exit 0
fi

PATCH="$(mktemp)"
trap 'rm -f "$PATCH"' EXIT

git -C "$SRC" diff --binary "$FROM" "$TO" -- admin api backend uploads .htaccess .gitignore > "$PATCH"
git -C "$SRC" diff --binary --src-prefix=a/plantilla-web/ --dst-prefix=b/plantilla-web/ "$FROM" "$TO" -- cart.js gracias.js >> "$PATCH"

if [ ! -s "$PATCH" ]; then
  echo "Charria ha cambiado, pero nada del backend. Se marca como sincronizado."
  echo "$TO" > "$STATE"
  exit 0
fi

# Mismos renombres que en la copia inicial
sed -i \
  -e 's/namespace Charria;/namespace App;/g' \
  -e 's/Charria\\/App\\/g' \
  -e 's/CHARRIA_ENV_FILE/APP_ENV_FILE/g' \
  -e 's/charria-/tienda-/g' \
  "$PATCH"

echo "Cambios de Charria ${FROM:0:7}..${TO:0:7}:"
git -C "$SRC" log --oneline "$FROM..$TO" -- admin api backend uploads .htaccess .gitignore cart.js gracias.js | sed 's/^/  /'

cd "$HERE"
if git apply --reject --whitespace=nowarn "$PATCH"; then
  echo "$TO" > "$STATE"
  echo "Aplicado sin conflictos. Revisa con 'git diff' y haz commit."
else
  echo "$TO" > "$STATE"
  echo
  echo "Algunas partes no encajaron. Revísalas a mano y borra los .rej:"
  find . -name '*.rej' -not -path './.git/*' | sed 's/^/  /'
fi

# Avisos: restos de la marca que no deberían entrar
if grep -rniE 'charria|ceramics' admin api backend uploads plantilla-web .htaccess >/dev/null 2>&1; then
  echo
  echo "Atención: han entrado textos con la marca Charria. Cámbialos por Settings::siteName() o por texto genérico:"
  grep -rniE 'charria|ceramics' admin api backend uploads plantilla-web .htaccess | cut -c1-160 | sed 's/^/  /'
fi
