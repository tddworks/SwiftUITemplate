//
//  Module.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/25/25.
//

import ProjectDescription

let moduleName: Template.Attribute = .required("name")
let modulesPath  = "Modules"

let moduleTemplate = Template(
    description: "New Module Template",
    attributes: [
        moduleName,
    ],
    items: [
        .directory(path: "\(modulesPath)/\(moduleName)/Resources", sourcePath: .relativeToRoot("Templates/XCConfig")),
        .string(
            path: "\(modulesPath)/\(moduleName)/Sources/\(moduleName).swift",
            contents: "import Foundation"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/\(modulesPath)/\(moduleName).swift",
            templatePath: "target.stencil"
        ),
    ]
)
