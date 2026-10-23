# PowerShell

- En tête : `Set-StrictMode -Version Latest`, `$ErrorActionPreference = 'Stop'`, `#Requires -Version` si besoin.
- Fonctions avancées `[CmdletBinding()]`, paramètres typés et validés ; verbes approuvés ; aucun alias.
- Action destructrice : `SupportsShouldProcess`. Pas d'`Invoke-Expression` sur une donnée externe ; `Join-Path`.
- `Write-Host` réservé à l'interactif ; identifiants via `PSCredential` ou SecretManagement.
- Tests Pester ; PSScriptAnalyzer sans avertissement.
