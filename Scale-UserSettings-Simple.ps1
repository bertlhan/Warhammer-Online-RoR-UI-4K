# Simple PowerShell script to scale XML attributes in ModSettings.xml files
# Scales sizeX, sizeY, xOffset, yOffset by 2.0x

$ScaleFactor = 2.0
$BaseDir = Join-Path $PSScriptRoot "FiskgjuseUi1.74\user\settings"

Write-Host "Scaling UI settings from HD to 4K (${ScaleFactor}x)..." -ForegroundColor Cyan
Write-Host "Base directory: $BaseDir`n" -ForegroundColor White

# Find all ModSettings.xml files
$xmlFiles = Get-ChildItem -Path $BaseDir -Filter "ModSettings.xml" -Recurse

Write-Host "Found $($xmlFiles.Count) XML files to process`n" -ForegroundColor Green

$processedCount = 0
$modifiedCount = 0

foreach ($file in $xmlFiles) {
    $relativePath = $file.FullName.Substring($BaseDir.Length + 1)
    Write-Host "Processing: $relativePath" -ForegroundColor Gray
    
    try {
        # Read file content
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $originalContent = $content
        
        # Scale sizeX, sizeY, xOffset, yOffset attributes
        # Pattern matches: attribute="123.456789"
        $pattern = '(sizeX|sizeY|xOffset|yOffset)="(-?\d+\.?\d*)"'
        
        $content = [regex]::Replace($content, $pattern, {
            param($match)
            $attrName = $match.Groups[1].Value
            $oldValue = [double]$match.Groups[2].Value
            $newValue = $oldValue * $ScaleFactor
            return "$attrName=`"$($newValue.ToString('F6'))`""
        })
        
        if ($content -ne $originalContent) {
            # Write back to file
            [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
            Write-Host "  -> Modified" -ForegroundColor Green
            $modifiedCount++
        } else {
            Write-Host "  -> No changes" -ForegroundColor DarkGray
        }
        
        $processedCount++
    }
    catch {
        Write-Host "  -> ERROR: $_" -ForegroundColor Red
    }
}

Write-Host "`n" + ("="*60) -ForegroundColor Cyan
Write-Host "DONE!" -ForegroundColor Green
Write-Host "Processed: $processedCount files" -ForegroundColor White
Write-Host "Modified:  $modifiedCount files" -ForegroundColor White
Write-Host ("="*60) -ForegroundColor Cyan

Write-Host "`nProfile breakdown:" -ForegroundColor White
@("DAMAGE", "HEAL", "TANK") | ForEach-Object {
    $profile = $_
    $count = ($xmlFiles | Where-Object { $_.FullName -like "*\$profile\*" }).Count
    if ($count -gt 0) {
        Write-Host "  $profile : $count files" -ForegroundColor White
    }
}

Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Commit and push these changes to GitHub"
Write-Host "2. Copy FiskgjuseUi1.74 folder to your game directory"
Write-Host "3. Start game in 4K and import a profile"
Write-Host "`nAll done!" -ForegroundColor Green
