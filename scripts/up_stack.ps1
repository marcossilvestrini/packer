# Modules - Execute with Administrator privilegies
# Install-Module -Name vmxtoolkit

# Variables
$vmware = "E:\VMware\vmware.exe"
$vmrun = "E:\VMWare\vmrun.exe"
$port = "22"

# Up vmware
Write-Host "Up Vmware Workstation in path: [$($vmware)]" -BackgroundColor White -ForegroundColor Black
& $vmware

# Up VM srv-devops
$vm = "E:\Servers\Linux\vagrant-ansible\vagrant-ansible.vmx"
$ip = "192.168.0.33"

## Power Off Virtual Machine if On
Write-Host "Power Off Virtual Machine: [$($vm)]" -BackgroundColor White -ForegroundColor Black
& $vmrun stop $vm >$null

## Set Memory
$vmxName = "vagrant-ansible"
$memoryMB = "8192"
$processors= "3"
$vmxConfig = (Get-VMX -VMXName $vmxName).Config
# SYNTAX: Set-VMXmemory [-VMXName <Object>] [-config <Object>] -MemoryMB <Int32> [<CommonParameters>]
Set-VMXmemory -VMXName $vmxName -config $vmxConfig -MemoryMB $memoryMB

# Set CPU
Set-VMXprocessor  -VMXName $vmxName -config $vmxConfig -Processorcount $processors

## Power On Virtual Machine
Write-Host "Power On Virtual Machine: [$($vm)]" -BackgroundColor White -ForegroundColor Black
& $vmrun start $vm

## Check Status for SHH Connection
$tcp_test = $false
Write-Host "Check VM Status ..." -BackgroundColor White -ForegroundColor Black
While (!$tcp_test) {
    $tcp_test = (Test-NetConnection -ComputerName $ip -RemotePort $port).TcpTestSucceeded
    if ($tcp_test) {
        Write-Host "VM is Running!!!" -BackgroundColor White -ForegroundColor Green
        Start-Sleep 2
        break;
    }
    Else {
        Write-Host "VM in process of initialization...Waiting" -BackgroundColor White -ForegroundColor Black
        Start-Sleep 1
    }
}