#!/bin/bash

# Test script to verify Tuist plugin setup
echo "🧪 Testing SwiftUITemplate Plugin Setup..."

# Check if Tuist is installed
if ! command -v tuist &> /dev/null; then
    echo "❌ Tuist is not installed. Please install it first:"
    echo "   curl -Ls https://install.tuist.io | bash"
    exit 1
fi

echo "✅ Tuist is installed"

# Check if Tuist.swift exists
if [ ! -f "Tuist.swift" ]; then
    echo "❌ Tuist.swift not found. Creating it..."
    cat > Tuist.swift << 'EOF'
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .local(path: "../../") // Point to SwiftUITemplate
    ])
)
EOF
    echo "✅ Created Tuist.swift"
fi

# List available templates from the plugin
echo "📋 Available templates from SwiftUITemplate plugin:"
tuist scaffold list || {
    echo "❌ Failed to list templates. Check plugin configuration."
    exit 1
}

echo "✅ Plugin setup test completed successfully!"
echo ""
echo "📋 Available templates:"
tuist scaffold list
echo ""
echo "🎯 Ready to generate projects! Try these commands:"
echo "   tuist scaffold app --name TestApp"
echo "   tuist scaffold framework --name TestFramework" 
echo "   tuist scaffold module --name TestModule"
echo "   tuist scaffold extension --name TestWidget --type widget --hostApp TestApp"
echo "   tuist scaffold multiapp --name NewApp --workspace ExistingWorkspace"
echo ""
echo "✨ Plugin is working correctly!"