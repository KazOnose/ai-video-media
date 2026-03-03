Add-Type -AssemblyName System.Drawing

function CropTo16x9 {
    param([string]$inputPath, [string]$outputPath)
    $img = [System.Drawing.Image]::FromFile($inputPath)
    $w = $img.Width
    $h = $img.Height
    $targetRatio = 16.0 / 9.0
    $currentRatio = [double]$w / [double]$h

    if ($currentRatio -gt $targetRatio) {
        $newW = [int]($h * $targetRatio)
        $newH = $h
        $x = [int](($w - $newW) / 2)
        $y = 0
    }
    else {
        $newW = $w
        $newH = [int]($w / $targetRatio)
        $x = 0
        $y = [int](($h - $newH) / 2)
    }
    $rect = New-Object System.Drawing.Rectangle($x, $y, $newW, $newH)
    $bmp = New-Object System.Drawing.Bitmap($newW, $newH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($img, 0, 0, $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $img.Dispose()
    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Cropped: $outputPath"
}

$brain = "C:\Users\admin\.gemini\antigravity\brain\6423ccf4-4a13-42ec-9526-0d9d3a0cde15"
$hrDir = "c:\Users\admin\Desktop\ai-video-media\public\blog\hr"

$s = Get-ChildItem -Path $brain -Filter "hr_work_environment_refined_*.png" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
CropTo16x9 -inputPath $s.FullName -outputPath (Join-Path $hrDir "work-environment-visualization-video.png")
