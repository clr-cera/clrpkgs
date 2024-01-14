{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  #Spicetify
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Default;
    colorScheme = "custom";

    customColorScheme = {
      button = "f9afe8";
      sidebar = "1a1b26";
      player = "1a1b26";
      main = "1a1b26";
      button-active = "f9afe8";
      text = "c0caf5";
      subtext = "9aa5ce";
      button-text = "c0caf5";
      card = "1a1b26";
      shadow = "1a1b26";
      selected-row = "c0caf5";
      sub-button = "f9afe8";
      button-disabled = "f9afe8";
      sidebar-button = "8c4351";
      play-button = "f9afe8";
      tab-active = "f9afe8";
      notification = "f9afe8";
      notification-error = "f9afe8";
      playback-bar = "f9afe8";
      misc = "f9afe8";
    };

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts
    ];
  };
}
