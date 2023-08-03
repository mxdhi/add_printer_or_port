# Se debe ejecutar con privilegios de administrador
# Script para crear impresora (Uso: .\add_printer.ps1 -nm_printer "NOMBRE IMPRESORA" -nm_port "IPPUERTO" -nm_driver "NOMBRE DRIVER")

param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$nm_printer,

    [Parameter(Mandatory=$true, Position=1)]
    [string]$nm_port,

    [Parameter(Mandatory=$true)]
    [string]$nm_driver
)

try {
    $printer = Get-Printer -Name $nm_printer -ErrorAction Stop

    # La impresora existe
    Write-Host "La impresora '$nm_printer' existe:"
    $printer
} catch {
    # La impresora no existe
    Write-Host "La impresora '$nm_printer' no existe."

    $createPrinter = Read-Host "¿Deseas crear la impresora? (s/n)"
    if ($createPrinter -eq "s") {
        try {
            Add-Printer -Name $nm_printer -ShareName $nm_printer -DriverName $nm_driver -PortName $nm_port

            # Get the printer object after creating it
            $printer = Get-Printer -Name $nm_printer

            # Activa la opción de compartir impresora en el objeto de impresora
            $printer.Shared = $true

            # Guarda los cambios en la configuración de la impresora
            Set-Printer -InputObject $printer

            Write-Host "La impresora ha sido creada con éxito:"
            Get-Printer -Name $nm_printer
        } catch {
            Write-Host "No se ha podido crear la impresora (Revisar o ejecutar como Administrador)."
        }
    } else {
        Write-Host "No se ha creado la impresora."
    }
}
