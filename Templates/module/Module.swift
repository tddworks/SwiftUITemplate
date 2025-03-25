//
//  Module.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/25/25.
//

import ProjectDescription


let moduleTemplate = Template(
    description: "New Module Template",
    attributes: [
        nameAttribute,
    ],
    items: [
        .string(
            path: "Modules/\(nameAttribute)/Sources/\(nameAttribute).swift",
            contents: "import Foundation"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Modules/\(nameAttribute).swift",
            templatePath: "target.stencil"
        ),
    ]
)
