$source_path = "d:\_move_to_Maxell_500Gb"
$filelist_path= $source_path + "\filelist.csv"
$files_to_include = "*.jpg", "*.jpeg", "*.avi", "*.mkv", "*.mpg", "*.mp[34]"
$paths_to_exclude = " " # add one space if there is no path to exclude

try {
	rm $filelist_path
} catch [ ItemNotFoundException ] {
}

try {
	"name,length,path" | Out-File -FilePath $filelist_path -Append -Encoding UTF8
} catch [ Exception ]
{
	exit
}

ls -LiteralPath $source_path -r -include $files_to_inlcude  | ? { 
	$_.GetType().Name -eq "FileInfo" -and ! (Select-String -InputObject $_.fullname -Pattern $paths_to_exclude -SimpleMatch)  } |% { 
      ($_.Name+ ","+ $_.Length + "," + $_.DirectoryName.Substring(2)) | Out-File -FilePath $filelist_path -Append -Encoding UTF8
}
