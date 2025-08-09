#!/bin/bash

# TaskMaster Example Project Generation Script
# This script demonstrates how to use the SwiftUITemplate to create a complete multi-app workspace

echo "🚀 Generating TaskMaster Workspace using SwiftUITemplate..."

# Step 1: Create the main workspace with multiple apps
echo "📁 Creating workspace with multiple apps..."
tuist scaffold workspace \
  --name TaskMasterWorkspace \
  --apps "TaskMaster,TaskMasterAdmin,TaskMasterLite" \
  --bundleIdPrefix com.taskmaster \
  --structure multi \
  --sharedFrameworks "Core,UI,Networking,Database" \
  --author "SwiftUITemplate" \
  --company "TaskMaster Inc"

# Step 2: Add additional shared frameworks
echo "🔧 Adding additional shared frameworks..."
tuist scaffold framework --name Analytics --hasResources false --author "SwiftUITemplate" --company "TaskMaster Inc"
tuist scaffold framework --name Security --hasResources false --author "SwiftUITemplate" --company "TaskMaster Inc"

# Step 3: Add feature modules
echo "📦 Adding feature modules..."
tuist scaffold module --name TaskManagement --author "SwiftUITemplate" --company "TaskMaster Inc"
tuist scaffold module --name UserManagement --author "SwiftUITemplate" --company "TaskMaster Inc"
tuist scaffold module --name TeamCollaboration --author "SwiftUITemplate" --company "TaskMaster Inc"
tuist scaffold module --name ReportGeneration --author "SwiftUITemplate" --company "TaskMaster Inc"

# Step 4: Add extensions for different apps
echo "🔌 Adding app extensions..."
tuist scaffold extension \
  --name TaskMasterWidget \
  --type widget \
  --hostApp TaskMaster \
  --bundleId com.taskmaster \
  --author "SwiftUITemplate" \
  --company "TaskMaster Inc"

tuist scaffold extension \
  --name TaskMasterFileSync \
  --type fileprovider \
  --hostApp TaskMaster \
  --bundleId com.taskmaster \
  --author "SwiftUITemplate" \
  --company "TaskMaster Inc"

tuist scaffold extension \
  --name AdminNotifications \
  --type notification \
  --hostApp TaskMasterAdmin \
  --bundleId com.taskmaster \
  --author "SwiftUITemplate" \
  --company "TaskMaster Inc"

# Step 5: Generate the complete workspace
echo "⚡ Generating Xcode workspace..."
tuist generate

echo "✅ TaskMaster workspace generated successfully!"
echo ""
echo "📋 Project Structure:"
echo "   - TaskMaster: Main consumer app"
echo "   - TaskMasterAdmin: Administrative app"  
echo "   - TaskMasterLite: Simplified version"
echo "   - Shared: Contains Core, UI, Networking, Database frameworks"
echo "   - Extensions: Widget, File Provider, Notifications"
echo "   - Modules: Feature-specific modules"
echo ""
echo "🎯 Next Steps:"
echo "   1. Open TaskMasterWorkspace.xcworkspace"
echo "   2. Build and run any of the app targets"
echo "   3. Customize the shared frameworks and modules"
echo ""