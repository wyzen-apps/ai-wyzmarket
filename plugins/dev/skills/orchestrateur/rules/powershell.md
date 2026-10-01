# PowerShell

- `Set-StrictMode -Version Latest` et `$ErrorActionPreference = 'Stop'` en tête de script.
- Fonctions avancées : `[CmdletBinding()]`, paramètres typés avec attributs de validation
  (`[ValidateNotNullOrEmpty()]`, `[ValidateSet()]`).
- Verbes approuvés (`Get-Verb`) ; aucun alias dans un script (`Get-ChildItem`, pas `ls`).
- Actions destructrices : `SupportsShouldProcess` (`-WhatIf`, `-Confirm`).
- Pas d'`Invoke-Expression` sur une donnée externe ; chemins construits avec `Join-Path`.
- Journalisation : `Write-Verbose`, `Write-Warning`, `Write-Error` ; `Write-Host` réservé à l'affichage interactif.
- Identifiants : `PSCredential` ou module SecretManagement, jamais en clair.
- Tests Pester ; PSScriptAnalyzer sans avertissement.
- `#Requires -Version` si une fonctionnalité récente est utilisée.
