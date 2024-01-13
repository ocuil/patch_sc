# Define los nombres de archivo
$archivoOrigen = "traducciones_personales.ini"
$archivoDestino = "global.ini"

# Verifica si los archivos existen
if (-not (Test-Path $archivoOrigen) -or -not (Test-Path $archivoDestino)) {
    Write-Host "Los archivos no existen."
    exit
}

# Lee el archivo de destino y lo convierte en un diccionario
$destinoDiccionario = @{}
Get-Content $archivoDestino | ForEach-Object {
    $partes = $_ -split '=', 2
    $destinoDiccionario[$partes[0]] = $partes[1]
}

# Lee cada línea del archivo de origen y actualiza el diccionario
Get-Content $archivoOrigen | ForEach-Object {
    $partes = $_ -split '=', 2
    $destinoDiccionario[$partes[0]] = $partes[1]
}

# Escribe el diccionario actualizado en el archivo de destino
# Usando Out-File con el parámetro -NoClobber para no sobrescribir el archivo existente
$contenidoParaEscribir = $destinoDiccionario.GetEnumerator() | ForEach-Object {
    "$($_.Key)=$($_.Value)"
}

$contenidoParaEscribir | Out-File -FilePath "global_traducido.ini" -NoClobber

Write-Host "Fusión completada."
