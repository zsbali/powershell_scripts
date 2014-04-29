$source_dir = "d:\1temp\tmp3"
$outfile= $source_dir + "\filelist.csv"
#[Array] $filepatterns_to_include = "*.jpg", "*.jpeg", "*.avi", "*.mkv", "*.mpg", "*.mp[34]" # pattern only, NO path
[Array] $filepatterns_to_include = "*.*" 	# pattern only, NO path
[Array] $filepatterns_to_exclude		# pattern only, NO path
[Array] $files_to_exclude			# full path IS needed

rm $outfile -ErrorAction SilentlyContinue

try {
	"name,length,path" | Out-File -FilePath $outfile -Append -Encoding UTF8 -ErrorAction Stop
} catch [ Exception ]
{
	Write-Host "Can't write file, exiting."
	exit
}

$files_to_exclude += $outfile

ls $source_dir -r -include $filepatterns_to_include -Exclude $filepatterns_to_exclude | ? { 
	$_.GetType().Name -eq "FileInfo" -and ! (Select-String -InputObject $_.fullname -Pattern $files_to_exclude -SimpleMatch)  } |% { 
      ($_.Name+ ","+ $_.Length + "," + $_.DirectoryName.Substring(2)) | Out-File -FilePath $outfile -Append -Encoding UTF8
}
