import Foundation
import ProjectDescription

/// # Usage
///
/// In root of an existing project, run:
/// `tuist scaffold addmodule --name UserProfile`
///
/// This will add a new module target to the existing project without overwriting project files.
///
/// Use this instead of `module` template when adding to existing projects.

let addModuleTemplate = Template(
    description: "Adds a new module target to an existing project",
    attributes: [
        .required("name"),
    ],
    items: [
        // Only module-specific files - no Project.swift conflicts
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Modules/{{ name }}.swift",
            templatePath: "ModuleTarget.stencil"
        ),
        .directory(path: "Modules/{{ name }}/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        .string(
            path: "Modules/{{ name }}/Sources/{{ name }}.swift",
            contents: "import Foundation\n\npublic struct {{ name }} {\n    public init() {}\n    \n    public func hello() -> String {\n        return \"Hello from {{ name }}!\"\n    }\n}"
        ),
        .string(
            path: "Modules/{{ name }}/TestsSources/{{ name }}Tests.swift", 
            contents: "import XCTest\n@testable import {{ name }}\n\nfinal class {{ name }}Tests: XCTestCase {\n    func testExample() throws {\n        let {{ name | lowercase }} = {{ name }}()\n        XCTAssertEqual({{ name | lowercase }}.hello(), \"Hello from {{ name }}!\")\n    }\n}"
        ),
        .string(path: "Modules/{{ name }}/TestResources/.gitkeep", contents: ""),
        .file(
            path: "auto-update-project.sh",
            templatePath: "auto-update-project.sh"
        ),
        .string(
            path: "SCAFFOLD_SUCCESS.md",
            contents: "# ✅ {{ name }} Module Scaffolded!\n\n## Automatic Project Update\n\nRun this command to automatically update Project.swift:\n\n```bash\nbash auto-update-project.sh\n```\n\nThen generate your project:\n\n```bash\ntuist generate\n```\n\n## What this does:\n- Dynamically scans all scaffolded targets (no hard-coding!)\n- Converts `ProjectTargets.allTargets()` to direct target listing\n- Automatically includes ALL frameworks, modules, extensions, and apps\n- Works for any project name and target names\n\n---\n*This file and script can be deleted after running the update.*"
        )
    ]
)