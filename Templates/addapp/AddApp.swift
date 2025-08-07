import Foundation
import ProjectDescription

/// # Usage
///
/// In root of an existing project (after running `tuist scaffold app` to create initial project), run:
/// `tuist scaffold addapp --name DemoApp --platform ios --bundle-id com.mycompany.demo`
///
/// This will add a new app target to the existing project without overwriting project files.
///
/// Available platforms: ios, macos, watchos, tvos

let addAppTemplate = Template(
    description: "Adds a new app target to an existing project",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("bundleId", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasTests", default: .boolean(true)),
        .optional("hasUITests", default: .boolean(false))
    ],
    items: [
        // Only app-specific files - no Project.swift or Tuist/ directory conflicts
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
        .string(path: "Products/{{ name }}/TestResources/.gitkeep", contents: "")
    ]
)