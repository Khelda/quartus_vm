{
  config,
  lib,
  pkgs,
  ...
}:

let
  system = "x86_64";

  # build quartus ourselves

in
{
  # basic environment info
  system.stateVersion = "25.11";

  # packages to run
  environment.systemPackages = with pkgs; [ cowsay ];

  # custom user
  users.users."quartus" = {
    isNormalUser = true;
    createHome = true;
    home = "/home";
    description = "Quartus base user";
    extraGroups = [ "wheel" ];
    password = "quartus";
  };

  # no-password sudo on this one
  security.sudo = {
    enable = true;
    extraConfig = "%wheel ALL=(ALL) NOPASSWD: ALL";
  };
}
