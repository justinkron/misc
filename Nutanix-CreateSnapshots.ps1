# load Nutanix PS
& "C:\Program Files (x86)\Nutanix Inc\NutanixCmdlets\powershell\import_modules\ImportModules.PS1"

# Primary
Connect-NutanixCluster -Server ip.ip.ip.ip -username admin -AcceptInvalidSSLCerts


#$VMs = Get-Content C:\scripts\Round3.txt


$VMs = Get-NTNXVM | where {($_.controllervm -eq $false) -and ($_.powerstate -eq "on") -and ($_.description -notmatch "no_updates") -and ($_.vmname -notmatch "mdm")}

foreach ($vm in $VMs)
{
    # Get VM object
    $nutVM = get-ntnxvm -SearchString $VM
    
    #snapshot info
    $snapshotName = "before-updates"
    $newSnapshot = New-NTNXObject -Name SnapshotSpecDTO
    $newSnapshot.vmuuid = $nutvm.uuid
    $newSnapshot.snapshotname = $snapshotName
    New-NTNXSnapshot -SnapshotSpecs $newSnapshot

    # Get existing snapshots
    Get-NTNXSnapshot | Where-Object {$_.vmUuid -eq $nutvm.uuid}

      
}

disConnect-NutanixCluster -Server ip.ip.ip.ip



