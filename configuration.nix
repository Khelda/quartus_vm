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
  # basic environment info
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  # keymap settings

  # packages to run
  environment.systemPackages = with pkgs; [
    quartus-prime-lite
    btop # useful utility
  ];

  # launching quartus right away
  services.xserver = {
    enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "quartus";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

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
