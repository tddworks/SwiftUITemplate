//
//  TargetExtensions.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

import ProjectDescription

extension Target {
    
    public static func appTarget(
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
        let targets = createAppTargets(
            name: name,
            bundleId: bundleId,
            destinations: destinations,
            versionNumber: versionNumber,
            platform: platform,
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
    
    
    static func moduleTarget(
        name: String,
        bundleId: String,
        destinations: Destinations = [.iPhone],
        hasResources: Bool = false,
        usesMaxSwiftVersion: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: "\(name)",
            destinations: destinations,
            product: .framework,
            bundleId: "\(bundleId).\(name)",
            sources: ["Modules/\(name)/Sources/**"],
            resources: hasResources ? ["Modules/\(name)/Resources/**"] : nil,
            dependencies: dependencies,
            settings: .settings(
                base: [
                    "CODE_SIGN_IDENTITY": "",
                    "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": false,
                    "ENABLE_MODULE_VERIFIER": true,
                    "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": ["gnu11", "gnu++14"],
                    "SWIFT_VERSION": (usesMaxSwiftVersion ? "$(SWIFT_MAX_VERSION)" : "$(inherited)"),
                ]
            )
        )
    }

    static func moduleTestTarget(
        name: String,
        bundleId: String,
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            sources: ["Modules/\(name)/Tests/**"],
            resources: hasResources ? ["Modules/\(name)/TestResources/**"] : nil,
            dependencies: [
                .target(name: "\(name)"),
            ] + dependencies,
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "$(SWIFT_MAX_VERSION)",
                ]
            )
        )
    }
    
    // MARK: - Private Helpers
    
    private static func createAppTargets(
        name: String,
        bundleId: String,
        destinations: Destinations,
        versionNumber: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let appTarget = generateAppTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations,
            versionNumber: versionNumber,
            dependencies: dependencies
        )
        
        let testTarget = generateAppTestTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations
        )
        
        return [appTarget, testTarget]
    }
    
    private static func generateAppTarget(
        name: String,
        bundleId: String,
        destinations: Destinations,
        versionNumber: String,
        dependencies: [TargetDependency]
    ) -> Target {
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": Plist.Value(stringLiteral: versionNumber),
            "CFBundleVersion": "1",
            "UILaunchScreen": [
                "UIColorName": "AccentColor"
            ],
            "ITSAppUsesNonExemptEncryption": false
        ]
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(bundleId).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
    }
    
    private static func generateAppTestTarget(
        name: String,
        bundleId: String,
        destinations: Destinations
    ) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [.target(name: name)]
        )
    }
    
    private static func filterTestDependencies(from targets: [Target]) -> [TargetDependency] {
        return targets.compactMap {
            $0.name.hasSuffix("Tests") ? nil : TargetDependency.target(name: $0.name)
        }
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
    
}
