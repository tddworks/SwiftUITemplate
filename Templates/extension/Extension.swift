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

let extensionTemplate = Template(
    description: "Creates a new app extension target",
    attributes: [
        .required("name"),
        .required("type"),
        .required("hostApp"),
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasUI", default: .boolean(true))
    ],
    items: [
        .file(
            path: "Extensions/{{ name }}/Sources/{{ name }}.swift",
            templatePath: "ExtensionSources/WidgetExtension.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Resources/Info.plist",
            templatePath: "ExtensionInfo.stencil"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Extensions/{{ name }}.swift",
            templatePath: "ExtensionTarget.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Sources/{{ name }}View.swift",
            templatePath: "ExtensionView.stencil"
        ),
        .file(
            path: "Extensions/{{ name }}/Resources/{{ name }}.entitlements",
            templatePath: "ExtensionEntitlements.stencil"
        )
    ]
)

