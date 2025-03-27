import ProjectDescription
//  SourcePaths.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

// MARK: - Paths

public enum SourcePaths {
    
    public enum Modules {
        // Helper method to get base path for a module
        static func baseModulePath(moduleName: String) -> String {
            return "Modules/\(moduleName)"
        }
        
        /// Returns the source file pattern for the given module.
        public static func sources(moduleName: String) -> SourceFileGlob {
            return "\(baseModulePath(moduleName: moduleName))/Sources/**"
        }

        /// Returns the resource file pattern for the given module.
        public static func resources(moduleName: String) -> ResourceFileElement {
            return "\(baseModulePath(moduleName: moduleName))/Resources/**"
        }
        
        /// Returns the test source file pattern for the given module.
        public static func tests(moduleName: String) -> SourceFileGlob {
            return "\(baseModulePath(moduleName: moduleName))/TestsSources/**"
        }
        
        /// Returns the test resource file pattern for the given module.
        public static func testResources(moduleName: String) -> ResourceFileElement {
            return "\(baseModulePath(moduleName: moduleName))/TestResources/**"
        }
    }

    public enum Apps {
        // Helper method to get base path for an app
        static func baseAppPath(appName: String) -> String {
            return "Products/\(appName)"
        }
        
        static func appSourcesPath(appName: String) -> String {
            return "\(baseAppPath(appName: appName))/Sources"
        }
        
        static func appResourcesPath(appName: String) -> String {
            return "\(baseAppPath(appName: appName))/Resources"
        }
        
        /// Returns the source file pattern for the given app.
        public static func sources(appName: String) -> SourceFileGlob {
            return "\(appSourcesPath(appName: appName))/**"
        }
        
        /// Returns the resource file pattern for the given app.
        public static func resources(appName: String) -> ResourceFileElement {
            return "\(appResourcesPath(appName: appName))/**"
        }
        
        /// Returns the test source file pattern for the given app.
        public static func tests(appName: String) -> SourceFileGlob {
            return "\(baseAppPath(appName: appName))/TestsSources/**"
        }
        
        /// Returns the test resource file pattern for the given app.
        public static func testResources(appName: String) -> ResourceFileElement {
            return "\(baseAppPath(appName: appName))/TestResources/**"
        }
    }
}

