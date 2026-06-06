#!/usr/bin/env bash
#
# set_app_icons.sh — Asigna iconos personalizados a apps de macOS.
#
# Uso:
#   ./set_app_icons.sh                              # todos los iconos de la carpeta por defecto
#   ./set_app_icons.sh <carpeta>                    # todos los iconos de <carpeta>
#   ./set_app_icons.sh --only <patrón> [patrón...]  # solo aplica iconos cuyo nombre coincida
#   ./set_app_icons.sh <icono> <app>                # un solo icono a una app específica
#
# Ejemplo:
#   ./set_app_icons.sh --only "Microsoft Edge*" "Visual Studio Code" "Microsoft Excel"
#
# La carpeta debe contener archivos .png/.icns/.jpg/.jpeg cuyo nombre (sin
# extensión) coincida con el nombre de la app en /Applications.
#
# Requiere: fileicon (brew install fileicon)

set -euo pipefail

DEFAULT_ICONS_DIR="/Users/darkesthj/icons"

# Auto-elevación: re-ejecuta el script entero con sudo si no es root.
if [[ $EUID -ne 0 ]]; then
  exec sudo --preserve-env=HOME "$0" "$@"
fi

if ! command -v fileicon >/dev/null 2>&1; then
  echo "Error: 'fileicon' no está instalado. Instálalo con: brew install fileicon" >&2
  exit 1
fi

apply_icon() {
  local icon="$1"
  local app="$2"

  if [[ ! -e "$app" ]]; then
    echo "  ✗ No encontrada: $app"
    return 1
  fi

  echo "→ $(basename "$app")"
  local out
  if out="$(fileicon set "$app" "$icon" 2>&1)"; then
    echo "  ✓ Icono aplicado"
  else
    echo "  ✗ Falló: $out"
    return 1
  fi
}

refresh_dock() {
  echo "Refrescando Dock y Finder..."
  killall Dock 2>/dev/null || true
  killall Finder 2>/dev/null || true
}

# Devuelve 0 si $1 coincide con cualquier patrón en el resto de argumentos.
# Si no hay patrones, siempre devuelve 0 (todo coincide).
match_filter() {
  local name="$1"; shift
  [[ $# -eq 0 ]] && return 0
  local pattern
  for pattern in "$@"; do
    # shellcheck disable=SC2053
    [[ $name == $pattern ]] && return 0
  done
  return 1
}

main() {
  # Modo 1 archivo: <icono> <app>
  if [[ $# -eq 2 && -f "$1" && -e "$2" ]]; then
    apply_icon "$1" "$2"
    refresh_dock
    return
  fi

  local dir="$DEFAULT_ICONS_DIR"
  local -a filters=()

  # Parse args
  if [[ $# -gt 0 ]]; then
    if [[ "$1" == "--only" ]]; then
      shift
      filters=("$@")
    else
      dir="$1"
      shift
      if [[ $# -gt 0 && "$1" == "--only" ]]; then
        shift
        filters=("$@")
      fi
    fi
  fi

  if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' no es una carpeta válida." >&2
    exit 1
  fi

  echo "Buscando iconos en: $dir"
  if [[ ${#filters[@]} -gt 0 ]]; then
    echo "Filtros activos: ${filters[*]}"
  fi

  if ! ls "$dir" >/dev/null 2>&1; then
    echo "Error: no se puede leer '$dir'." >&2
    exit 1
  fi

  local applied=0 skipped=0 found=0
  shopt -s nullglob nocaseglob
  for icon in "$dir"/*.png "$dir"/*.icns "$dir"/*.jpg "$dir"/*.jpeg; do
    local name
    name="$(basename "$icon")"
    name="${name%.*}"

    if ! match_filter "$name" "${filters[@]}"; then
      continue
    fi

    found=$((found + 1))
    local app="/Applications/${name}.app"

    if apply_icon "$icon" "$app"; then
      applied=$((applied + 1))
    else
      skipped=$((skipped + 1))
    fi
  done
  shopt -u nullglob nocaseglob

  if [[ $found -eq 0 ]]; then
    echo "Ningún icono coincidió con los filtros (o la carpeta está vacía)."
    exit 1
  fi

  echo
  echo "Resumen: $applied aplicados, $skipped omitidos."
  [[ $applied -gt 0 ]] && refresh_dock
}

main "$@"
