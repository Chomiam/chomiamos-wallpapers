{ pkgs ? import <nixpkgs> {}, lib ? pkgs.lib, stdenvNoCC ? pkgs.stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "chomiamos-wallpapers";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    runHook preInstall

    # 1. Dossier universel de fonds d'écran
    install -d $out/share/backgrounds/chomiamos
    install -m 644 wallpaper.jpeg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0001.jpg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0002.jpg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0003.jpg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0004.jpg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0005.jpg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0006.png $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0007.png $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0008.jpeg $out/share/backgrounds/chomiamos/
    install -m 644 wallpaper_0009.jpeg $out/share/backgrounds/chomiamos/

    # 2. Support COSMIC Desktop
    install -d $out/share/backgrounds/cosmic
    for img in $out/share/backgrounds/chomiamos/*; do
      ln -s "$img" "$out/share/backgrounds/cosmic/chomiamos-$(basename "$img")"
    done

    # 3. Support GNOME & Cinnamon Desktop (XML properties)
    install -d $out/share/gnome-background-properties
    install -d $out/share/cinnamon-background-properties

    cat <<'EOF' > $out/share/gnome-background-properties/chomiamos.xml
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>ChomiamOS Par Défaut</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper.jpeg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 01</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0001.jpg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 02</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0002.jpg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 03</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0003.jpg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 04</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0004.jpg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 05</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0005.jpg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 06</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0006.png</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 07</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0007.png</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 08</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0008.jpeg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
  <wallpaper deleted="false">
    <name>ChomiamOS 09</name>
    <filename>/run/current-system/sw/share/backgrounds/chomiamos/wallpaper_0009.jpeg</filename>
    <options>zoom</options>
    <pcolor>#1e1e2e</pcolor>
    <scolor>#11111b</scolor>
  </wallpaper>
</wallpapers>
EOF

    cp $out/share/gnome-background-properties/chomiamos.xml $out/share/cinnamon-background-properties/chomiamos.xml

    # 4. Support KDE Plasma Desktop (Fonds d'écran à plat dans share/wallpapers)
    install -d $out/share/wallpapers
    for img in $out/share/backgrounds/chomiamos/*; do
      ln -s "$img" "$out/share/wallpapers/$(basename "$img")"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Collection officielle de fonds d'écran ChomiamOS pour tous les environnements de bureau";
    homepage = "https://github.com/Chomiam/chomiamos-wallpapers";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
