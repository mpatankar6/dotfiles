set -g fish_greeting

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

alias ff='cd ~ && clear && fastfetch'
alias github='open $(git remote get-url origin)'

if status is-interactive
  starship init fish | source
  zoxide init fish --cmd cd | source
  fzf --fish | source
end
