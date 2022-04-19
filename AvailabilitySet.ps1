New-AzResourceGroup `
   -Name ResGrp `
   -Location EastUS

New-AzAvailabilitySet `
   -Location "EastUS" `
   -Name "AvblSet" `
   -ResourceGroupName "ResGrp" `
   -Sku aligned `
   -PlatformFaultDomainCount 2 `
   -PlatformUpdateDomainCount 2
$cred = Get-Credential

for ($i=1; $i -le 2; $i++)
{
    New-AzVm `
        -ResourceGroupName "ResGrp" `
        -Name "VM$i" `
        -Location "East US" `
        -VirtualNetworkName "Vnet" `
        -SubnetName "Sub" `
        -SecurityGroupName "myNetworkSecurityGroup" `
        -PublicIpAddressName "Pbip$i" `
        -AvailabilitySetName "mAvblSet" `
        -Credential $cred
}

Get-AzVMSize `
   -ResourceGroupName "ResGrp" `
   -AvailabilitySetName "AvblySet"