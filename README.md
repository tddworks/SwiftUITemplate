# SwiftUITemplate - Modular Architecture

A comprehensive [Tuist](https://tuist.io/) template for building SwiftUI projects with modular architecture, supporting apps, frameworks, and extensions.

## 🚀 Features

- **Modular Architecture**: Clean separation between apps, frameworks, modules, and extensions
- **Multiple Target Types**: Support for apps, frameworks (static/dynamic), and various app extensions
- **SwiftUI Ready**: Templates come with SwiftUI boilerplate code
- **Configurable**: Flexible configuration options for each target type
- **Test Support**: Automatic test target generation with configurable options
- **Organized Structure**: Pre-configured folder structure for easy project maintenance

---

## 🛠️ Getting Started

### 1. Add the Template to Your Project

Add this template as a Tuist plugin in your `Project.swift`:

```swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .git(url: "https://github.com/tddworks/SwiftUITemplate", tag: "v1.0.1")
    ])
)
```

---

### 2. Available Templates

#### Create a New SwiftUI App

Generate a new SwiftUI application:

```sh
tuist scaffold app --name MyApp --platform ios --bundleId com.example --version 1.0.0
```

**Options:**
- `name` (required): App name
- `platform`: Target platform (ios/macos)
- `bundleId`: Bundle identifier prefix
- `version`: App version
- `hasTests`: Include test target (default: true)
- `hasUITests`: Include UI test target (default: false)

**Resulting Structure:**
```
Root/
├── Tuist/ProjectDescriptionHelpers/Targets/Products/MyApp.swift
├── Products/
│   ├── MyApp/
│   │   ├── Resources/
│   │   │   ├── Assets.xcassets
│   │   │   └── InfoPlist.strings
│   │   ├── Sources/
│   │   │   ├── MyAppApp.swift
│   │   │   └── ContentView.swift
│   │   └── Tests/
│   │       └── MyAppTests.swift
└── Project.swift
```

---

#### Create a Framework

Generate a reusable framework:

```sh
tuist scaffold framework --name Core --isStatic false --hasResources true
```

**Options:**
- `name` (required): Framework name
- `isStatic`: Create static framework (default: false)
- `hasResources`: Include resources (default: false)
- `hasTests`: Include test target (default: true)
- `dependencies`: Array of dependencies

**Resulting Structure:**
```
Root/
├── Tuist/ProjectDescriptionHelpers/Targets/Frameworks/Core.swift
├── Frameworks/
│   ├── Core/
│   │   ├── Resources/
│   │   ├── Sources/
│   │   │   ├── Core.swift
│   │   │   └── CoreInterface.swift
│   │   └── Tests/
│   │       └── CoreTests.swift
```

#### Create a Module

Generate a feature module:

```sh
tuist scaffold module --name FeatureAuth
```

**Resulting Structure:**
```
Root/
├── Tuist/ProjectDescriptionHelpers/Targets/Modules/FeatureAuth.swift
├── Modules/
│   └── FeatureAuth/
│       ├── Resources/
│       └── Sources/
│           └── FeatureAuth.swift
```

#### Create an Extension

Generate an app extension:

```sh
tuist scaffold extension --name MyWidget --type widget --hostApp MyApp
```

**Options:**
- `name` (required): Extension name
- `type` (required): Extension type (widget, notification, share, etc.)
- `hostApp` (required): Host app name
- `bundleId`: Bundle identifier prefix
- `version`: Extension version
- `hasUI`: Include UI components (default: true)

**Available Extension Types:**
- `widget`: Widget Extension
- `notification`: Notification Service Extension
- `action`: Action Extension
- `share`: Share Extension
- `today`: Today Extension
- `intents`: Intents Extension
- `intentui`: Intents UI Extension
- `fileprovider`: File Provider Extension
- `fileproviderui`: File Provider UI Extension

---

### 3. Complete Example Workflow

```bash
# 1. Create the main app
tuist scaffold app --name MyApp --platform ios --bundleId com.mycompany

# 2. Add a shared framework
tuist scaffold framework --name Core --hasResources false

# 3. Add feature modules
tuist scaffold module --name Authentication
tuist scaffold module --name UserProfile
tuist scaffold module --name Settings

# 4. Add a widget extension
tuist scaffold extension --name MyWidget --type widget --hostApp MyApp

# 5. Add a file provider extension
tuist scaffold extension --name MyCloudSync --type fileprovider --hostApp MyApp

# 6. Generate the project
tuist generate
```

---

## 📁 Project Structure

```
.
├── Products/          # App targets
├── Modules/           # Feature modules
├── Frameworks/        # Shared frameworks
├── Extensions/        # App extensions
├── Tuist/            # Tuist configuration
│   └── ProjectDescriptionHelpers/
│       ├── Targets/
│       │   ├── Products/    # App target definitions
│       │   ├── Modules/     # Module target definitions
│       │   ├── Frameworks/  # Framework target definitions
│       │   └── Extensions/  # Extension target definitions
│       ├── TargetFactory.swift
│       ├── TargetExtensions.swift
│       ├── SourcePaths.swift
│       └── SettingsFactory.swift
└── Project.swift
```

---

## Special Extension Types

### File Provider Extensions

File Provider extensions allow your app to provide files to the Files app and other document-based apps. Two types are supported:

#### File Provider Extension
- Provides file enumeration and management capabilities
- Handles file operations like create, read, update, delete
- Integrates with the Files app and document picker

```bash
tuist scaffold extension --name MyCloudProvider --type fileprovider --hostApp MyApp
```

#### File Provider UI Extension  
- Provides custom UI for file provider actions
- Handles user interactions for file operations
- Works in conjunction with File Provider Extension

```bash
tuist scaffold extension --name MyCloudProviderUI --type fileproviderui --hostApp MyApp
```

**Generated Features:**
- Complete `FileProviderExtension` class with item management
- File enumeration and sync anchor support
- SwiftUI-based action interface for UI extension
- Proper entitlements for file system access
- App group configuration for data sharing

---

## Target Factory Methods

The project provides a comprehensive `TargetFactory` with methods for creating different target types:

### App Targets
- `createAppTarget()`: Creates an app target
- `createAppTestTarget()`: Creates app unit tests

### Framework Targets
- `createFramework()`: Creates a dynamic framework
- `createStaticFramework()`: Creates a static framework
- `createFrameworkTests()`: Creates framework tests

### Extension Targets
- `createExtension()`: Creates an app extension with configurable type

### Configuration

Edit `Config.swift` to modify:
- Compatible Xcode versions
- Swift version
- Generation options

Each target type can be configured with:
- Bundle identifiers
- Destinations (iOS, macOS, etc.)
- Resources
- Dependencies
- Build settings

---

## Best Practices

1. **Modular Development**: Break your app into feature modules for better code organization
2. **Shared Code**: Use frameworks for code shared between targets
3. **Extensions**: Keep extension code minimal and focused
4. **File Provider**: Use File Provider extensions for cloud storage integration
5. **Testing**: Always include test targets for critical components
6. **Dependencies**: Use explicit dependencies between modules

---

## 📚 Learn More

- [Tuist Documentation](https://docs.tuist.io/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.
