# Use this file to debug the module.
Remove-Module "<%=$PLASTER_PARAM_ModuleName%>" -ErrorAction SilentlyContinue
Import-Module "$PSScriptRoot\<%=$PLASTER_PARAM_ModuleName%>\<%=$PLASTER_PARAM_ModuleName%>.psd1" -Force

