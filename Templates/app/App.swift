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
        .directory(path: "Tuist", sourcePath: "../../ProjectDescriptionHelpers"),
        .directory(path: "Products/{{ name }}/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        .file(path: "./Project.swift", templatePath: "Project.stencil"),
        .file(path: "./Package.swift", templatePath: "Package.stencil"),
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
        .file(
            path: "Products/{{ name }}/Resources/InfoPlist.strings",
            templatePath: "InfoPlist.stencil"
        ),
        .file(
            path: "Products/{{ name }}/TestsSources/{{ name }}Tests.swift",
            templatePath: "../Sources/Tests.stencil"
        ),
        .string(path: "Products/{{ name }}/Resources/.gitkeep", contents: "")
    ]
)

