Param (
[Parameter(Mandatory=$True)]
[string]$keys
)
cd $keys
mkdir C:\CustomEvents\$keys -erroraction silentlycontinue
$exclude=@("*.reg") 
get-childitem -exclude $exclude | copy-item -destination "C:\CustomEvents\$keys\"
$regs=get-childitem "*.reg"
foreach ($reg in $regs) {
	reg import $reg.name
}
$paths=get-content -path "$keys.txt"
foreach ($path in $paths) {
	#remove-item -path "registry::$path" -recurse
	$file=get-itemproperty -path "registry::$path" | select-object *file*
	foreach ($f in $file.PsObject.Properties) {
		$f1=$f.value
		$f1=$f1.split(';')
		$key=$null
		$i=0
		foreach ($pa in $f1) {
			$pa=$pa.trim()
			$pa=$pa.Substring($pa.lastIndexOf('\')+1)
			if ($i -eq 0) {
				$key="C:\CustomEvents\$keys\$pa"
			}
			else {
			$key="$key;C:\CustomEvents\$keys\$pa"
			}
			$i++
		}
		$name=$f.name
		$key
		set-itemproperty -path "registry::$path" -name "$name" -value "$key"
	}
}
cd ..