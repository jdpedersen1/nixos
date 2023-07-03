{ config, lib, pkgs, ... };

{
  environment = {
    systemPackages = with pkgs; [ hyprpaper qt6.qtwayland ];

    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland > /home/jake/hyprland.log 2>&1
      fi
    '';
  };

  programs = { };
}
