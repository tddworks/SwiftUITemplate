import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold app --name MyApp`
///
/// This will create a new app target with SwiftUI support.
///
/// To specify additional options:
/// `tuist scaffold app --name MyApp --platform ios --author "John Doe" --company "Acme Inc"`

let config = TemplateConfiguration()
let paths = TemplatePaths.self

let appTemplate = Template(
    description: "Creates a new iOS/macOS app target with SwiftUI support",
    attributes: [
        config.name,
        config.platform,
        config.author,
        config.company,
        config.year,
        config.date,
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasTests", default: .boolean(true)),
        .optional("hasUITests", default: .boolean(false))
    ],
    items: appTemplateItems()
)

func appTemplateItems() -> [Template.Item] {
    let name = "{{ name }}"
    let appPath = paths.productPath(name)
    
    var items: [Template.Item] = [
        // Project structure
        .directory(path: "Tuist", sourcePath: "../../ProjectDescriptionHelpers"),
        .directory(path: "\(appPath)/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        
        // Project files
        .file(path: "./Project.swift", templatePath: "Project.stencil"),
        .file(path: "./Package.swift", templatePath: "Package.stencil"),
        
        // Target definition
        .file(
            path: "\(paths.helpersPath)/Targets/Products/\(name).swift",
            templatePath: "Target.stencil"
        ),
        
        // App sources
        .file(
            path: "\(appPath)/Sources/\(name)App.swift",
            templatePath: "../Sources/App.stencil"
        ),
        .file(
            path: "\(appPath)/Sources/ContentView.swift",
            templatePath: "../Sources/ContentView.stencil"
        ),
        
        // Resources
        .file(
            path: "\(appPath)/Resources/InfoPlist.strings",
            templatePath: "InfoPlist.stencil"
        ),
        
        // Assets
        .directory(
            path: "\(appPath)/Resources/Assets.xcassets",
            sourcePath: "../Resources/Assets.xcassets"
        )
    ]
    
    // Conditionally add test files
    items.append(contentsOf: [
        .file(
            path: "\(appPath)/Tests/\(name)Tests.swift",
            templatePath: "../TestSources/Tests.stencil"
        )
    ])
    
    return items
}

func executeCommand(command: String, args: [String]) -> String {
    let task = Process()
    task.launchPath = command
    task.arguments = args
    let pipe = Pipe()

    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: data, as: UTF8.self)
    return output
}
