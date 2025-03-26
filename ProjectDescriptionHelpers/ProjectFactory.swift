import ProjectDescription

//  ProjectFactory.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//


// MARK: - Project Factory
public enum ProjectFactory {
    
    public static func createAppProject(
        config: AppProjectConfig,
        packages: [Package] = [],
        dependencies: [TargetDependency] = [],
        additionalTargets: [Target] = [],
        additionalFiles: [FileElement] = []
    ) -> Project {
        let appDependencies = dependencies + nonTestDependencies(from: additionalTargets)
        let targets = [createAppTarget(config: config, dependencies: dependencies)] + additionalTargets
        
        return Project(
            name: config.name,
            organizationName: config.organizationName,
            packages: packages,
            settings: SettingsFactory.appSettings(config: config),
            targets: targets,
            additionalFiles: additionalFiles,
            resourceSynthesizers: .default
        )
    }
    
    static func createAppTestTarget(config: AppProjectConfig) -> Target {
        Target.target(
            name: "\(config.name)Tests",
            destinations: config.destinations,
            product: .unitTests,
            bundleId: BundleID.appTests(config.name, base: config.baseBundleID),
            infoPlist: .default,
            sources: [SourcePaths.Apps.tests(appName: config.name)],
            dependencies: [.target(name: config.name)]
        )
    }
    
    public static func createAppProjectWithTest(
        config: AppProjectConfig,
        packages: [Package] = [],
        dependencies: [TargetDependency] = [],
        additionalTargets: [Target] = [],
        additionalFiles: [FileElement] = []
    ) -> Project {
        let appDependencies = dependencies + nonTestDependencies(from: additionalTargets)
        let targets = createAppTargets(config: config, dependencies: appDependencies) + additionalTargets
        
        return Project(
            name: config.name,
            organizationName: config.organizationName,
            packages: packages,
            settings: SettingsFactory.appSettings(config: config),
            targets: targets,
            additionalFiles: additionalFiles,
            resourceSynthesizers: .default
        )
    }
    
    private static func createAppTargets(
        config: AppProjectConfig,
        dependencies: [TargetDependency]
    ) -> [Target] {
        [
            createAppTarget(config: config, dependencies: dependencies),
            createAppTestTarget(config: config)
        ]
    }
    
    private static func createAppTarget(
        config: AppProjectConfig,
        dependencies: [TargetDependency]
    ) -> Target {
        
        Target.target(
            name: config.name,
            destinations: config.destinations,
            product: .app,
            bundleId: BundleID.app(config.name, base: config.baseBundleID),
            infoPlist: .extendingDefault(with: config.infoPlist),
            sources: [SourcePaths.Apps.sources(appName: config.name)],
            resources: [SourcePaths.Apps.resources(appName: config.name)],
            dependencies: dependencies
        )
    }

    private static func nonTestDependencies(from targets: [Target]) -> [TargetDependency] {
        targets.compactMap {
            $0.name.hasSuffix("Tests") ? nil : .target(name: $0.name)
        }
    }
}

