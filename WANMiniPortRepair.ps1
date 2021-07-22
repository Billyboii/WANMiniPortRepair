function removeminiport ($odstranitport){
$allLines = (cmd /c "devcon-x64 /findall $odstranitport") | Out-String
[string[]]$radky = $allLines.Split("`n",[System.StringSplitOptions]::RemoveEmptyEntries)
foreach ($element in $radky) {
if($element -Like "*WAN Miniport*") {
$pos = $element.IndexOf("   ")
$leftPart = $element.Substring(0, $pos)
$leftPart = $leftpart.trim()
if($leftPart.Length -gt 0 ) {
echo($leftPart)
& $global:cesta sethwid "@$leftPart" := +*msloop !$odstranitport
		& $global:cesta update "$global:ovladac" *msloop
		& $global:cesta remove *msloop
		& $global:cesta remove "@$leftPart"
}}}}
[string] $global:cesta = (Get-Location -PSProvider FileSystem).ProviderPath + "\devcon-x64.exe"
$global:ovladac = "$env:windir\inf\netloop.inf"
if(Test-Path $ovladac){
	if(Test-Path $cesta){
		removeminiport "MS_AgileVpnMiniport"
		removeminiport "MS_NdisWanIp"
		removeminiport "MS_NdisWanIpv6"
		removeminiport "MS_NdisWanBh"
		removeminiport "MS_L2tpMiniport"
		removeminiport "MS_PppoeMiniport"
		removeminiport "MS_PptpMiniport"
		removeminiport "MS_SstpMiniport"
	}}
