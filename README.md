# PowerShell
Started using PowerShell at my work, uploading some of my learning efforts.


1) dynamic_Test_Connection_Copy.ps1 ---> Test-connection function in do{}while loop with dynamic removing sources when connection is finally established and copy is finished. Using do|while loop for each source(remote machine) it checks the connection, if not esatblished it moves to the next one and tries again. Whenever connection is established it copies the files for that source and removes it from the array and tries the same thing for rest unsucesfull conection from the last run till it reaches maxAttempts or if copying is finished for each source in the array
