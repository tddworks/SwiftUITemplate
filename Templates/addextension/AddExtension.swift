import Foundation
import ProjectDescription

/// # Usage
///
/// In root of an existing project, run:
/// `tuist scaffold addextension --name MyWidget --type widget --hostApp MyApp`
///
/// This will add a new extension target to the existing project without overwriting project files.
///
/// Use this instead of `extension` template when adding to existing projects.
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

let addExtensionTemplate = Template(
    description: "Adds a new extension target to an existing project",
    attributes: [
        .required("name"),
        .required("type"),
        .required("hostApp"),
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasUI", default: .boolean(true))
    ],
    items: [
        // Only extension-specific files - no Project.swift conflicts
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Extensions/{{ name }}.swift",
            templatePath: "ExtensionTarget.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Sources/{{ name }}.swift",
            templatePath: "../extension/ExtensionSources/WidgetExtension.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Resources/Info.plist",
            templatePath: "../extension/ExtensionInfo.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Sources/{{ name }}View.swift",
            templatePath: "../extension/ExtensionView.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Resources/{{ name }}.entitlements",
            templatePath: "../extension/ExtensionEntitlements.stencil"
        )
    ]
)