$path = "c:\Users\admin\Desktop\ai-video-media\src\content\blog\saas\system-architecture-video-visualization.md"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Fix bullet 1: garbled label
$content = $content -replace [regex]::Escape("ハイライト・妨睛蓮の使い分け"), "ハイライトと剥色の使い分け"
$content = $content -replace [regex]::Escape("色や枚枠でハイライトを唙し、他の要素を一時的に薄む（不透明度を下げる）手法は、観察者の視点"), "色や枠線でハイライトを施し、他の要素の不透明度を一時的に下げる手法は、視聴者の視点"

# Fix bullet 3: garbled text
$content = $content -replace [regex]::Escape("肥大したテロップで画面を埋めるのではなく"), "テロップで画面を埋めるのではなく"
$content = $content -replace [regex]::Escape("鐵則"), "大切なこと"
$content = $content -replace [regex]::Escape("視聴者の理解度を増大させる"), "視聴者の理解度を高める"

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done"
