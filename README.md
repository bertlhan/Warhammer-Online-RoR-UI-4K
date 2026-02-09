# Warhammer-Online-RoR-UI-4K
Warhammer Online RoR UI files scaled for 4K (3840x2160) resolution

## Overview
This repository contains the FiskgjuseUi 1.74 UI configuration files that have been systematically scaled by 2.0x to provide optimal visibility and usability on 4K displays (particularly 32-inch monitors).

## What's Changed
All UI element dimensions, positions, and coordinates in both **Lua AddOn files** and **XML user profile settings** have been multiplied by 2.0 to scale from HD (1920x1080) to 4K (3840x2160) resolution.

### Key Features
- ✅ **94 Lua AddOn files** scaled with 2.0x factor
- ✅ **156 XML user settings files** scaled across all 3 profiles (Damage/Heal/Tank)
- ✅ Window dimensions and positions scaled
- ✅ Anchor offsets scaled
- ✅ Texture dimensions scaled
- ✅ Original code structure and formatting preserved
- ✅ Colors, alphas, and scale factors unchanged

## Installation
1. Download or clone this repository
2. Copy the `FiskgjuseUi1.74` folder to your Warhammer Online RoR directory
3. Start the game in **4K resolution** (3840x2160)
4. **On first login** with your character:
   - A UI Profile import dialog will appear
   - Select one of the pre-scaled profiles:
     - **FiskgjuseUiDamage** - For DPS classes
     - **FiskgjuseUiHeal** - For Healer classes  
     - **FiskgjuseUiTank** - For Tank classes
   - Click **Import**
5. Enjoy properly sized UI elements!

## Target Configuration
- **Resolution:** 3840x2160 (4K)
- **Monitor Size:** 32 inches (recommended)
- **Scaling Factor:** 2.0x from original HD configuration
- **Profiles Included:** Damage, Heal, Tank (all scaled)

## Documentation
See [SCALING_NOTES.md](SCALING_NOTES.md) for detailed technical information about the scaling implementation.

## Credits
- Original UI: FiskgjuseUi 1.74
- 4K Scaling: Automated scaling applied to all UI dimensions and positions

## Support
If you experience any issues:
1. Verify your game is running in 4K resolution
2. Check individual AddOn settings for additional customization
3. Review SCALING_NOTES.md for implementation details
