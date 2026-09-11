# 🎨 ChomiamOS Wallpapers

Collection officielle des fonds d'écran de l'environnement **ChomiamOS**, optimisée pour une intégration native et automatique dans l'ensemble des environnements de bureau Linux (GNOME, KDE Plasma, COSMIC Desktop, Cinnamon, etc.).

## 🖼️ Liste des fonds d'écran inclus

| Nom | Fichier | Résolution | Format |
| :--- | :--- | :--- | :--- |
| **ChomiamOS Par Défaut** | `wallpaper.jpeg` | 2752x1536 | JPEG |
| **ChomiamOS 01** | `wallpaper_0001.jpg` | 2560x1440 (2K QHD) | JPEG |
| **ChomiamOS 02** | `wallpaper_0002.jpg` | 3840x2160 (4K UHD) | JPEG |
| **ChomiamOS 03** | `wallpaper_0003.jpg` | 2560x1440 (2K QHD) | JPEG |
| **ChomiamOS 04** | `wallpaper_0004.jpg` | 3840x2160 (4K UHD) | JPEG |
| **ChomiamOS 05** | `wallpaper_0005.jpg` | 2560x1600 (16:10 QHD+) | JPEG |
| **ChomiamOS 06** | `wallpaper_0006.png` | 3840x2160 (4K UHD) | PNG |
| **ChomiamOS 07** | `wallpaper_0007.png` | 1920x1080 (FHD) | PNG |

## 🚀 Intégrations Desktop

- **GNOME Shell** : Déclaré dans `/share/gnome-background-properties/chomiamos.xml` pour un affichage direct dans *Paramètres GNOME -> Arrière-plan*.
- **KDE Plasma** : Déployés directement à plat dans `/share/wallpapers/` pour détection native directe.
- **COSMIC Desktop** : Déployé dans `/share/backgrounds/cosmic/` et `/share/backgrounds/chomiamos/`.
- **Cinnamon** : Déclaré dans `/share/cinnamon-background-properties/chomiamos.xml`.
- **Système Global** : Disponible sous `/run/current-system/sw/share/backgrounds/chomiamos/` et `/etc/backgrounds/chomiamos/`.

## 📦 Utilisation avec Nix Flakes

```nix
inputs.chomiamos-wallpapers.url = "github:Chomiam/chomiamos-wallpapers";
```

Puis ajouter le paquet :
```nix
environment.systemPackages = [
  inputs.chomiamos-wallpapers.packages.${pkgs.stdenv.hostPlatform.system}.default
];
```
