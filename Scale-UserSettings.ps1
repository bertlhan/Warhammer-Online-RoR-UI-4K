# Scale Warhammer Online RoR UI user settings from HD (1920x1080) to 4K (3840x2160)
# Scales all ModSettings.xml files in user/settings profiles

param(
    [double]$ScaleFactor = 2.0
)

$BaseDir = Join-Path $PSScriptRoot "FiskgjuseUi1.74\user\settings"
$ScalableAttrs = @('sizeX', 'sizeY', 'xOffset', 'yOffset')

Write-Host "🔍 Searching for XML files in: $BaseDir" -ForegroundColor Cyan
Write-Host "📏 Scaling factor: ${ScaleFactor}x`n" -ForegroundColor Cyan

if (-not (Test-Path $BaseDir)) {
    Write-Host "❌ Base directory not found: $BaseDir" -ForegroundColor Red
    exit 1
}

# Find all ModSettings.xml files
$xmlFiles = Get-ChildItem -Path $BaseDir -Filter "ModSettings.xml" -Recurse

if ($xmlFiles.Count -eq 0) {
    Write-Host "❌ No ModSettings.xml files found!" -ForegroundColor Red
    exit 1
}

Write-Host "📁 Found $($xmlFiles.Count) ModSettings.xml files`n" -ForegroundColor Green

$processedCount = 0
$modifiedCount = 0

function Scale-XmlAttributes {
    param(
        [System.Xml.XmlElement]$Element,
        [double]$Factor
    )
    
    $changesMade = $false
    
    # Scale attributes on current element
    foreach ($attr in $ScalableAttrs) {
        if ($Element.HasAttribute($attr)) {
            $oldValue = $Element.GetAttribute($attr)
            try {
                $numValue = [double]$oldValue
                $newValue = $numValue * $Factor
                $newValueStr = $newValue.ToString("F6")
                
                if ($oldValue -ne $newValueStr) {
                    $Element.SetAttribute($attr, $newValueStr)
                    $changesMade = $true
                }
            } catch {
                # Skip if not a valid number
            }
        }
    }
    
    # Recursively process child elements
    foreach ($child in $Element.ChildNodes) {
        if ($child -is [System.Xml.XmlElement]) {
            if (Scale-XmlAttributes -Element $child -Factor $Factor) {
                $changesMade = $true
            }
        }
    }
    
    return $changesMade
}

foreach ($xmlFile in $xmlFiles) {
    $relativePath = $xmlFile.FullName.Replace("$BaseDir\", "")
    Write-Host "Processing: $relativePath" -ForegroundColor White
    
    try {
        # Load XML
        $xml = New-Object System.Xml.XmlDocument
        $xml.PreserveWhitespace = $false
        $xml.Load($xmlFile.FullName)
        
        # Scale attributes
        $changesMade = Scale-XmlAttributes -Element $xml.DocumentElement -Factor $ScaleFactor
        
        if ($changesMade) {
            # Create XML writer settings for proper formatting
            $writerSettings = New-Object System.Xml.XmlWriterSettings
            $writerSettings.Indent = $true
            $writerSettings.IndentChars = "    "
            $writerSettings.Encoding = [System.Text.Encoding]::UTF8
            $writerSettings.OmitXmlDeclaration = $false
            
            # Save the file
            $writer = [System.Xml.XmlWriter]::Create($xmlFile.FullName, $writerSettings)
            $xml.Save($writer)
            $writer.Close()
            
            Write-Host "  ✅ Modified" -ForegroundColor Green
            $modifiedCount++
        } else {
            Write-Host "  ⏭️  No changes needed" -ForegroundColor Gray
        }
        
        $processedCount++
        
    } catch {
        Write-Host "  ⚠️  Error: $_" -ForegroundColor Yellow
    }
}

Write-Host "`n$('='*60)" -ForegroundColor Cyan
Write-Host "✅ Processing complete!" -ForegroundColor Green
Write-Host "📊 Processed: $processedCount files" -ForegroundColor White
Write-Host "✏️  Modified: $modifiedCount files" -ForegroundColor White
Write-Host "$('='*60)`n" -ForegroundColor Cyan

# Profile breakdown
Write-Host "Profile breakdown:" -ForegroundColor Cyan
$profiles = @("DAMAGE", "HEAL", "TANK")
foreach ($profile in $profiles) {
    $profileFiles = $xmlFiles | Where-Object { $_.FullName -like "*\$profile\*" }
    if ($profileFiles.Count -gt 0) {
        Write-Host "  • ${profile}: $($profileFiles.Count) files" -ForegroundColor White
    }
}

Write-Host "`nYour UI settings are now scaled for 4K!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "   1. Copy the FiskgjuseUi1.74 folder to your game directory"
Write-Host "   2. Start the game in 4K resolution"
Write-Host "   3. Import one of the profiles (DAMAGE/HEAL/TANK)"
Write-Host "   4. Enjoy your perfectly scaled UI!"
