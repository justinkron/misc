# load Nutanix PS
& "C:\Program Files (x86)\Nutanix Inc\NutanixCmdlets\powershell\import_modules\ImportModules.PS1"

# Primary
#Connect-NutanixCluster -Server ip.ip.ip.ip -username admin -AcceptInvalidSSLCerts


Connect-NutanixCluster -Server ip.ip.ip.ip -username admin -AcceptInvalidSSLCerts

#$VMs = Get-Content C:\scripts\Round3.txt

# review this line, test against other cluster
$VMs = Get-NTNXVM | where {($_.controllervm -eq $false) -and ($_.powerstate -eq "on") -and ($_.description -notmatch "no_updates") -and ($_.vmname -notmatch "mdm")}

foreach ($vm in $VMs)
{
    $vm.vmname
    
    # Get VM object
    $nutVM = get-ntnxvm -SearchString $VM.vmName
    
    # Get existing snapshots
    Get-NTNXSnapshot | Where-Object {$_.vmUuid -eq $nutvm.uuid} 
    
    #snapshot removal
    $snapshotName = "before-updates"
    $snapshots = Get-NTNXSnapshot | Where-Object {($_.vmUuid -eq $nutvm.uuid) -and ($_.snapshotname -eq $snapshotName)} 
    Foreach ($snapshot in $snapshots)
    {
        Write-Verbose "Removing snapshot:$($snapshot | Select-Object snapshotName,uuid | Format-List | Out-String)" -Verbose
        Remove-NTNXSnapshot -Uuid $snapshot.uuid
        
    }
    
    # Get existing snapshots
    Get-NTNXSnapshot | Where-Object {$_.vmUuid -eq $nutvm.uuid}      
}



disConnect-NutanixCluster -Server ip.ip.ip.ip









