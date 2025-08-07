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
    
    public enum Frameworks {
        // Helper method to get base path for a framework
        static func baseFrameworkPath(frameworkName: String) -> String {
            return "Frameworks/\(frameworkName)"
        }
        
        /// Returns the source file pattern for the given framework.
        public static func sources(frameworkName: String) -> SourceFileGlob {
            return "\(baseFrameworkPath(frameworkName: frameworkName))/Sources/**"
        }

        /// Returns the resource file pattern for the given framework.
        public static func resources(frameworkName: String) -> ResourceFileElement {
            return "\(baseFrameworkPath(frameworkName: frameworkName))/Resources/**"
        }
        
        /// Returns the test source file pattern for the given framework.
        public static func tests(frameworkName: String) -> SourceFileGlob {
            return "\(baseFrameworkPath(frameworkName: frameworkName))/Tests/**"
        }
        
        /// Returns the test resource file pattern for the given framework.
        public static func testResources(frameworkName: String) -> ResourceFileElement {
            return "\(baseFrameworkPath(frameworkName: frameworkName))/TestResources/**"
        }
    }
    
    public enum Extensions {
        // Helper method to get base path for an extension
        static func baseExtensionPath(extensionName: String) -> String {
            return "Extensions/\(extensionName)"
        }
        
        /// Returns the source file pattern for the given extension.
        public static func sources(extensionName: String) -> SourceFileGlob {
            return "\(baseExtensionPath(extensionName: extensionName))/Sources/**"
        }

        /// Returns the resource file pattern for the given extension.
        public static func resources(extensionName: String) -> ResourceFileElement {
            return "\(baseExtensionPath(extensionName: extensionName))/Resources/**"
        }
        
        /// Returns the entitlements path for the given extension.
        public static func entitlements(extensionName: String) -> Entitlements {
            return .file(path: "\(baseExtensionPath(extensionName: extensionName))/Resources/\(extensionName).entitlements")
        }
    }

    public enum Apps {
        // Helper method to get base path for an app
        static func baseAppPath(appName: String) -> String {
            return "Products/\(appName)"
        }
        
        public static func appSourcesPath(appName: String) -> String {
            return "\(baseAppPath(appName: appName))/Sources"
        }
        
        public static func appResourcesPath(appName: String) -> String {
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

