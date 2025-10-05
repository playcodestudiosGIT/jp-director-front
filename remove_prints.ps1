#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Script para eliminar prints de código Dart/Flutter.
.DESCRIPTION
    Este script busca y elimina todos los print() en archivos Dart dentro del directorio lib.
.EXAMPLE
    .\remove_prints.ps1
#>

# Obtén la ruta del directorio del script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define el directorio lib
$libDir = Join-Path -Path $scriptDir -ChildPath "lib"

Write-Host "Buscando prints en archivos Dart..." -ForegroundColor Yellow

# Busca todos los archivos .dart que contengan print()
$filesWithPrints = Get-ChildItem -Path $libDir -Recurse -Filter *.dart | 
    Select-String -Pattern "print\(" | 
    ForEach-Object { $_.Path } | 
    Sort-Object | Get-Unique

# Muestra cuántos archivos tienen prints
Write-Host "Se encontraron prints en $($filesWithPrints.Count) archivos." -ForegroundColor Cyan

# Pregunta al usuario si desea continuar
$confirm = Read-Host "¿Deseas eliminar todos los prints? (s/n)"
if ($confirm -ne 's') {
    Write-Host "Operación cancelada." -ForegroundColor Red
    exit
}

# Contador para archivos modificados
$modifiedFiles = 0

# Elimina los prints
foreach ($file in $filesWithPrints) {
    $content = Get-Content $file -Raw
    $newContent = $content -replace 'print\([^;]*\);', ''
    
    if ($content -ne $newContent) {
        Set-Content -Path $file -Value $newContent -NoNewline
        $modifiedFiles++
        Write-Host "✓ Eliminados prints de: $file" -ForegroundColor Green
    }
}

Write-Host "`nOperación completada. Se modificaron $modifiedFiles archivos." -ForegroundColor Green
Write-Host "Recuerda utilizar Logger.log() en lugar de print() para futuros logs." -ForegroundColor Yellow