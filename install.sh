#!/bin/bash

usage() {
  cat <<EOS
Dotfiles Installer
Usage: install.sh [options]
    -b, --branch <branch>
                     Checkout branch.
    -n, --dry-run    Don't actually install. just print them.
    -h, --help       Display this message.
EOS
  exit "${1:-0}"
}

chomp() {
  printf "%s" "${1/"$'\n'"/}"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")" >&2
}

branch='main'
is_dry_run=false
while [[ $# -gt 0 ]]
do
  case "$1" in
    -b | --branch)  branch=$2; shift;;
    -n | --dry-run) is_dry_run=true;;
    -h | --help)    usage;;
    *)
      warn "Unrecognized option: '$1'"
      usage 1
      ;;
  esac
  shift
done

# Chezmoi installer commaand and options
cz_inst_cmd="curl -fsLS get.chezmoi.io"
cz_inst_opts="\
-- \
-b $HOME/.local/bin \
init \
--apply $GITHUB_USER \
--branch $branch \
"

# Install with Chezmoi installer
if "$is_dry_run"; then
  echo "sh -c \"\$($cz_inst_cmd)\" $cz_inst_opts"
else
sh -c "$($cz_inst_cmd)" $cz_inst_opts
fi
