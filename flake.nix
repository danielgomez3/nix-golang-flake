{
  description = "danielgomez3's Golang development flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  # Nix Options version as well
  };
  outputs = inputs@{...}:
    let 
      currentSystem = builtins.currentSystem or "x86_64-linux";  # Fallback if not detected
      supportedSystems = {
        linux = "x86_64-linux";
        darwinIntel = "x86_64-darwin"; 
        darwinAmd = "aarch64-darwin"; 
        android = "aarch64-linux"; 
      };
      pkgs = inputs.nixpkgs.legacyPackages.${currentSystem};
    in 
    {
      devShells.${currentSystem}.default = pkgs.mkShell { 
        buildInputs = with pkgs; [
          go delve gpls
        ];  # deps needed at runtime.
        GREETING = "Hello, Nix!";
        shellHook = ''
          ${pkgs.pfetch}/bin/pfetch
          echo $GREETING
        '';
      };

    };
}
