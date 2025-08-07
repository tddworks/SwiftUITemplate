import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold framework --name MyFramework`
///
/// This will create a new framework target for code reuse.
///
/// To specify additional options:
/// `tuist scaffold framework --name MyFramework --platform ios --hasResources true`

let config = TemplateConfiguration()
let paths = TemplatePaths.self

let frameworkTemplate = Template(
    description: "Creates a new framework target for shared code",
    attributes: [
        config.name,
        config.platform,
        config.author,
        config.company,
        config.year,
        config.date,
        .optional("hasResources", default: .boolean(false)),
        .optional("hasTests", default: .boolean(true)),
        .optional("dependencies", default: .array([])),
        .optional("isStatic", default: .boolean(false))
    ],
    items: frameworkTemplateItems()
)

func frameworkTemplateItems() -> [Template.Item] {
    let name = "{{ name }}"
    let frameworkPath = paths.frameworkPath(name)
    
    var items: [Template.Item] = [
        // Framework sources
        .file(
            path: "\(frameworkPath)/Sources/\(name).swift",
            templatePath: "FrameworkSource.stencil"
        ),
        
        // Public headers/interface
        .file(
            path: "\(frameworkPath)/Sources/\(name)Interface.swift",
            templatePath: "FrameworkInterface.stencil"
        ),
        
        // Target definition
        .file(
            path: "\(paths.helpersPath)/Targets/Frameworks/\(name).swift",
            templatePath: "FrameworkTarget.stencil"
        )
    ]
    
    // Conditionally add resources
    items.append(contentsOf: [
        .directory(
            path: "\(frameworkPath)/Resources",
            sourcePath: .relativeToRoot("Templates/XCConfig")
        )
    ])
    
    // Conditionally add tests
    items.append(contentsOf: [
        .file(
            path: "\(frameworkPath)/Tests/\(name)Tests.swift",
            templatePath: "FrameworkTests.stencil"
        )
    ])
    
    return items
}