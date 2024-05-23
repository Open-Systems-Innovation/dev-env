{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    custom-nixpkgs.url = "github:open-systems-innovation/custom-nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      imports = [ ./imports/overlay.nix ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShellNoCC {
            name = "default";
            
            packages = [
              # General packages
              pkgs.hello-nix

              # Python packages
              (pkgs.python3.withPackages (python-pkgs: [
                # packages for formatting/ IDE
                python-pkgs.black
                python-pkgs.flake8
                python-pkgs.jedi
                python-pkgs.pip
                python-pkgs.setuptools
                # packages for code
                python-pkgs.gmsh
                python-pkgs.matplotlib
                python-pkgs.meshio
                python-pkgs.numpy
              ]))
            ];

            shellHook = ''
              export PS1="\[\e[0;32m\]dev-shell>\[\e[0;36m\] "
            '';
          };
        };
    };
}
