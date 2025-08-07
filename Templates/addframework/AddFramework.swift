import Foundation
import ProjectDescription

/// # Usage
///
/// In root of an existing project, run:
/// `tuist scaffold addframework --name NetworkLayer --hasResources false --isStatic false`
///
/// This will add a new framework target to the existing project without overwriting project files.
///
/// Use this instead of `framework` template when adding to existing projects.

let addFrameworkTemplate = Template(
    description: "Adds a new framework target to an existing project",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("hasResources", default: .boolean(false)),
        .optional("hasTests", default: .boolean(true)),
        .optional("isStatic", default: .boolean(false))
    ],
    items: [
        // Only framework-specific files - no Project.swift conflicts
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Frameworks/{{ name }}.swift",
            templatePath: "FrameworkTarget.stencil"
        ),
        .file(
            path: "Frameworks/{{ name }}/Sources/{{ name }}.swift",
            templatePath: "../framework/FrameworkSource.stencil"
        ),
        .file(
            path: "Frameworks/{{ name }}/Sources/{{ name }}Interface.swift",
            templatePath: "../framework/FrameworkInterface.stencil"
        ),
        .directory(
            path: "Frameworks/{{ name }}/Resources",
            sourcePath: .relativeToRoot("Templates/XCConfig")
        ),
        .file(
            path: "Frameworks/{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: "../framework/FrameworkTests.stencil"
        ),
        .file(
            path: "regenerate-project.sh",
            templatePath: .relativeToRoot("Templates/shared/regenerate-project.sh")
        ),
        .string(
            path: "SCAFFOLD_SUCCESS.md",
            contents: "# ✅ {{ name }} Framework Scaffolded!\n\n## Automatic Project.swift Update\n\nRun this command to automatically regenerate Project.swift:\n\n```bash\nbash regenerate-project.sh\n```\n\nThen generate your project:\n\n```bash\ntuist generate\n```\n\n## What this does:\n- 🔍 Scans all target files dynamically (no hard-coding!)\n- 🔄 Regenerates Project.swift with direct target listing\n- 📦 Includes ALL frameworks, modules, extensions, and apps automatically\n- 🌟 Eliminates ProjectTargets.swift entirely\n- ✨ Works for any project name and target names\n\n---\n*This script can be deleted after running the update.*"
        )
    ]
)