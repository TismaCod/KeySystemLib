# KeySystemLib - Roblox Key System Library

Une librairie Lua modulaire pour créer des systèmes de clés dans Roblox avec une interface utilisateur moderne.

## Installation

### Méthode 1 : Via loadstring (Recommandée)
```lua
-- Charger la librairie depuis GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/TismaCod/KeySystemLib/main/KeySystemLib.lua"))()

-- Utiliser la librairie
local userKey = KeySystemLib.CreateWindow({
    title = "Mon Script",
    keys = {"key1", "key2", "key3"},
    copyLinkValue = "https://key-system.temp-thisma.workers.dev/",
    showCopyLink = true
})

print("Clé validée :", userKey)
```

### Méthode 2 : Clés depuis un Gist GitHub
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/TismaCod/KeySystemLib/main/KeySystemLib.lua"))()

local userKey = KeySystemLib.CreateWindow({
    title = "Mon Script",
    rawUrl = "https://gist.githubusercontent.com/TON_USERNAME/GIST_ID/raw/keys_check",
    copyLinkValue = "https://key-system.temp-thisma.workers.dev/",
    showCopyLink = true
})
```

## Configuration

| Paramètre | Type | Requis | Description |
|-----------|------|--------|-------------|
| `title` | string | ✅ | Titre de la fenêtre |
| `keys` | table | ❌ | Liste de clés locales |
| `rawUrl` | string | ❌ | URL RAW d'un fichier contenant les clés |
| `copyLinkValue` | string | ❌ | URL à copier avec le bouton "Copy Link" |
| `showCopyLink` | boolean | ❌ | Afficher le bouton "Copy Link" |

## Fonctions Disponibles

### `KeySystemLib.CreateWindow(config)`
Crée une nouvelle fenêtre de saisie de clé. Ferme automatiquement toute fenêtre précédente.

### `KeySystemLib.CloseCurrentWindow()`
Ferme manuellement la fenêtre actuelle si elle existe. Retourne `true` si une fenêtre a été fermée, `false` sinon.

## Fonctionnalités

- ✅ Interface utilisateur moderne style Rayfield
- ✅ Validation de clés locales ou depuis URL
- ✅ Bouton "Copy Link" pour copier des URLs
- ✅ Blocage de l'exécution jusqu'à validation
- ✅ Protection anti-bypass avec vérifications multiples
- ✅ Noms de fonctions aléatoires pour l'obfuscation
- ✅ Gestion des erreurs et messages d'état
- ✅ Fermeture automatique des fenêtres précédentes
- ✅ Validation sécurisée des clés vides
- ✅ Mode "open" quand aucune clé n'est définie

## Logique de Validation

### Avec des clés définies (`keys` ou `rawUrl`)
- ❌ **Clé vide** = `"Please enter a key"`
- ✅ **Clé valide** = Acceptée
- ❌ **Clé invalide** = `"Invalid key"`

### Sans clés définies (aucune clé ni URL)
- ✅ **Clé vide** = Acceptée (mode "open")
- ✅ **N'importe quelle clé** = Acceptée

## Exemple Complet

```lua
-- Charger la librairie
loadstring(game:HttpGet("https://raw.githubusercontent.com/TismaCod/KeySystemLib/main/KeySystemLib.lua"))()

-- Attendre que la librairie soit chargée
wait(0.1)

-- Vérifier que la librairie est bien chargée
if not KeySystemLib then
    error("KeySystemLib n'a pas pu être chargée!")
end

-- Utiliser la librairie
local userKey = KeySystemLib.CreateWindow({
    title = "EzPiggy Script",
    keys = {"test123", "demo456", "key789"},
    copyLinkValue = "https://key-system.temp-thisma.workers.dev/",
    showCopyLink = true
})

-- Le script continue seulement si une clé valide est entrée
print("Clé validée :", userKey)
print("Script démarré avec succès!")

-- Ton code principal ici...
```
