#!/bin/bash

echo "Fixing iOS build issues..."

# Remove the -G flag from all xcconfig files
find ios/Pods -name "*.xcconfig" -type f -exec sed -i '' 's/-G //g' {} \;

# Fix DT_TOOLCHAIN_DIR issue
find ios/Pods -name "*.xcconfig" -type f -exec sed -i '' 's/DT_TOOLCHAIN_DIR/TOOLCHAIN_DIR/g' {} \;

# Fix the project.pbxproj file
if [ -f "ios/Pods/Pods.xcodeproj/project.pbxproj" ]; then
    sed -i '' 's/-GCC_WARN_INHIBIT_ALL_WARNINGS/-Wno-everything/g' ios/Pods/Pods.xcodeproj/project.pbxproj
fi

echo "iOS build fixes applied!"