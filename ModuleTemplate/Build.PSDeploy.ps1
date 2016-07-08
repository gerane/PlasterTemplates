Deploy <%=$PLASTER_PARAM_ModuleName%> {
    
    By PlatyPS {
        FromSource "$ENV:BHProjectPath\docs\Commands"
        To "$ENV:BHProjectName\<%=$PLASTER_PARAM_ModuleName%>\en-US"
        Tagged Help
        WithOptions @{
            Force = $true
        }
    }

    By FileSystem {
        FromSource $ENV:BHProjectName
        To "$home\Documents\WindowsPowerShell\Modules\<%=$PLASTER_PARAM_ModuleName%>"
        Tagged Prod, Module, Local
        WithOptions @{
            Mirror = $true
        }
        WithPostScript {
            Import-Module -Name <%=$PLASTER_PARAM_ModuleName%> -Force
        }
    }

    By PSGalleryModule {
        FromSource $ENV:BHProjectName
        To PSGallery
        Tagged PSGallery
        WithOptions @{
            ApiKey = $ENV:NugetApiKey
        }
    }
}