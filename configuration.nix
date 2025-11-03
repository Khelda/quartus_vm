{
  config,
  lib,
  pkgs,
  ...
}:

let
  system = "x86_64";
in
{
  environment.systemPackages = with pkgs; [ cowsay ];

  # no-password sudo on this one
  security.sudo = {
    enable = true;
    extraConfig = "%wheel ALL=(ALL) NOPASSWD: ALL";
  };
}
