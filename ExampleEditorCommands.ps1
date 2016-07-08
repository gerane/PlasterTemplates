# PLaster Toolkit Template

## You will need to change the Toolkit Destination Directory $Env:Apps and the Github Directory $Env:Github
## This is an example of Setting default values in a hashtable and prompting the user for other Values.
## This example opens the Deploy-Application.ps1 file in Code after it is finished
## It also opens the Toolkit directory in explorer.
Register-EditorCommand `
    -Name "PlasterTemplates.InvokeToolkitTemplate" `
    -DisplayName "Create New Toolkit from Template" `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)        
        [ValidateNotNullOrEmpty()]$Name = Read-Host 'Please type Toolkit Name'
        $Vendor = Read-Host 'Please Enter the Vendor Name'

        $List = @('NonInteractive','Interactive','Silent')        
        $Choices = [System.Management.Automation.Host.ChoiceDescription[]] @($List)
        $Selection = $host.ui.PromptForChoice('', "Please Select a Deploy Mode" , $choices,'0')
        $DeployMode = $List[$Selection]
        
        $ToolkitDir = Join-Path -Path $Env:Apps -ChildPath $Name
        $PlasterParams = @{
            TemplatePath = "$Env:Github\PlasterTemplates\ToolkitTemplate"
            DestinationPath = $ToolkitDir
            Vendor = $Vendor
            ToolkitName = $Name
            DeployMode = $DeployMode         
            Version = '1.0.0'
            Author = 'Brandon Padgett'
        }
        
        Invoke-Plaster @PlasterParams 
        
        $ToolkitScript = Join-Path -Path $ToolkitDir -ChildPath 'Toolkit\Deploy-Application.ps1'
        $psEditor.Workspace.OpenFile($ToolkitScript)

        explorer.exe "$($ToolkitDir)\Toolkit"        
    }

# PLaster Module Template

## You will need to change the $Env:Github directory in this example.
## I have removed any multichoice option and replaced with single choice options since Code does not support multi yet.
## This example sets all defaults but the module name so when using Invole-Plaster the user is only prompted with the name.
## When finished it opens the new module in Code Insiders. You can swap to code by swapping the comments.
## Eventually the Powershell Extension should make some of this easier.
Register-EditorCommand `
    -Name "PlasterTemplates.InvokeModuleTemplate" `
    -DisplayName "Create New Module from Template" `
    -ScriptBlock {
        param([Microsoft.PowerShell.EditorServices.Extensions.EditorContext]$context)        
        [ValidateNotNullOrEmpty()]$Name = Read-Host 'Please type Module Name'
        
        $PlasterParams = @{
            TemplatePath = "$Env:Github\PlasterTemplates\ModuleTemplate"
            Destination = "$Env:Github\$Name"
            ModuleName = "$Name"
            FullName = 'Brandon Padgett'
            Version = '0.0.1'
            Git = 'Yes'
            PSake = 'Yes'
            Pester = 'Yes'
            PSDeploy = 'Yes'
            AppVeyor = 'Yes'
            PlatyPS = 'Yes'
            ReadTheDocs = 'Yes'
            Editor = 'VSCode'
            License = 'MIT'
        }
        
        Invoke-Plaster @PlasterParams 

        code-insiders "$Env:Github\$Name"
        #code "$Env:Github\$Name"
    }