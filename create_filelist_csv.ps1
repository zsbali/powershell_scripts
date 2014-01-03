$source_path = "d:\angol"
$filelist_path= $source_path + "\filelist.csv"
$files_to_filter = "*.jpg", "*.jpeg", "*.avi", "*.mkv", "*.mpg", "*.mp[34]"
$paths_to_exclude = "i:\powershell_backup"

rm $filelist_path
"name,length,directory" | Out-File -FilePath $filelist_path -Append -Encoding UTF8

ls $source_path -r -include $files_to_filter  | ? { ! (Select-String -InputObject $_.fullname -Pattern $paths_to_exclude -SimpleMatch)  } |% { 
   
   #Write-Host $_.FullName
   ($_.Name+ ","+ $_.Length + "," + $_.DirectoryName.Substring(2)) | Out-File -FilePath $filelist_path -Append -Encoding UTF8
   
}