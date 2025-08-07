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
        ),
        .file(
            path: "regenerate-project.sh",
            templatePath: .relativeToRoot("Templates/shared/regenerate-project.sh")
        ),
        .string(
            path: "SCAFFOLD_SUCCESS.md",
            contents: "# ✅ {{ name }} Extension Scaffolded!\n\n## Automatic Project.swift Update\n\nRun this command to automatically regenerate Project.swift:\n\n```bash\nbash regenerate-project.sh\n```\n\nThen generate your project:\n\n```bash\ntuist generate\n```\n\n## What this does:\n- 🔍 Scans all target files dynamically (no hard-coding!)\n- 🔄 Regenerates Project.swift with direct target listing\n- 📦 Includes ALL frameworks, modules, extensions, and apps automatically\n- 🌟 Eliminates ProjectTargets.swift entirely\n- ✨ Works for any project name and target names\n\n---\n*This script can be deleted after running the update.*"
        )
    ]
)