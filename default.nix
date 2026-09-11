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
</wallpapers>
EOF

    cp $out/share/gnome-background-properties/chomiamos.xml $out/share/cinnamon-background-properties/chomiamos.xml

    # 4. Support KDE Plasma Desktop (Paquets avec métadonnées)
    install_plasma_wallpaper() {
      local id="$1"
      local name="$2"
      local file="$3"
      local dir="$out/share/wallpapers/$id"

      mkdir -p "$dir/contents/images"
      cp "$file" "$dir/contents/images/"
      cp "$file" "$dir/contents/screenshot.png"

      cat <<EOF > "$dir/metadata.desktop"
[Desktop Entry]
Name=$name
X-KDE-PluginInfo-Name=$id
X-KDE-PluginInfo-Author=Chomiam
EOF

      cat <<EOF > "$dir/metadata.json"
{
  "KPlugin": {
    "Authors": [{ "Name": "Chomiam" }],
    "Id": "$id",
    "Name": "$name"
  }
}
EOF
    }

    install_plasma_wallpaper "ChomiamOS-Default" "ChomiamOS Par Défaut" "wallpaper.jpeg"
    install_plasma_wallpaper "ChomiamOS-01" "ChomiamOS 01" "wallpaper_0001.jpg"
    install_plasma_wallpaper "ChomiamOS-02" "ChomiamOS 02" "wallpaper_0002.jpg"
    install_plasma_wallpaper "ChomiamOS-03" "ChomiamOS 03" "wallpaper_0003.jpg"
    install_plasma_wallpaper "ChomiamOS-04" "ChomiamOS 04" "wallpaper_0004.jpg"
    install_plasma_wallpaper "ChomiamOS-05" "ChomiamOS 05" "wallpaper_0005.jpg"
    install_plasma_wallpaper "ChomiamOS-06" "ChomiamOS 06" "wallpaper_0006.png"
    install_plasma_wallpaper "ChomiamOS-07" "ChomiamOS 07" "wallpaper_0007.png"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Collection officielle de fonds d'écran ChomiamOS pour tous les environnements de bureau";
    homepage = "https://github.com/Chomiam/chomiamos-wallpapers";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
