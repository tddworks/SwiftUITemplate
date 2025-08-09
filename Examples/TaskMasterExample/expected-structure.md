# Expected Generated Structure

When running the generation script with the SwiftUITemplate plugin, this is the structure that would be created:

## After running: `tuist scaffold workspace --name TaskMasterWorkspace --apps "TaskMaster,TaskMasterAdmin,TaskMasterLite"`

```
TaskMasterExample/
├── Tuist.swift                          # Plugin configuration
├── Tuist/
│   └── Config.swift                     # Tuist configuration
├── TaskMasterWorkspace.xcworkspace/
│   └── contents.xcworkspacedata        # Workspace definition
├── Workspace.swift                      # Generated workspace file
├── TaskMaster/
│   ├── Project.swift                   # Generated using WorkspaceFactory
│   ├── Sources/
│   │   ├── TaskMasterApp.swift         # Generated from App.stencil
│   │   └── ContentView.swift           # Generated from ContentView.stencil
│   ├── Resources/
│   │   ├── Assets.xcassets/
│   │   ├── InfoPlist.strings           # Generated from InfoPlist.stencil
│   │   └── XCConfig/
│   │       ├── debug.xcconfig
│   │       ├── release.xcconfig
│   │       └── shared.xcconfig
│   └── Tests/
│       └── TaskMasterTests.swift       # Generated from Tests.stencil
├── TaskMasterAdmin/
│   ├── Project.swift
│   ├── Sources/
│   │   ├── TaskMasterAdminApp.swift
│   │   └── ContentView.swift
│   ├── Resources/
│   └── Tests/
├── TaskMasterLite/
│   ├── Project.swift
│   ├── Sources/
│   │   ├── TaskMasterLiteApp.swift
│   │   └── ContentView.swift
│   ├── Resources/
│   └── Tests/
└── Shared/
    ├── Project.swift                    # Generated with shared frameworks
    └── Frameworks/
        ├── Core/
        │   ├── Sources/
        │   │   └── Core.swift          # Generated from FrameworkSource.stencil
        │   └── Tests/
        │       └── CoreTests.swift     # Generated from FrameworkTests.stencil
        ├── UI/
        │   ├── Sources/
        │   ├── Resources/
        │   └── Tests/
        ├── Networking/
        │   ├── Sources/
        │   └── Tests/
        └── Database/
            ├── Sources/
            ├── Resources/
            └── Tests/
```

## After running: `tuist scaffold extension --name TaskMasterWidget --type widget --hostApp TaskMaster`

```
Extensions/
└── TaskMasterWidget/
    ├── Sources/
    │   ├── TaskMasterWidget.swift      # Generated from WidgetExtension.stencil
    │   └── TaskMasterWidgetView.swift  # Generated from ExtensionView.stencil
    ├── Resources/
    │   ├── Info.plist                  # Generated from ExtensionInfo.stencil
    │   └── TaskMasterWidget.entitlements # Generated from ExtensionEntitlements.stencil
    └── Tuist/ProjectDescriptionHelpers/Targets/Extensions/
        └── TaskMasterWidget.swift      # Generated from ExtensionTarget.stencil
```

## After running: `tuist scaffold module --name TaskManagement`

```
Modules/
└── TaskManagement/
    ├── Sources/
    │   └── TaskManagement.swift        # Generated from module template
    ├── Resources/
    │   └── XCConfig/
    └── Tuist/ProjectDescriptionHelpers/Targets/Modules/
        └── TaskManagement.swift        # Generated target definition
```

## Final Structure After All Commands

```
TaskMasterExample/
├── Tuist.swift                         # Plugin configuration
├── Tuist/
│   ├── Config.swift
│   └── ProjectDescriptionHelpers/      # Copied from SwiftUITemplate
│       ├── TargetFactory.swift
│       ├── TargetExtensions.swift
│       ├── WorkspaceFactory.swift
│       ├── SourcePaths.swift
│       ├── SettingsFactory.swift
│       └── Targets/
│           ├── Products/
│           ├── Modules/
│           ├── Frameworks/
│           └── Extensions/
├── TaskMasterWorkspace.xcworkspace/
├── Workspace.swift
├── TaskMaster/ (App Project)
├── TaskMasterAdmin/ (App Project)  
├── TaskMasterLite/ (App Project)
├── Shared/ (Frameworks Project)
├── Extensions/ (App Extensions)
├── Modules/ (Feature Modules)
└── generate-project.sh                 # Generation script
```

## Key Benefits

1. **Plugin Integration**: Uses local SwiftUITemplate as Tuist plugin
2. **Modular Architecture**: Each app can be developed independently
3. **Shared Code**: Common frameworks reduce duplication
4. **Scalable**: Easy to add new apps, modules, or extensions
5. **Type Safety**: Generated target definitions use our helper factories
6. **Consistent**: All projects follow the same patterns and conventions