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
