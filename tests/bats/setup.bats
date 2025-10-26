#!/usr/bin/env bats

setup() {
  export HOME="$(pwd)/tmp_home"
  mkdir -p "$HOME"
  chezmoi init --apply --source $(git rev-parse --show-toplevel)
}

@test "zshrc can be sourced without errors" {
  run zsh -c "source $HOME/.zshrc"
  [ "$status" -eq 0 ]
}
