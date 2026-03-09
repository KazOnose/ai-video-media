Add-Type -AssemblyName System.Drawing

$hrDir = "c:\Users\admin\Desktop\ai-video-media\public\blog\hr"
$ldDir = "c:\Users\admin\Desktop\ai-video-media\public\blog\ld"

if (-not (Test-Path $hrDir)) { New-Item -ItemType Directory -Force -Path $hrDir }
if (-not (Test-Path $ldDir)) { New-Item -ItemType Directory -Force -Path $ldDir }

function Crop16x9($inFile, $outFile) {
    if (-not (Test-Path $inFile)) {
        Write-Host "File not found: $inFile"
        return
    }
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
    
    $x = [int](($img.Width - $cropW) / 2)
    $y = [int](($img.Height - $cropH) / 2)
    
    $rect = New-Object System.Drawing.Rectangle($x, $y, $cropW, $cropH)
    $bmp = New-Object System.Drawing.Bitmap($cropW, $cropH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($img, (New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    
    $bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    $img.Dispose()
    Write-Host "Cropped and saved to: $outFile"
}

Crop16x9 "C:\Users\admin\.gemini\antigravity\brain\57e0632d-059f-4734-8081-a3ee59cee8a2\newgrad_video_structure_1772869558657.png" "$hrDir\newgrad-video-structure.png"
Crop16x9 "C:\Users\admin\.gemini\antigravity\brain\57e0632d-059f-4734-8081-a3ee59cee8a2\short_video_mass_production_1772869576209.png" "$ldDir\short-video-mass-production.png"
