#Do test-connection function in do{}while loop with dynamic removing sources when connection is finally established and copy is finished

# Collection of remote machines as source, I've heard that ArrayList is old and should not be used? But with normal array I can't remove with Remove() function as array is fixed.
# There might be a better solution but for now it's working for me
[System.Collections.ArrayList]$sources = @(
    'dbcooperTEST_1',
    'dbcooperTEST_2',
    'dbcooperTEST_3',
    'dbcooperTEST_4'
)
# Write-Host $sources.GetType()
# Write-Host $sources.Count  

$destination = "Filip"
$maxAttempts = 3
$attempts = 0
$success = $false

#copy function for tests
function CopyFiles {
    Write-Host "Copying files"
    Write-Host "Copying finished"
}    

#Main do|while loop --> for each source(remote machine) it checks the connection, 
#if not esatblished it moves to the next one and tries again. 
#Whenever connection is established it copies the files for that source and removes it from the array and try the same thing for rest unsucesfull conection from the last run till it reaches maxAttempts or if copying is finished for every source in the array
    do {
        $attempts++
        Write-Host "Attempting to copy from $source to $destination (Attempt $attempts)"
        foreach ($computer in $($sources)) {
              Write-Host $computer
            if (Test-Connection -TargetName $computer -Quiet) {
                CopyFiles
                Write-Host "Copy operation successful."
                $sources.Remove($computer)
                Write-Host $sources.Count
                if($sources.Count -eq 0){
                    return $success = $true
                }
            }else {
                Write-Host "Copy operation failed"
            }
       }
    } while ($attempts -lt $maxAttempts) #3 attemps, with -lt operator (Less Than)
    Write-Host "Max attempts reached."
    return $false
