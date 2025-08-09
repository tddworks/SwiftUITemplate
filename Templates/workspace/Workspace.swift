import Foundation
import ProjectDescription

/// # Usage
///
/// Create a workspace with multiple app targets:
/// `tuist scaffold workspace --name MyWorkspace --apps "MainApp,CompanionApp,AdminApp"`
///
/// This creates a workspace containing multiple app projects that can share:
/// - Frameworks and modules
/// - Resources and assets
/// - Build settings and configurations
///
/// Options:
/// - Single project with multiple apps: `--structure single`
/// - Separate projects per app: `--structure multi` (default)

let workspaceTemplate = Template(
    description: "Creates a workspace supporting multiple app targets",
    attributes: [
        .required("name"),
        .required("apps"),
        .optional("bundleIdPrefix", default: "com.example"),
        .optional("structure", default: "multi"),
        .optional("version", default: "1.0.0")
    ],
    items: [
        .file(
            path: "{{ name }}.xcworkspace/contents.xcworkspacedata",
            templatePath: "WorkspaceContents.stencil"
        ),
        .directory(path: "Tuist", sourcePath: "../../ProjectDescriptionHelpers"),
        .file(path: "Tuist/Config.swift", templatePath: "WorkspaceConfig.stencil"),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/WorkspaceFactory.swift",
            templatePath: "WorkspaceFactory.stencil"
        ),
        .file(path: "Workspace.swift", templatePath: "WorkspaceDefinition.stencil"),
        .file(path: "Shared/Project.swift", templatePath: "SharedProject.stencil")
    ]
)

