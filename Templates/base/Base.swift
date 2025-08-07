import Foundation
import ProjectDescription

public struct TemplateConfiguration {
    public let name: Template.Attribute
    public let platform: Template.Attribute
    public let author: Template.Attribute
    public let company: Template.Attribute
    public let year: Template.Attribute
    public let date: Template.Attribute
    
    public init() {
        self.name = .required("name")
        self.platform = .optional("platform", default: "ios")
        self.author = .optional("author", default: .string(TemplateConfiguration.defaultAuthor))
        self.company = .optional("company", default: .string(""))
        self.year = .optional("year", default: .string(TemplateConfiguration.defaultYear))
        self.date = .optional("date", default: .string(TemplateConfiguration.defaultDate))
    }
    
    public static let defaultAuthor: String = {
        let arguments = ["config", "user.name"]
        let output = executeCommand(command: "/usr/bin/git", args: arguments).trimmingCharacters(in: .whitespacesAndNewlines)
        return output != "" ? output : NSUserName()
    }()
    
    public static let defaultYear: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: Date())
    }()
    
    public static let defaultDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }()
}

public struct TemplatePaths {
    public static let productsPath = "Products"
    public static let modulesPath = "Modules"
    public static let extensionsPath = "Extensions"
    public static let frameworksPath = "Frameworks"
    public static let tuistPath = "Tuist"
    public static let helpersPath = "\(tuistPath)/ProjectDescriptionHelpers"
    
    public static func productPath(_ name: String) -> String {
        "\(productsPath)/\(name)"
    }
    
    public static func modulePath(_ name: String) -> String {
        "\(modulesPath)/\(name)"
    }
    
    public static func extensionPath(_ name: String) -> String {
        "\(extensionsPath)/\(name)"
    }
    
    public static func frameworkPath(_ name: String) -> String {
        "\(frameworksPath)/\(name)"
    }
}

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