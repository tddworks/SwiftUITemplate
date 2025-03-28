//
//  Module.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/25/25.
//

import ProjectDescription

let moduleName: Template.Attribute = .required("name")

let moduleTemplate = Template(
    description: "New Module Template",
    attributes: [
        moduleName,
    ],
    items: [
        .string(
            path: "Modules/\(moduleName)/Sources/\(moduleName).swift",
            contents: "import Foundation"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Modules/\(moduleName).swift",
            templatePath: "target.stencil"
        ),
    ]
)
