//
//  TargetExtensions.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

import ProjectDescription

extension Target {

    public static func createAppTargets(
        name: String,
        bundleId: String,
        destinations: Destinations = .iOS,
        versionNumber: String = "1.0.0",
        hasResources: Bool = true,
        dependencies: [TargetDependency] = [],
        additionalInfoPlist: [String : ProjectDescription.Plist.Value] = [:]
    ) -> [Target] {
        let appTarget = createAppTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations,
            versionNumber: versionNumber,
            hasResources: hasResources,
            dependencies: dependencies,
            additionalInfoPlist: additionalInfoPlist
        )
        
        let testTarget = createAppTestTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations
        )
        
        return [appTarget, testTarget]
    }
    
    public static func createAppTarget(
        name: String,
        bundleId: String,
        destinations: Destinations = .iOS,
        versionNumber: String = "1.0.0",
        hasResources: Bool = true,
        dependencies: [TargetDependency] = [],
        additionalInfoPlist: [String : ProjectDescription.Plist.Value] = [:]
    ) -> Target {
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(bundleId).\(name)",
            infoPlist: .extendingDefault(
                with: baseInfoPlist(version: versionNumber).merging(additionalInfoPlist) { $1 }
            ),
            sources: [SourcePaths.Apps.sources(appName: name)],
            resources: hasResources ? [SourcePaths.Apps.resources(appName: name)] : nil,
            dependencies: dependencies,
            settings: createSettings()
        )
    }
    
    public static func createAppTestTarget(
        name: String,
        bundleId: String,
        destinations: Destinations,
        hasResources: Bool = false
    ) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            infoPlist: .default,
            sources: [SourcePaths.Apps.tests(appName: name)],
            resources: hasResources ? [SourcePaths.Apps.testResources(appName: name)] : nil,
            dependencies: [.target(name: name)]
        )
    }
    
    public static func moduleTarget(
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

    public static func moduleTestTarget(
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
    
    private static func baseInfoPlist(version: String) -> [String: ProjectDescription.Plist.Value] {
        return [
            "UILaunchScreen": ["UIColorName": "AccentColor"],
            "CFBundleShortVersionString": .string(version),
            "CFBundleVersion": "1",
            "LSApplicationCategoryType": "public.app-category.utilities",
            "ITSAppUsesNonExemptEncryption": false
        ]
    }

    private static func createSettings() -> Settings {
        return .settings(
            base: [
                "CODE_SIGN_IDENTITY": "$(codeSignIdentity)",
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "$(developmentTeam)",
                "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": "NO",
                "TARGETED_DEVICE_FAMILY": "1",
            ],
            debug: [
                "ENABLE_DEBUG_DYLIB": true,
            ],
            release: [:],
            defaultSettings: .recommended(excluding: [
                "CODE_SIGN_IDENTITY",
            ])
        )
    }
}
