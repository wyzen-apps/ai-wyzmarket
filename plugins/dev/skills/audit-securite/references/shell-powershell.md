# Checklist shell et PowerShell

- `eval` ou `Invoke-Expression` sur une donnée externe.
- Variables non protégées par des guillemets dans une commande (`rm -rf $dossier`).
- `curl … | bash` ou exécution d'un script téléchargé sans vérification d'empreinte.
- Identifiants en clair dans le script, les arguments ou les logs.
- Fichiers temporaires prévisibles (`/tmp/fichier`) au lieu de `mktemp` ou `New-TemporaryFile`.
- Permissions trop larges (`chmod 777`).
- `set -euo pipefail` absent (bash), `$ErrorActionPreference = 'Stop'` absent (PowerShell).
