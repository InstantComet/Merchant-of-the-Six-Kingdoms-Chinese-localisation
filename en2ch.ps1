$WorkingDirectory = "D:\TextReplacing"
$OriDirectory = "D:\SteamLibrary\steamapps\common\merchant_of_the_six_kingdoms\resources\ori\dist\electron"
$OutDirectory = "D:\SteamLibrary\steamapps\common\merchant_of_the_six_kingdoms\resources\output\dist\electron"

Set-location $WorkingDirectory
#删掉上一次生成的renderer.js
$paths =  "$WorkingDirectory\renderer.js"
foreach($filePath in $paths)
{
    if (Test-Path $filePath) {
        Remove-Item $filePath -verbose
    } else {
        Write-Host "Path doesn't exits"
    }
}

Copy-Item "$OriDirectory\renderer.js" -Destination "$WorkingDirectory"
#复制一份干净的renderer.js

$Translates = Get-Content -Path D:\TextReplacing\translate.txt -encoding utf8
$rendererpath = "D:\TextReplacing\renderer.js"

$OgText = Get-Content -Path $rendererpath -encoding utf8
$Length=$Translates.count
for ($index = 0; $index -lt $Length; $index++) {
    <# Action that will repeat until the condition is met #>
    $eng=($Translates[$index].Split('='))[0]
    $chn=($Translates[$index].Split('='))[1]
    Write-Output ("Replacing" + " "+ $eng)
    $NewText = $OgText.Replace($eng,$chn)
    $OgText = $NewText
}

Set-Content -Path $rendererpath -encoding utf8 -Value $NewText

Write-Output ("Outputing renderer.js")
Copy-Item "$WorkingDirectory\renderer.js" -Destination "$OutDirectory"

Set-location "D:\SteamLibrary\steamapps\common\merchant_of_the_six_kingdoms\resources"

Write-Output ("Packing app.asar")
asar.cmd pack output app.asar

Write-Output ("Done")