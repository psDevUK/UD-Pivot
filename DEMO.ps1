Import-Module -Name UniversalDashboard
Import-Module -Name UniversalDashboard.UDPivot
Get-UDDashboard | Stop-UDDashboard
$theme = Get-UDTheme -Name Default
Start-UDDashboard -Port 1000 -AutoReload -Dashboard (
    New-UDDashboard -Title "Powershell UniversalDashboard" -Theme $theme -Content {
        New-UDRow -Columns {
            New-UDColumn -Size 8 -Content {
                $Processes = Get-Process | Select-Object Name, CPU, WorkingSet, VirtualMemorySize
                $hash = @()
                foreach ($item in $Processes) {

                    $hash += @{
                        Name              = $item.Name
                        CPU               = $item.CPU
                        WorkingSet        = $item.WorkingSet
                        VirtualMemorySize = $item.VirtualMemorySize
                    }
                }
                New-UDPivot -Data { $hash }
            }
        }

    }
)