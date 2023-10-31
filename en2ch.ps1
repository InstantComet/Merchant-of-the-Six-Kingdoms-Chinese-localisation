$Translates = Get-Content -Path D:\TextReplacing\translate.txt -encoding utf8
$OgText = Get-Content -Path D:\TextReplacing\renderer.js -encoding utf8
$Length=$Translates.count
for ($index = 0; $index -lt $Length; $index++) {
    <# Action that will repeat until the condition is met #>
    $eng=($Translates[$index].Split('='))[0]
    $chn=($Translates[$index].Split('='))[1]
    Write-Output ("Replacing" + " "+ $eng)
    $NewText = $OgText.Replace($eng,$chn)
    $OgText = $NewText
    Write-Output $NewText
}

Set-Content -Path D:\TextReplacing\renderer.js -encoding utf8 -Value $NewText