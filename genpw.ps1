function Get-RandomCharacters($length, $characters)
{
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}
 
function Scramble-String([string]$inputString)
{     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
}
 

function genpw()
{
    
    $password = Get-RandomCharacters -length 7 -characters 'abcdefghiklmnoprstuvwxyz'
    $password += Get-RandomCharacters -length 7 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
    $password += Get-RandomCharacters -length 7 -characters '0123456789'
    $password += Get-RandomCharacters -length 4 -characters '!$%&()=?}][{@#*+'
     
     
    $password = Scramble-String $password
    $password | clip
    return "New password sent to clipboard" 
    #return $password
}


