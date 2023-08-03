# Se debe ejecutar con privilegios de administrador
# Script para crear puertos (Uso: .\add_port.ps1.ps1 -nm_port IP_PUERTO)

param (
    [Parameter(Mandatory=$true)]
    [string]$nm_port
)

try {
    $port = Get-PrinterPort -Name $nm_port -ErrorAction Stop

    # El puerto existe
    Write-Host "El puerto indicado existe:"
    $port
} catch {
    # El puerto no existe
    Write-Host "El puerto indicado no existe."

    $createPort = Read-Host "¿Deseas crear el puerto? (s/n)"
    if ($createPort -eq "s") {
        try {
            Add-PrinterPort -Name $nm_port -PrinterHostAddress $nm_port
        } catch {
            Write-Host "No se ha podido crear el puerto (Revisar o ejecutar como Administrador)."
        }

        # Hacer la comprobación nuevamente después de crear el puerto
        try {
            $port = Get-PrinterPort -Name $nm_port -ErrorAction Stop
            Write-Host "El puerto ha sido creado con éxito."
        } catch {
            Write-Host "No se ha podido crear el puerto (Revisar o ejecutar como Administrador)."
        }
    } else {
        Write-Host "No se ha creado el puerto."
    }
}
