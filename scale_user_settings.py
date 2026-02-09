#!/usr/bin/env python3
"""
Script to scale Warhammer Online RoR UI user settings from HD (1920x1080) to 4K (3840x2160)
Scales all ModSettings.xml files in user/settings profiles.
"""

import os
import re
import xml.etree.ElementTree as ET
from pathlib import Path

# Configuration
SCALE_FACTOR = 2.0
BASE_DIR = Path(__file__).parent / "FiskgjuseUi1.74" / "user" / "settings"

# Attributes to scale (sizes and positions)
SCALABLE_FLOAT_ATTRS = {'sizeX', 'sizeY', 'xOffset', 'yOffset'}

# Attributes to NOT scale (these are ratios/factors, not absolute values)
NON_SCALABLE_ATTRS = {'scale', 'alpha', 'fontAlpha', 'xmlVersion'}


def scale_float_value(value_str, factor=SCALE_FACTOR):
    """Scale a float string value by the given factor."""
    try:
        value = float(value_str)
        scaled = value * factor
        # Preserve the same decimal format (6 decimal places)
        return f"{scaled:.6f}"
    except (ValueError, TypeError):
        return value_str


def scale_xml_attributes(element):
    """Recursively scale XML element attributes that should be scaled."""
    changes_made = False
    
    # Scale attributes on current element
    for attr in SCALABLE_FLOAT_ATTRS:
        if attr in element.attrib:
            old_value = element.attrib[attr]
            new_value = scale_float_value(old_value)
            if old_value != new_value:
                element.attrib[attr] = new_value
                changes_made = True
    
    # Recursively process child elements
    for child in element:
        if scale_xml_attributes(child):
            changes_made = True
    
    return changes_made


def process_xml_file(file_path):
    """Process a single XML file and scale appropriate values."""
    try:
        # Parse XML
        tree = ET.parse(file_path)
        root = tree.getroot()
        
        # Scale attributes
        changes_made = scale_xml_attributes(root)
        
        if changes_made:
            # Write back to file
            tree.write(file_path, encoding='UTF-8', xml_declaration=True, 
                      standalone=True, method='xml')
            return True
        return False
        
    except ET.ParseError as e:
        print(f"  ⚠️  XML Parse Error in {file_path}: {e}")
        return False
    except Exception as e:
        print(f"  ⚠️  Error processing {file_path}: {e}")
        return False


def find_and_process_xml_files():
    """Find and process all ModSettings.xml files in the user settings directory."""
    
    if not BASE_DIR.exists():
        print(f"❌ Base directory not found: {BASE_DIR}")
        return
    
    print(f"🔍 Searching for XML files in: {BASE_DIR}")
    print(f"📏 Scaling factor: {SCALE_FACTOR}x\n")
    
    # Find all ModSettings.xml files
    xml_files = list(BASE_DIR.rglob("ModSettings.xml"))
    
    if not xml_files:
        print("❌ No ModSettings.xml files found!")
        return
    
    print(f"📁 Found {len(xml_files)} ModSettings.xml files\n")
    
    processed_count = 0
    modified_count = 0
    
    for xml_file in xml_files:
        relative_path = xml_file.relative_to(BASE_DIR)
        print(f"Processing: {relative_path}")
        
        if process_xml_file(xml_file):
            print(f"  ✅ Modified")
            modified_count += 1
        else:
            print(f"  ⏭️  No changes needed")
        
        processed_count += 1
    
    print(f"\n{'='*60}")
    print(f"✅ Processing complete!")
    print(f"📊 Processed: {processed_count} files")
    print(f"✏️  Modified: {modified_count} files")
    print(f"{'='*60}\n")
    
    # Summary by profile
    print("Profile breakdown:")
    for profile in ["DAMAGE", "HEAL", "TANK"]:
        profile_files = [f for f in xml_files if profile in str(f)]
        if profile_files:
            print(f"  • {profile}: {len(profile_files)} files")
    
    print("\n🎮 Your UI settings are now scaled for 4K!")
    print("📝 Next steps:")
    print("   1. Copy the FiskgjuseUi1.74 folder to your game directory")
    print("   2. Start the game in 4K resolution")
    print("   3. Import one of the profiles (DAMAGE/HEAL/TANK)")
    print("   4. Enjoy your perfectly scaled UI! 🎉")


if __name__ == "__main__":
    find_and_process_xml_files()
