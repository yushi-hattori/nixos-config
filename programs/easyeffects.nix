{
  pkgs,
  config,
  ...
}: let
  presetsRepo = pkgs.fetchFromGitHub {
    owner = "JackHack96";
    repo = "EasyEffects-Presets";
    rev = "069195c4e73d5ce94a87acb45903d18e05bffdcc";
    hash = "sha256-nXVtX0ju+Ckauo0o30Y+sfNZ/wrx3HXNCK05z7dLaFc=";
  };

  jsonPresets = pkgs.runCommand "easyeffects-json-presets" {} ''
    mkdir -p $out
    cp ${presetsRepo}/*.json $out/
  '';
in {
  home.packages = with pkgs; [
    easyeffects
  ];

  # All JSON presets go here
  xdg.configFile."easyeffects/output".source = jsonPresets;

  # IRS folder goes here
  xdg.configFile."easyeffects/irs".source = "${presetsRepo}/irs";
}
