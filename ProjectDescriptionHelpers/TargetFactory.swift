import ProjectDescription
//  TargetFactory.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//


// MARK: - Target Factory

public enum TargetFactory {
    public static func createFramework(
        name: String,
        baseBundleID: String,
        destinations: Destinations = [.iPhone],
        hasResources: Bool = false,
        usesMaxSwiftVersion: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: BundleID.module(name, base: baseBundleID),
            sources: [SourcePaths.Modules.sources(moduleName: name)],
            resources: hasResources ? [SourcePaths.Modules.resources(moduleName: name)] : nil,
            dependencies: dependencies,
            settings: SettingsFactory.frameworkSettings(usesMaxSwiftVersion: usesMaxSwiftVersion)
        )
    }
    
    public static func createFrameworkTests(
        name: String,
        baseBundleID: String,
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: "\(name)Tests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: BundleID.moduleTests(name, base: baseBundleID),
            sources: [SourcePaths.Modules.tests(moduleName: name)],
            resources: hasResources ? [SourcePaths.Modules.testResources(moduleName: name)] : nil,
            dependencies: [.target(name: name)] + dependencies,
            settings: SettingsFactory.testSettings()
        )
    }
}
