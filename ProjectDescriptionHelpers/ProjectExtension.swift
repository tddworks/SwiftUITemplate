//
//  File.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/27/25.
//


import ProjectDescription

extension Project {
    
    public static func createApp(
        name: String,
        bundleId: String,
        destinations: Destinations,
        versionNumber: String,
        platform: Platform,
        organizationName: String,
        devTeam: String,
        packages: [Package],
        dependencies: [TargetDependency],
        additionalTargets: [Target],
        additionalFiles: [FileElement]
    ) -> Project {
        let appDependencies = dependencies + filterTestDependencies(from: additionalTargets)
        let targets = Target.createAppTargets(
            name: name,
            bundleId: bundleId,
            destinations: destinations,
            versionNumber: versionNumber,
            dependencies: appDependencies
        ) + additionalTargets
        
        let settings = createSettings(
            versionNumber: versionNumber,
            devTeam: devTeam
        )
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            additionalFiles: additionalFiles,
            resourceSynthesizers: .default
        )
    }
    
    private static func createSettings(
        versionNumber: String,
        devTeam: String
    ) -> Settings {
        let baseSettings = SettingsDictionary()
            .automaticCodeSigning(devTeam: devTeam)
            .marketingVersion(versionNumber)
            .currentProjectVersion("Auto generated")
        return Settings.settings(base: baseSettings, defaultSettings: .recommended)
    }
    
    private static func filterTestDependencies(from targets: [Target]) -> [TargetDependency] {
        return targets.compactMap {
            $0.name.hasSuffix("Tests") ? nil : TargetDependency.target(name: $0.name)
        }
    }
    
}
