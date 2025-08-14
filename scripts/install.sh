#!/usr/bin/env bash
set -euo pipefail

# TortoSpoof installer: adds GPS spoofing block into ~/.zshrc and installs deps.
# Idempotent: safe to run multiple times.

ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
BLOCK_BEGIN="# --- TortoSpoof GPS BEGIN ---"
BLOCK_END="# --- TortoSpoof GPS END ---"

require_cmd() {
  command -v "$1" >/dev/null 2>&1
}

note() { printf "[info] %s\n" "$*"; }
warn() { printf "[warn] %s\n" "$*"; }
fail() { printf "[err]  %s\n" "$*"; exit 1; }

# 1) Sanity checks
[[ "$(uname -s)" == "Darwin" ]] || fail "This script targets macOS."

# 2) Ensure Homebrew (for pipx if needed)
if ! require_cmd brew; then
  warn "Homebrew not found. Install from https://brew.sh and re-run."
  exit 1
fi

# 3) Ensure Python3
if ! require_cmd python3; then
  note "Installing python3 via Homebrew"
  brew install python
fi

# 4) Ensure pipx
if ! require_cmd pipx; then
  note "Installing pipx via Homebrew"
  brew install pipx
  # Ensure pipx is set up for PATH
  pipx ensurepath || true
fi

# 5) Ensure ~/.local/bin on PATH in zshrc (for pipx shims)
PATH_LINE='export PATH="$PATH:$HOME/.local/bin"'
if ! grep -Fq "$PATH_LINE" "$ZSHRC" 2>/dev/null; then
  note "Adding ~/.local/bin to PATH in $ZSHRC"
  printf '\n# Added by TortoSpoof installer for pipx\n%s\n' "$PATH_LINE" >>"$ZSHRC"
fi

# 6) Ensure pymobiledevice3 installed via pipx
if ! pipx list | grep -q "pymobiledevice3"; then
  note "Installing pymobiledevice3 via pipx"
  pipx install pymobiledevice3
fi

# 7) Detect pipx venv python for pymobiledevice3
PIPX_PY_DEFAULT="$HOME/.local/pipx/venvs/pymobiledevice3/bin/python"
if [ -x "$PIPX_PY_DEFAULT" ]; then
  PIPX_PY_RESOLVED="$PIPX_PY_DEFAULT"
else
  # Try to resolve via pipx metadata
  PIPX_ENV_DIR=$(python3 - <<'PY'
import json,os,sys,subprocess
try:
    out=subprocess.check_output(["pipx","list","--json"], text=True)
    j=json.loads(out)
    for p in j.get("venvs",[]):
        if p.get("package","{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}") == "pymobiledevice3":
            path = p.get("venv_dir")
            if path:
                print(os.path.join(path, "bin", "python"))
                sys.exit(0)
except Exception:
    pass
sys.exit(1)
PY
  ) || true
  if [ -n "${PIPX_ENV_DIR:-}" ] && [ -x "$PIPX_ENV_DIR" ]; then
    PIPX_PY_RESOLVED="$PIPX_ENV_DIR"
  else
    # Fallback to system python3
    PIPX_PY_RESOLVED="$(command -v python3)"
  fi
fi

note "Using Python interpreter: $PIPX_PY_RESOLVED"

# 8) Compose GPS spoofing block (only if missing)
if grep -Fq "$BLOCK_BEGIN" "$ZSHRC" 2>/dev/null; then
  note "Existing TortoSpoof block found in $ZSHRC. Skipping injection."
else
  note "Injecting GPS spoofing functions into $ZSHRC"
  cat >>"$ZSHRC" <<EOF
$BLOCK_BEGIN
# iPhone GPS Spoofing: tek komut + otomatik keepawake
export PIPX_PY="$PIPX_PY_RESOLVED"
export SPOOF_RSD_FILE="\$HOME/.fakeloc_rsd"
export SPOOF_LOG_FILE="\$HOME/.fakeloc_tunneld.log"
export SPOOF_CAFF_PID="\$HOME/.fakeloc_caffeinate.pid"

