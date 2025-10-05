# Script para eliminar prints de una aplicación Flutter
# Este script busca y elimina todas las llamadas a print() en archivos .dart

# Cambiar al directorio del proyecto
Set-Location "C:\Users\playc\OneDrive\Documentos\devs\jpdirector\WEB\jp_director"

Write-Host "Buscando archivos .dart con print()..." -ForegroundColor Cyan

# Listar todos los archivos con print() antes de eliminar
$filesWithPrint = Get-ChildItem -Path .\lib -Recurse -Filter "*.dart" | 
  Select-String -Pattern "print\(" | 
  ForEach-Object { $_.Path } | 
  Sort-Object | Get-Unique

Write-Host "Se encontraron $($filesWithPrint.Count) archivos con print()" -ForegroundColor Yellow

# Mostrar los archivos encontrados
$filesWithPrint | ForEach-Object {
    Write-Host "- $_" -ForegroundColor Gray
}

# Preguntar al usuario si desea continuar
$confirmation = Read-Host "¿Deseas eliminar todos los print()? (s/n)"
if ($confirmation -ne "s") {
    Write-Host "Operación cancelada por el usuario." -ForegroundColor Red
    exit
}

# Contador para archivos modificados
$modifiedFiles = 0

# Procesar cada archivo .dart
Get-ChildItem -Path .\lib -Recurse -Filter "*.dart" | ForEach-Object {
    $filePath = $_.FullName
    $content = Get-Content $filePath -Raw
    
    # Patrones para diferentes tipos de print()
    $patterns = @(
        'print\([^;]*\);',                         # print básico: print('mensaje');
        'print\([^;)]*\);\s*\/\/[^\r\n]*',        # print con comentario: print('mensaje'); // comentario
        '(?m)^\s*print\([^;]*\);\s*$'              # print en línea individual
    )
    
    $originalContent = $content
    
    # Aplicar todos los patrones de reemplazo
    foreach ($pattern in $patterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Si hubo cambios, guardar el archivo
    if ($content -ne $originalContent) {
        Set-Content -Path $filePath -Value $content -NoNewline
        $modifiedFiles++
        Write-Host "Modificado: $filePath" -ForegroundColor Green
    }
}

Write-Host "Proceso completado. Se modificaron $modifiedFiles archivos." -ForegroundColor Cyan

# Sugerir ejecutar Flutter analyze para verificar cualquier problema
Write-Host "`nPara verificar que todo esté correcto, ejecuta:" -ForegroundColor Yellow
Write-Host "flutter analyze" -ForegroundColor White