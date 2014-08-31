$source_path = "h:\"
$destination_path = "d:\1temp\tmp4"
$files_to_copy = "*.mp3", "*.wma"
$paths_to_exclude = "i:\powershell_backup"

ls $source_path -r -include $files_to_copy  | ? { 
   ! (Select-String -InputObject $_.fullname -Pattern $paths_to_exclude -SimpleMatch)  } | % { 
      $new_dir_of_files = join-path $destination_path $_.directory.FullName.SubString(3)
      if ( (test-path $new_dir_of_files) -eq 0)
      {
        md -path $new_dir_of_files
      }
      cp -LiteralPath $_ $new_dir_of_files   
      #mv $_ $new_dir_of_files      
}
