Add-Type -AssemblyName System.Drawing

# Paths
$SourceImage = "C:\Users\admin\.gemini\antigravity\brain\6423ccf4-4a13-42ec-9526-0d9d3a0cde15\ld_internal_training_thumb_smaller_1772536311212.png"
$DestDir = "C:\Users\admin\Desktop\ai-video-media\public\blog"
$DestFile = Join-Path $DestDir "internal-training-material-video-conversion.png"

# Read original
$img = [System.Drawing.Image]::FromFile($SourceImage)
$origW = $img.Width
$origH = $img.Height

# Calculate target 16:9 dimensions (keep width, crop height)
$targetW = $origW
$targetH = [Math]::Round($targetW * 9 / 16)

# Calculate crop Y (center)
$cropY = [Math]::Round(($origH - $targetH) / 2)

# Create new bitmap
$bmp = New-Object System.Drawing.Bitmap $targetW, $targetH
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

$srcRect = New-Object System.Drawing.Rectangle 0, $cropY, $targetW, $targetH
$destRect = New-Object System.Drawing.Rectangle 0, 0, $targetW, $targetH

# Draw crop
$g.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

# Save
$bmp.Save($DestFile, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$g.Dispose()
$bmp.Dispose()
$img.Dispose()

Write-Host "Cropped L&D thumbnail saved to: $DestFile"
