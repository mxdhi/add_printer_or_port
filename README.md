# Añadir puertos/impresoras a servidores Windows con Powershell.
# Importante: Se debe ejecutar con privilegios de Administrador.

# Añadir puerto

Ejecutar el script add_port.ps1 declarando las siguientes opciones:

```
.\add_port.ps1 -nm_port IP_PUERTO
```

# Añadir impresoras

Ejecutar el script add_printer.ps1 declarando las siguientes opciones:

```
.\add_printer.ps1 -nm_printer "NOMBRE IMPRESORA" -nm_port "IPPUERTO" -nm_driver "NOMBRE DRIVER"
```

# Listado de todos los puertos del servidor:

```
Get-PrinterPort | Select-Object -Property Name
```

# Listado de todos los drivers del servidor:

```
Get-PrinterDriver | Select-Object -Property Name
```
