# 从para下载的json里会读原文和译文
$translated = Get-Content -Path "D:\TextReplacing\tags_translated.json" -encoding utf8 | ConvertFrom-Json 

for($index = 0; $index -lt $translated.count; $index++) {
    $eng = $target[$index].original
    $chn = $target[$index].translation
    $eng = ('"'+$eng+'"')
    $chn = ('"'+$chn+'"')
    Write-Output $eng $chn
}


