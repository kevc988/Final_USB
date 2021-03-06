Function JSON()
{
    
    $content = Get-Content -Raw -Path Output.json | ConvertFrom-Json
    return $content


}





Function DISKPART_MOUNT_SCRIPT($DiskNum) 
{ 
    
    ADD-CONTENT -Path bootemup.txt -Value "SELECT DISK 2"
    ADD-CONTENT -Path bootemup.txt -Value "CLEAN" 
    ADD-CONTENT -Path bootemup.txt -Value "CREATE PARTITION PRIMARY" 
    ADD-CONTENT -Path bootemup.txt -Value "FORMAT FS=FAT32 QUICK"  
    ADD-CONTENT -Path bootemup.txt -value "ACTIVE"
   
}

Function INVOKE-USBBOOT() 
{  
	New-Item -Path bootdown.txt -ItemType file -force | OUT-NULL
    New-Item -Path bootemup.txt -ItemType file -force | OUT-NULL
    DISKPART_MOUNT_SCRIPT(JSON)
    DISKPART /S bootemup.txt

 
}

JSON
INVOKE-USBBOOT