function test-inspection {
    param (
        #OptionalParameters
    )
    $request = $null
    $request = [System.Net.HttpWebRequest]::Create("https://admin.na.aadrm.com/admin/admin.svc")
    $request.GetResponse()
    write-host $request.ServicePoint.Certificate.Issuer -ForegroundColor Cyan
        

}


