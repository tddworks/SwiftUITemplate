import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold extension --name MyWidget --type widget`
///
/// This will create a new app extension target.
///
/// Available extension types:
/// - widget: Widget Extension
/// - notification: Notification Service Extension
/// - action: Action Extension
/// - share: Share Extension
/// - today: Today Extension
/// - intents: Intents Extension
/// - intentui: Intents UI Extension
/// - fileprovider: File Provider Extension
/// - fileproviderui: File Provider UI Extension

let config = TemplateConfiguration()
let paths = TemplatePaths.self

let extensionTemplate = Template(
    description: "Creates a new app extension target",
    attributes: [
        config.name,
        config.platform,
        config.author,
        config.company,
        config.year,
        config.date,
        .required("type"),
        .required("hostApp"),
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasUI", default: .boolean(true))
    ],
    items: extensionTemplateItems()
)

func extensionTemplateItems() -> [Template.Item] {
    let name = "{{ name }}"
    let extensionPath = paths.extensionPath(name)
    let type = "{{ type }}"
    
    var items: [Template.Item] = [
        // Extension sources based on type
        .file(
            path: "\(extensionPath)/Sources/\(name).swift",
            templatePath: "ExtensionSources/\(type.capitalized)Extension.stencil"
        ),
        
        // Info.plist for extension
        .file(
            path: "\(extensionPath)/Resources/Info.plist",
            templatePath: "ExtensionInfo.stencil"
        ),
        
        // Target definition
        .file(
            path: "\(paths.helpersPath)/Targets/Extensions/\(name).swift",
            templatePath: "ExtensionTarget.stencil"
        )
    ]
    
    // Add UI files if needed
    items.append(contentsOf: [
        .file(
            path: "\(extensionPath)/Sources/\(name)View.swift",
            templatePath: "ExtensionView.stencil"
        )
    ])
    
    // Add entitlements
    items.append(
        .file(
            path: "\(extensionPath)/Resources/\(name).entitlements",
            templatePath: "ExtensionEntitlements.stencil"
        )
    )
    
    return items
}