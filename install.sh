#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

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

link_files() {
	src_dir=$1
	dst_dir=$2
	pattern=$3

	mkdir -p "$dst_dir"

	for f in "$src_dir"/$pattern; do
		[ -e "$f" ] || continue
		target="$dst_dir/$(basename "$f")"
		rm -f -- "$target"
		ln -s -- "$f" "$target"
	done
}

echo "==> Installing user dotfiles"

# shell
ln -sf "$PWD/home/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/home/.bash_profile" "$HOME/.bash_profile"

# scripts
link_files "$SCRIPT_DIR/home/.local/bin" "$HOME/.local/bin" "*"

# tmux
ln -sf "$PWD/home/.tmux.conf" "$HOME/.tmux.conf"

# man pages
link_files "$SCRIPT_DIR/home/.local/share/man/man1" "$HOME/.local/share/man/man1" "*.1"

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
