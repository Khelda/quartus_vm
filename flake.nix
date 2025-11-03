{
  description = "Quartus experiment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        hostPkgs = import nixpkgs { inherit system; };
      in
      {
        packages.vm =
          let
            hostConfig = self.nixosConfigurations.testbox;
            localConfig = hostConfig.extendModules {
              modules = [
                (
                  { modulesPath, ... }:
                  {
                    imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];
                    virtualisation.host.pkgs = hostPkgs;
                    virtualisation.memorySize = 4096;
                    virtualisation.cores = 3;
                  }
                )
              ];
            };
          in
          localConfig.config.system.build.vm;
      }
    )
    // {
      nixosConfigurations.testbox =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
    };
}
