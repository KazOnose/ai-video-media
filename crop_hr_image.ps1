Add-Type -AssemblyName System.Drawing
$inFile = "C:\Users\admin\.gemini\antigravity\brain\f6eb2c66-48ed-4d13-99c0-0351a857d6cb\hr_thumbnail_target_sekkei_v5_1773045587713.png"
$outFile = "c:\Users\admin\Desktop\ai-video-media\public\blog\hr\chuto-saiyou-douga-target-sekkei.png"

$img = [System.Drawing.Image]::FromFile($inFile)
$targetRatio = 16.0 / 9.0
$currentRatio = $img.Width / $img.Height
$cropW = $img.Width
$cropH = $img.Height

if ($currentRatio -gt $targetRatio) {
    $cropW = [int]($img.Height * $targetRatio)
}
elseif ($currentRatio -lt $targetRatio) {
    $cropH = [int]($img.Width / $targetRatio)
}

$x = [int]($img.Width - $cropW) / 2
$y = [int]($img.Height - $cropH) / 2

$rect = New-Object System.Drawing.Rectangle($x, $y, $cropW, $cropH)
$bmp = New-Object System.Drawing.Bitmap($cropW, $cropH)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.DrawImage($img, (New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$img.Dispose()
Write-Host "Cropped and saved to: $outFile"
