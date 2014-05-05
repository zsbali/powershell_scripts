$source_path = "h:\"
$destination_path = "g:\NO.DVD.Backup\Bali_gép_backup\jpg_jpeg\h"
$files_to_move = "*.jpg", "*.jpeg"
$paths_to_exclude = "i:\powershell_backup"

ls $source_path -r -include $files_to_move  | ? { ! (Select-String -InputObject $_.fullname -Pattern $paths_to_exclude -SimpleMatch)  } |% { 
   
   $new_dir_of_files = join-path $destination_path $_.directory.FullName.SubString(3)
   if ( (test-path $new_dir_of_files) -eq 0)
   {
        md -path $new_dir_of_files
   }
   cp $_ $new_dir_of_files   
   #mv $_ $new_dir_of_files      
}
