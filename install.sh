#!/bin/sh
set -eu

need() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "Error required command '$1' not found"
        exit 1
    }
}

need acpid
need fastfetch
need install
need ln
need systemctl
need tmux

echo "==> Installing user dotfiles"

# shell
ln -sf "$PWD/home/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/home/.bash_profile" "$HOME/.bash_profile"

# scripts
mkdir -p "$HOME/.local"
for f in "$PWD/home/.local/bin/"*; do
	ln -sf "$f" "$HOME/.local/bin/$(basename "$f")"
done

# tmux
ln -sf "$PWD/home/.tmux.conf" "$HOME/.tmux.conf"

echo "==> User dotfiles installed"

echo "==> Installing ACPI event files (requires sudo)"

for f in "$PWD/etc/acpi/events/"*; do
    [ -f "$f" ] || continue
    echo "  -> Installing $(basename "$f")"
    sudo install -m 644 "$f" /etc/acpi/events
done

echo "==> ACPI event files installed"

echo "==> Restarting acpid"
sudo systemctl restart acpid

echo "==> Done"
