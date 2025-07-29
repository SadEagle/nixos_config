{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings =
      let
        wallpaper_img = toString ../hypr/Cici.png;
      in
      {
        preload = wallpaper_img;
        wallpaper = ", ${wallpaper_img}";
      };
  };
}