_spoof_mount() {
  "\$PIPX_PY" -m pymobiledevice3 mounter auto-mount \
  || {
    DDI=\$(ls \$HOME/Library/Developer/Xcode/iOS\ DeviceSupport/*/DeveloperDiskImage.dmg 2>/dev/null | tail -1)
    [ -n "\$DDI" ] && "\$PIPX_PY" -m pymobiledevice3 mounter mount "\$DDI" 2>/dev/null
  }
}

_spoof_start_tunnel_bg() {
  sudo -v || return 1
  if pgrep -f "pymobiledevice3 remote tunneld" >/dev/null; then :; else
    : > "\$SPOOF_LOG_FILE"; : > "\$SPOOF_RSD_FILE"
    sudo -n "\$PIPX_PY" -m pymobiledevice3 remote tunneld >"\$SPOOF_LOG_FILE" 2>&1 &
  fi
  for i in {1..120}; do
    if grep -q "Created tunnel --rsd " "\$SPOOF_LOG_FILE"; then break; fi
    sleep 0.25
  done
  local host port
  host="\$(grep -oE 'Created tunnel --rsd [0-9a-f:.]+ [0-9]+' "\$SPOOF_LOG_FILE" | tail -1 | awk '{print $4}')"
  port="\$(grep -oE 'Created tunnel --rsd [0-9a-f:.]+ [0-9]+' "\$SPOOF_LOG_FILE" | tail -1 | awk '{print $5}')"
  if [ -n "\$host" ] && [ -n "\$port" ]; then
    echo "\$host \$port" > "\$SPOOF_RSD_FILE"
    return 0
  else
    echo "RSD bilgisi bulunamadı. Log: \$SPOOF_LOG_FILE"
    return 1
  fi
}

_spoof_get_rsd() {
  RSD_HOST=""; RSD_PORT=""
  if [ -f "\$SPOOF_RSD_FILE" ]; then read -r RSD_HOST RSD_PORT < "\$SPOOF_RSD_FILE"; fi
  if [ -z "\$RSD_HOST" ] || [ -z "\$RSD_PORT" ] || [ "\$RSD_HOST" = "127.0.0.1" ]; then
    rm -f "\$SPOOF_RSD_FILE"
    _spoof_start_tunnel_bg || return 1
    read -r RSD_HOST RSD_PORT < "\$SPOOF_RSD_FILE"
  fi
  [ -n "\$RSD_HOST" ] && [ -n "\$RSD_PORT" ]
}

_spoof_start_caffeinate() {
  if [ -f "\$SPOOF_CAFF_PID" ] && kill -0 "\$(cat "\$SPOOF_CAFF_PID")" 2>/dev/null; then return 0; fi
  caffeinate -d -i -u >/dev/null 2>&1 &
  echo $! > "\$SPOOF_CAFF_PID"
}

_spoof_stop_caffeinate() {
  if [ -f "\$SPOOF_CAFF_PID" ]; then
    kill "\$(cat "\$SPOOF_CAFF_PID")" 2>/dev/null || true
    rm -f "\$SPOOF_CAFF_PID"
  else
    pkill -x caffeinate 2>/dev/null || true
  fi
}

spoof() {
  case "\$1" in
    clear)
      _spoof_get_rsd || { echo "RSD bulunamadı."; return 1; }
      "\$PIPX_PY" -m pymobiledevice3 developer dvt simulate-location clear --rsd "\$RSD_HOST" "\$RSD_PORT"
      echo "cleared."
      ;;
    stop)
      pkill -f "pymobiledevice3 remote tunneld" 2>/dev/null || true
      _spoof_stop_caffeinate
      rm -f "\$SPOOF_RSD_FILE" "\$SPOOF_LOG_FILE"
      echo "stopped."
      ;;
    *)
      local LAT="\$1" LON="\$2" NOCAFF="\$3"
      if [ -z "\$LAT" ] || [ -z "\$LON" ]; then
        echo "Kullanım: spoof <LAT> <LON> [--no-caff] | spoof clear | spoof stop"; return 1; fi
      echo "[1/4] mount"; _spoof_mount
      echo "[2/4] tunnel"; _spoof_get_rsd || { echo "RSD başarısız. Log: \$SPOOF_LOG_FILE"; return 1; }
      if [ "\$RSD_HOST" = "127.0.0.1" ]; then echo "geçersiz RSD (127.0.0.1). 'spoof stop' sonra tekrar deneyin."; return 1; fi
      if [ "\$NOCAFF" != "--no-caff" ]; then echo "[3/4] keepawake"; _spoof_start_caffeinate; else echo "[3/4] keepawake atlandı"; fi
      echo "[4/4] set \$LAT,\$LON"
      "\$PIPX_PY" -m pymobiledevice3 developer dvt simulate-location set --rsd "\$RSD_HOST" "\$RSD_PORT" -- "\$LAT" "\$LON"
      echo "done."
      ;;
  esac
}
$BLOCK_END
EOF
fi

note "Done. Reload your shell with: source \"$ZSHRC\""
