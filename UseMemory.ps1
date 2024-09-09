# use memory for testing purposes

$a = New-Object System.Collections.ArrayList

While ($true) 
{
    $null = $a.Add([Guid]::NewGuid().Guid*1mb)
}