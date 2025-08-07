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
tuist scaffold app --name MyApp --platform ios --bundle-id com.example --version 1.0.0
```

**Options:**
- `name` (required): App name
- `platform`: Target platform (ios/macos)
- `bundle-id`: Bundle identifier prefix
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
tuist scaffold framework --name Core --is-static false --has-resources true
```

**Options:**
- `name` (required): Framework name
- `is-static`: Create static framework (default: false)
- `has-resources`: Include resources (default: false)
- `has-tests`: Include test target (default: true)
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
tuist scaffold extension --name MyWidget --type widget --host-app MyApp
```

**Options:**
- `name` (required): Extension name
- `type` (required): Extension type (widget, notification, share, etc.)
- `hostApp` (required): Host app name
- `bundle-id`: Bundle identifier prefix
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

#### Add App to Existing Project

Add additional app targets to an existing project:

```sh
tuist scaffold addapp --name DemoApp --platform macos --bundle-id com.mycompany.demo
```

**Options:**
- `name` (required): New app name
- `platform`: Target platform (ios, macos, watchos, tvos) (default: ios)
- `bundle-id`: Bundle identifier prefix (default: com.example)
- `version`: App version (default: 1.0.0)
- `hasTests`: Include test target (default: true)
- `hasUITests`: Include UI test target (default: false)

**Notes:**
- Use `addapp` only after creating the initial project with `app` template
- Does not overwrite existing Project.swift or Tuist configuration
- Automatically creates app target definition files
- Supports multiple platforms in same project (iOS + macOS + watchOS + tvOS)

#### Create a Workspace (Multi-App Support)

Generate a workspace supporting multiple app targets:

```sh
tuist scaffold workspace --name MyWorkspace --apps "MainApp,CompanionApp,AdminApp"
```

**Options:**
- `name` (required): Workspace name
- `apps` (required): Comma-separated list of app names
- `bundleIdPrefix`: Bundle identifier prefix (default: com.example)
- `structure`: Project structure - "single" or "multi" (default: multi)
- `sharedFrameworks`: Array of shared frameworks (default: ["Core", "Shared"])
- `version`: Version number (default: 1.0.0)

**Structure Options:**
- `single`: All apps in one project file
- `multi`: Separate project per app in workspace (recommended)

#### Add App to Existing Workspace

Add a new app to an existing workspace:

```sh
tuist scaffold multiapp --name NewApp --workspace MyWorkspace
```

**Options:**
- `name` (required): New app name
- `workspace` (required): Existing workspace name
- `bundleIdPrefix`: Bundle identifier prefix
- `sharedDependencies`: Dependencies on shared frameworks

---

### 3. Complete Example Workflows

#### Single App Project

```bash
# 1. Create the main app and project structure
tuist scaffold app --name MyApp --platform ios --bundle-id com.mycompany

# 2. Add a shared framework
tuist scaffold framework --name Core --has-resources false

# 3. Add feature modules
tuist scaffold module --name Authentication
tuist scaffold module --name UserProfile
tuist scaffold module --name Settings

# 4. Add a widget extension
tuist scaffold extension --name MyWidget --type widget --host-app MyApp

# 5. Add a file provider extension
tuist scaffold extension --name MyCloudSync --type fileprovider --host-app MyApp

# 6. Generate the project
tuist generate

# 7. Add additional apps to the same project (optional)
tuist scaffold addapp --name MyApp1 --platform macos --bundle-id com.mycompany.macos
tuist scaffold addapp --name DemoApp --platform ios --bundle-id com.mycompany.demo

# 8. Generate with all apps
tuist generate
```

#### Multi-App Workspace

```bash
# 1. Create workspace with multiple apps
tuist scaffold workspace --name MyWorkspace --apps "MainApp,AdminApp,CompanionApp" --bundleIdPrefix com.mycompany

# 2. Add additional frameworks to shared project
tuist scaffold framework --name NetworkLayer --hasResources false
tuist scaffold framework --name DatabaseLayer --hasResources false

# 3. Add more apps later
tuist scaffold multiapp --name DebugApp --workspace MyWorkspace --sharedDependencies "Core,Shared,NetworkLayer"

# 4. Add extensions for specific apps
tuist scaffold extension --name MainAppWidget --type widget --hostApp MainApp
tuist scaffold extension --name AdminDashboard --type today --hostApp AdminApp

# 5. Generate the workspace
tuist generate
```

#### Single Project with Multiple Apps

```bash
# 1. Create single project with multiple apps
tuist scaffold workspace --name MyProject --apps "MainApp,CompanionApp" --structure single --bundleIdPrefix com.mycompany

# 2. Generate the project
tuist generate
```

---

## 📁 Project Structure

### Single App Project
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

### Multi-App Workspace (Recommended)
```
MyWorkspace/
├── MyWorkspace.xcworkspace/
├── MainApp/
│   ├── Sources/
│   ├── Resources/
│   ├── Tests/
│   └── Project.swift
├── AdminApp/
│   ├── Sources/
│   ├── Resources/
│   ├── Tests/
│   └── Project.swift
├── CompanionApp/
│   ├── Sources/
│   ├── Resources/
│   ├── Tests/
│   └── Project.swift
├── Shared/            # Shared frameworks project
│   ├── Frameworks/
│   │   ├── Core/
│   │   └── Shared/
│   └── Project.swift
├── Tuist/
│   ├── Config.swift
│   └── ProjectDescriptionHelpers/
│       ├── WorkspaceFactory.swift
│       ├── TargetFactory.swift
│       └── ...
└── Workspace.swift
```

### Single Project with Multiple Apps
```
.
├── Products/
│   ├── MainApp/
│   ├── AdminApp/
│   └── CompanionApp/
├── Frameworks/        # Shared frameworks
├── Modules/           # Feature modules
├── Extensions/        # App extensions
├── Tuist/            # Tuist configuration
└── Project.swift      # Contains all apps
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
3. **Multi-App Architecture**: Choose the right structure for your needs:
   - **Workspace with separate projects**: Best for complex apps with different lifecycles
   - **Single project**: Good for related apps sharing most code
4. **Shared Frameworks**: Create `Core` for business logic, `Shared` for UI components
5. **Extensions**: Keep extension code minimal and focused
6. **File Provider**: Use File Provider extensions for cloud storage integration
7. **Testing**: Always include test targets for critical components
8. **Dependencies**: Use explicit dependencies between modules
9. **Bundle IDs**: Use consistent bundle ID prefixes across all apps in workspace
10. **Schemes**: Create separate schemes for each app target for easier development

### Multi-App Scenarios

**When to use Multiple Apps:**
- Main app + Admin/Debug companion app
- Consumer app + Business/Enterprise variant  
- iOS app + macOS app sharing code
- Different deployment targets (App Store vs Enterprise)
- A/B testing different app experiences

**Workspace vs Single Project:**
- **Use Workspace**: When apps have different release cycles, teams, or significant differences
- **Use Single Project**: When apps are closely related and developed together

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
