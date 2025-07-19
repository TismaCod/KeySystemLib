# KeySystemLib – Roblox Key System Library

**KeySystemLib** est une librairie modulaire pour Roblox permettant d’ajouter facilement un système de validation de clé à vos jeux ou scripts, avec une interface moderne et personnalisable.

## Fonctionnalités principales

- **Interface utilisateur moderne** (style Rayfield, opaque, centrée, boutons personnalisables)
- **Validation de clé** :
  - Depuis une liste locale (`keys`)
  - Depuis un lien RAW distant (`rawUrl`)
  - Ou les deux en même temps
- **Bouton “Copy Link”** optionnel, avec valeur personnalisable
- **Configuration simple** via une seule fonction
- **Obfuscation légère** des fonctions de vérification
- **Aucune dépendance externe**

## Utilisation

```lua
local KeySystemLib = require(path.to.test)
KeySystemLib.show({
    title = "My Script",
    rawUrl = "https://...", -- optionnel
    keys = {"key1", "key2"}, -- optionnel
    showCopyLink = true, -- optionnel
    copyLinkValue = "https://key-system.temp-thisma.workers.dev/" -- optionnel
})
```

- **title** (obligatoire) : Titre affiché sur l’UI
- **rawUrl** (optionnel) : Lien vers une liste de clés distante (RAW)
- **keys** (optionnel) : Liste de clés locale
- **showCopyLink** (optionnel, défaut : false) : Affiche le bouton “Copy Link”
- **copyLinkValue** (optionnel) : Valeur copiée par le bouton

## Remarques

- Si aucune clé n’est fournie (ni `rawUrl` ni `keys`), toute clé (même vide) sera acceptée.
- Si `copyLinkValue` est défini mais que `showCopyLink` est désactivé, la librairie affiche une erreur et ne s’affiche pas.
- Compatible avec les exploits supportant `loadstring` et l’import manuel via `require()`.
