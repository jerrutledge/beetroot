# beetroot
 Global Game Jam '23 Project


## Ink Installation
1. Download the 1.0.0 release of Ink here: https://github.com/inkle/ink/releases/tag/v1.0.0
2. Under Editor > Editor Settings > Mono > Builds, you may need to select the dotnet CLI
3. Duplicate addons/ink/override.cfg.template, and rename the copy to override.cfg. In override.cfg, insert the path to your extracted "inklecate.exe" file. E.g.:
```ini
inklecate_path = "C:/Path/To/Your/inklecate.exe"
```