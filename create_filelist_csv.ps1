$source_dir = "d:"
$filelist_path= $source_dir + "\filelist.csv"
$files_to_include = "*.jpg", "*.jpeg", "*.avi", "*.mkv", "*.mpg", "*.mp[34]"
$dirs_to_exclude = " " # add one space if there is no path to exclude

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

ls $source_dir -r -include $files_to_include  | ? { 
	$_.GetType().Name -eq "FileInfo" -and ! (Select-String -InputObject $_.fullname -Pattern $dirs_to_exclude -SimpleMatch)  } |% { 
      ($_.Name+ ","+ $_.Length + "," + $_.DirectoryName.Substring(2)) | Out-File -FilePath $filelist_path -Append -Encoding UTF8
}
