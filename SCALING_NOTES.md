# 4K UI Scaling - Implementation Notes

## Overview
This repository contains Warhammer Online RoR UI files that have been scaled from HD (1920x1080) to 4K (3840x2160) resolution by applying a 2.0x scaling factor to all UI dimensions and positions.

## Changes Applied

### Files Modified
- **Total files processed:** 398 Lua files
- **Files modified:** 94 files
- **Location:** `FiskgjuseUi1.74/Interface/AddOns/`

### Scaling Method
A Python script (`scale_ui_4k_v2.py`) was created to systematically identify and scale UI-related numerical values while preserving:
- Code structure and formatting
- Variable names and comments
- Non-UI numerical values (colors, alphas, scale factors, etc.)

### Values Scaled (×2.0)
1. **WindowSetDimensions calls**
   - Width and height parameters
   - Example: `WindowSetDimensions("Window", 250, 50)` → `WindowSetDimensions("Window", 500, 100)`

2. **WindowAddAnchor offset parameters**
   - X and Y offset values
   - Example: `WindowAddAnchor(..., -10, 20)` → `WindowAddAnchor(..., -20, 40)`

3. **Coordinate arrays**
   - 2D and 3D coordinate arrays
   - Example: `{100, 200}` → `{200, 400}`
   - Example: `min = {-5000, -5000}` → `min = {-10000, -10000}`

4. **Direct dimension assignments**
   - Width, height, size, offset, position variables
   - Example: `width = 170` → `width = 340`
   - Example: `offsetY = 18` → `offsetY = 36`

5. **Texture dimensions**
   - Texture size arrays
   - Example: `{256, 32}` → `{512, 64}`

### Values NOT Scaled
To ensure correctness, the following values were intentionally excluded from scaling:
1. Scale factors: 0.5, 1.0, 1.5, 2.0, etc.
2. Alpha/transparency values: 0.0-1.0 range
3. RGB color values: 0-255 range
4. Boolean values: true/false
5. Array indices and counts
6. Timer/duration values
7. IDs or constants
8. String values

## Examples of Changes

### Before (HD - 1920x1080)
```lua
WindowSetDimensions("MyWindow", 630, 480)
local offset = {10, 20}
WindowAddAnchor("Window1", "topleft", "Root", "topleft", 100, 50)
size = {50, 50}
width = 170
```

### After (4K - 3840x2160)
```lua
WindowSetDimensions("MyWindow", 1260, 960)
local offset = {20, 40}
WindowAddAnchor("Window1", "topleft", "Root", "topleft", 200, 100)
size = {100, 100}
width = 340
```

## Expected Behavior
When using these UI files on a 4K display:
- All UI elements will be approximately 2x larger on screen
- Proportions will be maintained
- UI will be comfortably visible on 32-inch 4K monitors
- All AddOns should remain functional

## Testing Recommendations
1. Test the UI on a 4K (3840x2160) display
2. Verify that all UI elements are properly sized and positioned
3. Check that all AddOns function correctly
4. Test window dragging and positioning
5. Verify that text is readable and properly scaled

## Technical Details
- **Base Resolution:** 1920x1080 (HD)
- **Target Resolution:** 3840x2160 (4K)
- **Scaling Factor:** 2.0x
- **Files Format:** Lua configuration files
- **Encoding:** UTF-8 and Latin-1 (as needed)

## Validation
- ✅ Code review: No issues found
- ✅ Security scan: No vulnerabilities detected
- ✅ Syntax: All Lua files maintain valid syntax
- ✅ Formatting: Original code structure preserved

## Maintenance
If you need to revert to HD resolution or apply a different scaling factor, you can:
1. Use the original HD files from the commit history before this scaling
2. Modify the `SCALE_FACTOR` constant in the scaling script
3. Re-run the script on the original files

## Support
For issues or questions about the scaling:
- Check that you're running the game in 4K resolution
- Verify your monitor size matches the expected 32-inch target
- Review the specific AddOn's documentation for any additional configuration

---
**Note:** This scaling was performed automatically using a systematic approach to ensure consistency across all UI elements. Individual AddOns may require additional manual adjustments for optimal appearance.
