import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold framework --name MyFramework`
///
/// This will create a new framework target for code reuse.
///
/// To specify additional options:
/// `tuist scaffold framework --name MyFramework --platform ios --hasResources true`

let frameworkTemplate = Template(
    description: "Creates a new framework target for shared code",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("hasResources", default: .boolean(false)),
        .optional("hasTests", default: .boolean(true)),
        .optional("isStatic", default: .boolean(false))
    ],
    items: [
        .file(
            path: "Frameworks/{{ name }}/Sources/{{ name }}.swift",
            templatePath: "FrameworkSource.stencil"
        ),
        .file(
            path: "Frameworks/{{ name }}/Sources/{{ name }}Interface.swift",
            templatePath: "FrameworkInterface.stencil"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Frameworks/{{ name }}.swift",
            templatePath: "FrameworkTarget.stencil"
        ),
        .directory(
            path: "Frameworks/{{ name }}/Resources",
            sourcePath: .relativeToRoot("Templates/XCConfig")
        ),
        .file(
            path: "Frameworks/{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: "FrameworkTests.stencil"
        )
    ]
)

