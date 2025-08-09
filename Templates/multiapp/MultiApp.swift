import Foundation
import ProjectDescription

/// # Usage
///
/// Add a new app to an existing workspace:
/// `tuist scaffold multiapp --name NewApp --workspace MyWorkspace`
///
/// This creates a new app project that integrates with an existing workspace.
/// The app can use shared frameworks and modules from the workspace.

let multiAppTemplate = Template(
    description: "Adds a new app target to an existing workspace",
    attributes: [
        .required("name"),
        .required("workspace"),
        .optional("bundleIdPrefix", default: "com.example"),
        .optional("version", default: "1.0.0"),
        .optional("hasTests", default: .boolean(true))
    ],
    items: [
        .string(path: "{{ name }}/Sources/.gitkeep", contents: ""),
        .string(path: "{{ name }}/Resources/.gitkeep", contents: ""),
        .string(path: "{{ name }}/Tests/.gitkeep", contents: ""),
        .file(
            path: "{{ name }}/Project.swift",
            templatePath: "AppProject.stencil"
        ),
        .file(
            path: "{{ name }}/Sources/{{ name }}App.swift",
            templatePath: "../Sources/App.stencil"
        ),
        .file(
            path: "{{ name }}/Sources/ContentView.swift",
            templatePath: "../Sources/ContentView.stencil"
        ),
        .string(path: "{{ name }}/Resources/.gitkeep", contents: ""),
        .file(
            path: "{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: "../Sources/Tests.stencil"
        )
    ]
)

