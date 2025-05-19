# SwiftUITemplate
Tuist template
```swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
         .git(url: "https://github.com/tddworks/SwiftUITemplate", tag: "v1.0.0")
    ])
)
```
The template is a starting point for creating a SwiftUI application using Tuist. It includes the following features:
- Create a SwiftUI application
  -  tuist scaffold app --name AppName
    - will create folder structure like this:
      - Root
        - Tuist/ProjectDescriptionHelpers/Targets/Products/AppName.swift // -> Generate target for AppName from Target.stencil
        - Products
          - AppName
            - Resources
              - Info.plist
            - Sources
              - AppNameApp.swift
              - ContentView.swift
          - AppNameTests
            - Resources
            - Sources
              - AppNameTests.swift
        - Project.swift
- Create a Modules framework
  - tuist scaffold module --name ModuleName
    - will create folder structure like this:
      - Root
        - Tuist/ProjectDescriptionHelpers/Targets/Products/ModuleName.swift // -> Generate target for ModuleName from Target.stencil
        - Modules
          - ModuleName
            - Resources
              - Info.plist
            - Sources
              - ModuleName.swift
          - ModuleNameTests
            - Resources
            - Sources
              - ModuleNameTests.swift
