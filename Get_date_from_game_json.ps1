# 读取json文件，并将其转换为powershell对象
$gamejson = Get-Content -Path "D:\TextReplacing\game_data.json" -encoding utf8 | ConvertFrom-Json 

# 定义一个空数组来存储过滤后的结果
$originals = @()

# 使用foreach循环遍历每个键值对然后添加到结果数组中
foreach ($obj in $gamejson) {
    $originals += $obj.tags
}


$result = $originals | Foreach-Object {
   [pscustomobject]@{key = $_}
}

$result | Add-Member -MemberType NoteProperty -Name "original" -Value " "

foreach ($obj in $result) {
    $obj.original = $obj.key
}

$result | Add-Member -MemberType NoteProperty -Name "translation" -Value ""

Write-Output $result

$result = $result  | ConvertTo-Json

# 将结果写入一个新的json文件中，并指定编码格式
Set-Content -Path "D:\TextReplacing\tags.json" -Value $result -Encoding UTF8

# 打印完成提示
Write-Output "Done"


