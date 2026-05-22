# Dotfiles
A Nix Flake providing cross-platform dotfiles and system configurations for my
NixOS and macOS (nix-darwin) machines.

## Structure
- `machines/`: System-level configurations for each host.
- `home-manager/`: Most program configuration is here. Userland programs
  (Hyprland btw, Neovim btw, etc.) are managed here. The `common/` directory
  contains modules applied indiscriminately to every machine.

## Screenshots
<p align="center">
  <img src="./images/screenshot1.png" width="45%" />
  <img src="./images/screenshot2.png" width="45%" />
  <img src="./images/screenshot3.png" width="45%" />
  <img src="./images/screenshot4.png" width="45%" />
</p>

## Discussion
Feel free to open an issue for questions or suggestions!
