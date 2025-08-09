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
        )
    ]
)