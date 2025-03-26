import ProjectDescription
//  SourcePaths.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

// MARK: - Paths

public enum SourcePaths {
    public enum Modules {
        public static func sources(moduleName: String) ->  SourceFileGlob { "Modules/\(moduleName)/Sources/**" }
        public static func resources(moduleName: String) ->  ResourceFileElement { "Modules/\(moduleName)/Resources/**" }
        public static func tests(moduleName: String) ->  SourceFileGlob { "Modules/\(moduleName)/Tests/**" }
        public static func testResources(moduleName: String) ->  ResourceFileElement { "Modules/\(moduleName)/TestResources/**" }
    }
    
    public enum Apps {
        public static func sources(appName: String) ->  SourceFileGlob { "Products/\(appName)/Sources/**" }
        public static func resources(appName: String) ->  ResourceFileElement { "Products/\(appName)/Resources/**" }
        public static func tests(appName: String) ->  SourceFileGlob { "Products/\(appName)/Tests/**" }
    }
}
