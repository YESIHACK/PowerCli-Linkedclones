Connect-VIServer vcenter.subdomain.domain.local
# Connect to Vcenter server will ask for authentication

$sOriginVM="mastervm" # Mastervm is the vm you want to clone
$sOriginVMSnapshotName="mastervm_linkedclone_snap"
$sNewVMName="linkedclonevm"
$oVCenterFolder=(Get-VM $sOriginVM).Folder
$oSnapShot=New-Snapshot -VM $sOriginVM -Name $sOriginVMSnapshotName -Description "Snapshot for linked clones" -Memory -Quiesce
$oESXDatastore=Get-Datastore -Name "esxdatastore1"
$oLinkedClone=New-VM -Name $sNewVMName -VM $sOriginVM -Location $oVCenterFolder  -Datastore $oESXDatastore -ResourcePool Resources -LinkedClone -ReferenceSnapshot $oSnapShot
Start-VM $oLinkedClone

#Stop-VM $oLinkedClone -Confirm:$false
#Remove-VM -DeletePermanently $oLinkedClone -Confirm:$false
#Remove-Snapshot -Snapshot $oSnapShot -Confirm:$false
