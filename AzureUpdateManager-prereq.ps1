#auth
Connect-AzAccount

# set resource group name
$rg = Get-AzResourceGroup -Name "servers_rg1"

$azVMs = Get-AzVM -ResourceGroupName $rg.ResourceGroupName


foreach ($azvm in $azVMs)
{
    $VirtualMachine = Get-AzVM -ResourceGroupName $rg.ResourceGroupName -Name $azvm.Name
    Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -PatchMode "AutomaticByPlatform"
    $AutomaticByPlatformSettings = $VirtualMachine.OSProfile.WindowsConfiguration.PatchSettings.AutomaticByPlatformSettings
    
    if ($null -eq $AutomaticByPlatformSettings) 
    {
        $VirtualMachine.OSProfile.WindowsConfiguration.PatchSettings.AutomaticByPlatformSettings = New-Object -TypeName Microsoft.Azure.Management.Compute.Models.WindowsVMGuestPatchAutomaticByPlatformSettings -Property @{BypassPlatformSafetyChecksOnUserSchedule = $true}
    } else {
       $AutomaticByPlatformSettings.BypassPlatformSafetyChecksOnUserSchedule = $true
    }
    Update-AzVM -VM $VirtualMachine -ResourceGroupName $rg.ResourceGroupName
}
    
#References
# https://learn.microsoft.com/en-us/azure/update-manager/prerequsite-for-schedule-patching?tabs=new-prereq-powershell%2Cauto-portal
# https://learn.microsoft.com/en-us/azure/virtual-machines/automatic-vm-guest-patching#requirements-for-enabling-automatic-vm-guest-patching
