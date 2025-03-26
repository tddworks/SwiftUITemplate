import Foundation
import ProjectDescription

/// # Usage
///
/// In root of the app, run:
/// `tuist scaffold app --name MyApp`
///
/// This will create a new Feature project named `MyProject` under `Modules/` for platforms `macOS` by default.
///
/// To specify a platform add the `--platforms` attribute as follows:
/// `tuist scaffold feature --name NewApp --platforms iOS`

let nameAttribute: Template.Attribute = .required("name")

let rootPath = "Apps"

let defaultAuthor: String = {
    let arguments = ["config", "user.name"]

    // shell will return output with trailing \n
    let output = executeCommand(command: "/usr/bin/git", args: arguments).trimmingCharacters(in: .whitespacesAndNewlines)

    // if no git repo, we just get the system's user name
    return output != "" ? output : NSUserName()
}()

let defaultYear: String = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: Date())
}()

let defaultDate: String = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: Date())
}()

let yearAttribute: Template.Attribute = .optional("year", default: .string(defaultYear))
let dateAttribute: Template.Attribute = .optional("date", default: .string(defaultDate))

let authorAttribute: Template.Attribute = .optional("author", default: .string(defaultAuthor))

let companyAttribute: Template.Attribute = .optional("company", default: .string(""))

let appTemplate = Template(
    description: "New App template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "ios"),
    ],
    items: [
        .file(
             path: "\(rootPath)/\(nameAttribute)/Sources/\(nameAttribute)App.swift",
             templatePath: "../Sources/App.stencil"
         ),
        .file(
             path: "\(rootPath)/\(nameAttribute)/Sources/ContentView.swift",
             templatePath: "../Sources/ContentView.stencil"
         ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Targets/Products/\(nameAttribute).swift",
            templatePath: "target.stencil"
        )
    ]
)

func executeCommand(command: String, args: [String]) -> String {
    let task = Process()
    task.launchPath = command
    task.arguments = args
    let pipe = Pipe()

    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: data, as: UTF8.self)
    return output
}
