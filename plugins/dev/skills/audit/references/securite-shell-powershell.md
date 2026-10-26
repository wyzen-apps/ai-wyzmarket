# Shell et PowerShell — points propres

- `eval` ou `Invoke-Expression` sur une donnée externe ; variable non citée dans une commande.
- `curl … | bash` ou script téléchargé sans vérification d'empreinte.
- Identifiants en clair (script, arguments, logs) ; `/tmp/fichier` prévisible au lieu de `mktemp`
  ou `New-TemporaryFile` ; `chmod 777`.
- `set -euo pipefail` absent (bash) ; `$ErrorActionPreference = 'Stop'` absent (PowerShell).
