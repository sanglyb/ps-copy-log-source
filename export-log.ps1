Param (
[Parameter(Mandatory=$True)]
[string]$keys
)
mkdir $keys -erroraction silentlycontinue
cd $keys
clear-content "$keys.txt" -erroraction silentlycontinue

$matchingKeys=Get-childItem -path HKLM:\SYSTEM\CurrentControlSet\services\eventlog\ -recurse  | where-Object {$_.Name -like "*$keys*"}
$i=0
foreach ($regKey in $matchingKeys) {
	$path=$regkey | select-object -expandproperty name
	$file=get-itemproperty -path "registry::$path" | select-object *file* 
	#write-host $file
	foreach ($f in $file.PsObject.Properties) {
		$f=$f.value
		$f=$f.split(';')
		foreach ($pa in $f) {
			$pa=$pa.trim()
			copy "$pa" .\
		}
	}
	$path | out-file -filepath "$keys.txt" -append
	$path=$path.replace("HKEY_LOCAL_MACHINE","HKLM")
	reg export "$path" "$i.reg" /y
	$i++
	
	
}
cd ..