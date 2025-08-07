#!/bin/bash

# Script to automatically regenerate Project.swift by scanning all scaffolded targets
# No hard-coding - dynamically discovers all targets from the Targets directory

PROJECT_FILE="Project.swift"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Error: Project.swift not found"
    exit 1
fi

# Get the main app name from the first Products target file
APP_NAME=""
for app_file in Tuist/ProjectDescriptionHelpers/Targets/Products/*.swift; do
    if [ -f "$app_file" ] 2>/dev/null; then
        APP_NAME=$(basename "$app_file" .swift)
        break
    fi
done

if [ -z "$APP_NAME" ]; then
    echo "Error: Could not determine app name from Targets/Products directory"
    exit 1
fi

echo "🔄 Regenerating Project.swift for app: $APP_NAME"

# Create new Project.swift with dynamic target discovery
cat > "$PROJECT_FILE" << EOF
//
//  Project.swift
//  Auto-generated project configuration
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "$APP_NAME",
    organizationName: "",
    settings: .settings(
        base: SettingsDictionary()
            .marketingVersion("1.0")
            .currentProjectVersion("1")
            .automaticCodeSigning(devTeam: "")
    ),
    targets: $APP_NAME.targets + [
EOF

# Add framework targets
echo "        // Framework targets" >> "$PROJECT_FILE"
if [ -d "Tuist/ProjectDescriptionHelpers/Targets/Frameworks" ]; then
    for framework_file in Tuist/ProjectDescriptionHelpers/Targets/Frameworks/*.swift; do
        if [ -f "$framework_file" ]; then
            framework_name=$(basename "$framework_file" .swift)
            echo "        ${framework_name}.target," >> "$PROJECT_FILE"
            echo "        ${framework_name}.testTarget," >> "$PROJECT_FILE"
        fi
    done
fi

# Add module targets
echo "        // Module targets" >> "$PROJECT_FILE"
if [ -d "Tuist/ProjectDescriptionHelpers/Targets/Modules" ]; then
    for module_file in Tuist/ProjectDescriptionHelpers/Targets/Modules/*.swift; do
        if [ -f "$module_file" ]; then
            module_name=$(basename "$module_file" .swift)
            echo "        ${module_name}.target," >> "$PROJECT_FILE"
            echo "        ${module_name}.testTarget," >> "$PROJECT_FILE"
        fi
    done
fi

# Add extension targets
echo "        // Extension targets" >> "$PROJECT_FILE"
if [ -d "Tuist/ProjectDescriptionHelpers/Targets/Extensions" ]; then
    for ext_file in Tuist/ProjectDescriptionHelpers/Targets/Extensions/*.swift; do
        if [ -f "$ext_file" ]; then
            ext_name=$(basename "$ext_file" .swift)
            echo "        ${ext_name}.target," >> "$PROJECT_FILE"
        fi
    done
fi

# Add additional app targets (excluding the main app)
echo "        // Additional app targets" >> "$PROJECT_FILE"
if [ -d "Tuist/ProjectDescriptionHelpers/Targets/Products" ]; then
    for app_file in Tuist/ProjectDescriptionHelpers/Targets/Products/*.swift; do
        if [ -f "$app_file" ]; then
            app_name=$(basename "$app_file" .swift)
            # Skip the main app (it's already included via APP_NAME.targets)
            if [ "$app_name" != "$APP_NAME" ]; then
                echo "        ${app_name}.target," >> "$PROJECT_FILE"
                echo "        ${app_name}.testTarget," >> "$PROJECT_FILE"
            fi
        fi
    done
fi

# Complete the project configuration
cat >> "$PROJECT_FILE" << EOF
    ],
    schemes: [
        .scheme(
            name: "$APP_NAME",
            buildAction: .buildAction(targets: [
                .target($APP_NAME.target.name),
            ]),
            runAction: .runAction(
                arguments: .arguments(
                    environmentVariables: [
                        :
                    ],
                    launchArguments: [
                        .launchArgument(name: "-com.apple.CoreData.SQLDebug 0", isEnabled: true),
                        .launchArgument(name: "-com.apple.CoreData.CloudKitDebug 0", isEnabled: true),
                        .launchArgument(name: "-com.apple.CoreData.Logging.stderr 0", isEnabled: true),
                        .launchArgument(name: "-com.apple.CoreData.ConcurrencyDebug 0", isEnabled: true),
                        .launchArgument(name: "-com.apple.CoreData.MigrationDebug 0", isEnabled: true),
                    ]
                )
            )
        )
    ],
    fileHeaderTemplate: "  Created by ___FULLUSERNAME___ on ___DATE___.\n//  ___COPYRIGHT___"
)
EOF

echo "✅ Successfully regenerated Project.swift!"
echo ""
echo "📁 Included targets:"

# Show what was included
framework_count=0
module_count=0  
extension_count=0
app_count=0

[ -d "Tuist/ProjectDescriptionHelpers/Targets/Frameworks" ] && framework_count=$(ls Tuist/ProjectDescriptionHelpers/Targets/Frameworks/*.swift 2>/dev/null | wc -l | tr -d ' ')
[ -d "Tuist/ProjectDescriptionHelpers/Targets/Modules" ] && module_count=$(ls Tuist/ProjectDescriptionHelpers/Targets/Modules/*.swift 2>/dev/null | wc -l | tr -d ' ')
[ -d "Tuist/ProjectDescriptionHelpers/Targets/Extensions" ] && extension_count=$(ls Tuist/ProjectDescriptionHelpers/Targets/Extensions/*.swift 2>/dev/null | wc -l | tr -d ' ')

additional_apps=$(ls Tuist/ProjectDescriptionHelpers/Targets/Products/*.swift 2>/dev/null | wc -l | tr -d ' ')
if [ "$additional_apps" -gt 1 ]; then
    app_count=$((additional_apps - 1))  # Subtract main app
fi

echo "   📱 Main app: $APP_NAME"
[ "$framework_count" -gt 0 ] && echo "   🏗️  Frameworks: $framework_count"
[ "$module_count" -gt 0 ] && echo "   📦 Modules: $module_count"  
[ "$extension_count" -gt 0 ] && echo "   🧩 Extensions: $extension_count"
[ "$app_count" -gt 0 ] && echo "   📱 Additional apps: $app_count"

echo ""
echo "🚀 Ready to generate: tuist generate"