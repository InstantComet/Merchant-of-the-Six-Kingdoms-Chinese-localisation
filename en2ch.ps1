$WorkingDirectory = "D:\TextReplacing"
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

#$Translates = Get-Content -Path D:\TextReplacing\Translates.ini -encoding utf8
$Translated = Get-Content -Path "D:\TextReplacing\tags_translated.json" -encoding utf8 | ConvertFrom-Json 

$ogrendererpath = "D:\TextReplacing\ori_renderer.js"

$OgText = Get-Content -Path $ogrendererpath -encoding utf8

for($index = 0; $index -lt $Translated.count; $index++) {
    #从文件里获取原文
    $eng = $Translated[$index].original
    #从文件里获取译文
    $chn = $Translated[$index].translation
    $eng = ('"'+$eng+'"')
    $chn = ('"'+$chn+'"')
    Write-Output ("Replacing" + " "+ $eng +" with " + $chn)
    #替换
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