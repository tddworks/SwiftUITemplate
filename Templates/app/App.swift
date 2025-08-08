import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold app --name MyApp --platform ios --bundle-id com.mycompany --team-id ABC123`
///
/// This will create a new app target with SwiftUI support.
///
/// Available options:
/// - `--platform`: ios, macos, watchos, tvos (default: ios)  
/// - `--bundle-id`: Base bundle identifier (default: com.example)
/// - `--team-id`: Development team ID for code signing
/// - `--version`: App version (default: 1.0.0)

let appTemplate = Template(
    description: "Creates a new iOS/macOS app target with SwiftUI support",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("bundleId", default: "com.example"),
        .optional("teamId", default: ""),
        .optional("team-id", default: ""),
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
        // Generate shared configuration at project root for centralized access
        .file(path: "shared.xcconfig", templatePath: "shared.xcconfig.stencil"),
        // Generate app entitlements with sandbox support
        .file(path: "Products/{{ name }}/Resources/{{ name }}.entitlements", templatePath: "AppEntitlements.stencil"),
        // Copy required XCConfig files 
        .file(path: "Products/{{ name }}/Resources/XCConfig/debug.xcconfig", templatePath: .relativeToRoot("Templates/XCConfig/debug.xcconfig")),
        .file(path: "Products/{{ name }}/Resources/XCConfig/release.xcconfig", templatePath: .relativeToRoot("Templates/XCConfig/release.xcconfig")),
        .file(path: "Products/{{ name }}/Resources/XCConfig/XCConfig.swift", templatePath: .relativeToRoot("Templates/XCConfig/XCConfig.swift")),
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
            path: "PROJECT_GUIDE.md",
            contents: "# {{ name }} - Project Guide\n\n## 🔄 Automatic Project Updates\n\nAfter scaffolding new targets (modules, frameworks, extensions, or apps), run:\n\n```bash\nbash regenerate-project.sh\ntuist generate\n```\n\nThis will automatically update Project.swift to include all scaffolded targets.\n\n## Adding Components\n\n```bash\n# Add a module\ntuist scaffold addmodule --name UserProfile\n\n# Add a framework\ntuist scaffold addframework --name Core\n\n# Add an extension\ntuist scaffold addextension --name MyWidget --type widget --host-app {{ name }}\n\n# Add another app\ntuist scaffold addapp --name CompanionApp --platform macos\n\n# After adding any components, regenerate:\nbash regenerate-project.sh\ntuist generate\n```\n\n## Project Structure\n\n```\n{{ name }}/\n├── Products/          # App targets\n├── Modules/           # Feature modules\n├── Frameworks/        # Shared frameworks\n├── Extensions/        # App extensions\n├── Tuist/            # Tuist configuration\n├── Project.swift     # Project definition (auto-generated)\n└── regenerate-project.sh  # Script to update Project.swift\n```"
        )
    ]
)

