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

let config = TemplateConfiguration()
let paths = TemplatePaths.self

let workspaceTemplate = Template(
    description: "Creates a workspace supporting multiple app targets",
    attributes: [
        config.name,
        config.platform,
        config.author,
        config.company,
        config.year,
        config.date,
        .required("apps"),
        .optional("bundleIdPrefix", default: "com.example"),
        .optional("structure", default: "multi"), // "single" or "multi"
        .optional("sharedFrameworks", default: .array(["Core", "Shared"])),
        .optional("version", default: "1.0.0")
    ],
    items: workspaceTemplateItems()
)

func workspaceTemplateItems() -> [Template.Item] {
    let workspaceName = "{{ name }}"
    let structure = "{{ structure }}"
    let apps = "{{ apps }}"
    
    var items: [Template.Item] = [
        // Workspace file
        .file(
            path: "\(workspaceName).xcworkspace/contents.xcworkspacedata",
            templatePath: "WorkspaceContents.stencil"
        ),
        
        // Tuist configuration
        .directory(path: "Tuist", sourcePath: "../../ProjectDescriptionHelpers"),
        .file(path: "Tuist/Config.swift", templatePath: "WorkspaceConfig.stencil"),
        
        // Shared workspace helpers
        .file(
            path: "Tuist/ProjectDescriptionHelpers/WorkspaceFactory.swift",
            templatePath: "WorkspaceFactory.stencil"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/MultiAppTargets.swift", 
            templatePath: "MultiAppTargets.stencil"
        )
    ]
    
    // Structure-specific files
    if structure == "single" {
        // Single project with multiple apps
        items.append(contentsOf: [
            .file(path: "Project.swift", templatePath: "MultiAppProject.stencil"),
            .file(
                path: "Tuist/ProjectDescriptionHelpers/Targets/Apps/AllApps.swift",
                templatePath: "AllAppsTarget.stencil"
            )
        ])
    } else {
        // Multiple projects in workspace
        items.append(contentsOf: [
            .file(path: "Workspace.swift", templatePath: "WorkspaceDefinition.stencil"),
            .file(path: "Shared/Project.swift", templatePath: "SharedProject.stencil")
        ])
    }
    
    return items
}