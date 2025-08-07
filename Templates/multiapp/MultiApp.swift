import Foundation
import ProjectDescription

/// # Usage
///
/// Add a new app to an existing workspace:
/// `tuist scaffold multiapp --name NewApp --workspace MyWorkspace`
///
/// This creates a new app project that integrates with an existing workspace.
/// The app can use shared frameworks and modules from the workspace.

let config = TemplateConfiguration()
let paths = TemplatePaths.self

let multiAppTemplate = Template(
    description: "Adds a new app target to an existing workspace",
    attributes: [
        config.name,
        config.platform,
        config.author,
        config.company,
        config.year,
        config.date,
        .required("workspace"),
        .optional("bundleIdPrefix", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasTests", default: .boolean(true)),
        .optional("sharedDependencies", default: .array(["Core", "Shared"]))
    ],
    items: multiAppTemplateItems()
)

func multiAppTemplateItems() -> [Template.Item] {
    let appName = "{{ name }}"
    let workspaceName = "{{ workspace }}"
    
    return [
        // App project structure
        .directory(path: "\(appName)/Sources"),
        .directory(path: "\(appName)/Resources"),
        .directory(path: "\(appName)/Tests"),
        
        // App project file
        .file(
            path: "\(appName)/Project.swift",
            templatePath: "AppProject.stencil"
        ),
        
        // App target definition
        .file(
            path: "\(appName)/Tuist/ProjectDescriptionHelpers/Targets/\(appName).swift",
            templatePath: "AppTarget.stencil"
        ),
        
        // App source files
        .file(
            path: "\(appName)/Sources/\(appName)App.swift",
            templatePath: "../Sources/App.stencil"
        ),
        .file(
            path: "\(appName)/Sources/ContentView.swift",
            templatePath: "../Sources/ContentView.stencil"
        ),
        
        // Resources
        .file(
            path: "\(appName)/Resources/InfoPlist.strings",
            templatePath: "../Resources/InfoPlist.strings"
        ),
        .directory(
            path: "\(appName)/Resources/Assets.xcassets",
            sourcePath: "../Resources/Assets.xcassets"
        ),
        
        // XCConfig files
        .directory(
            path: "\(appName)/Resources/XCConfig",
            sourcePath: .relativeToRoot("Templates/XCConfig")
        ),
        
        // Tests
        .file(
            path: "\(appName)/Tests/\(appName)Tests.swift",
            templatePath: "../TestSources/Tests.stencil"
        )
    ]
}