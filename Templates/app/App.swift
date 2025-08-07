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

let appTemplate = Template(
    description: "Creates a new iOS/macOS app target with SwiftUI support",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasTests", default: .boolean(true)),
        .optional("hasUITests", default: .boolean(false))
    ],
    items: [
        // Project structure (only created if not exists)
        .directory(path: "Tuist", sourcePath: "../../ProjectDescriptionHelpers"),
        .file(path: "./Project.swift", templatePath: "Project.stencil"),  
        .file(path: "./Package.swift", templatePath: "Package.stencil"),
        // App-specific files (always created)
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Products/{{ name }}.swift",
            templatePath: "Target.stencil"
        ),
        .file(
            path: "Products/{{ name }}/Sources/{{ name }}App.swift",
            templatePath: "../Sources/App.stencil"
        ),
        .file(
            path: "Products/{{ name }}/Sources/ContentView.swift",
            templatePath: "../Sources/ContentView.stencil"
        ),
        .directory(path: "Products/{{ name }}/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        .file(
            path: "Products/{{ name }}/Resources/InfoPlist.strings",
            templatePath: "InfoPlist.stencil"
        ),
        .file(
            path: "Products/{{ name }}/TestsSources/{{ name }}Tests.swift",
            templatePath: "../Sources/Tests.stencil"
        ),
        .string(path: "Products/{{ name }}/Resources/.gitkeep", contents: ""),
        .string(path: "Products/{{ name }}/TestResources/.gitkeep", contents: ""),
        .file(
            path: "regenerate-project.sh",
            templatePath: .relativeToRoot("Templates/shared/regenerate-project.sh")
        ),
        .string(
            path: "README.md",
            contents: "# {{ name }}\n\n## 🔄 Automatic Project Updates\n\nAfter scaffolding new targets (modules, frameworks, extensions, or apps), run:\n\n```bash\nbash regenerate-project.sh\ntuist generate\n```\n\nThis will automatically update Project.swift to include all scaffolded targets.\n\n## Adding Components\n\n```bash\n# Add a module\ntuist scaffold addmodule --name UserProfile\n\n# Add a framework\ntuist scaffold addframework --name Core\n\n# Add an extension\ntuist scaffold addextension --name MyWidget --type widget --host-app {{ name }}\n\n# Add another app\ntuist scaffold addapp --name CompanionApp --platform macos\n\n# After adding any components, regenerate:\nbash regenerate-project.sh\ntuist generate\n```"
        )
    ]
)

