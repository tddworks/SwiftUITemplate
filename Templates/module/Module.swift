//
//  Module.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/25/25.
//

import ProjectDescription

let moduleTemplate = Template(
    description: "Creates a new feature module",
    attributes: [
        .required("name"),
        .optional("platform", default: "ios"),
        .optional("hasTests", default: .boolean(true)),
        .optional("hasResources", default: .boolean(false))
    ],
    items: [
        .directory(path: "Modules/{{ name }}/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        .string(
            path: "Modules/{{ name }}/Sources/{{ name }}.swift",
            contents: "import Foundation"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Modules/{{ name }}.swift",
            templatePath: "Target.stencil"
        ),
    ]
)
