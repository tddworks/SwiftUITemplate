//
//  TargetExtensions.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

import ProjectDescription
// https://www.adamtecle.com/blog/tuist-xcconfigs
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
                with: baseInfoPlist(versionNumber: versionNumber).merging(additionalInfoPlist) { $1 }
            ),
            sources: [SourcePaths.Apps.sources(appName: name)],
            resources: hasResources ? [SourcePaths.Apps.resources(appName: name)] : nil,
            dependencies: dependencies,
            settings: createSettings(name: name, versionNumber: versionNumber, devTeam: "${DEVELOPMENT_TEAM}")
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
        destinations: Destinations = .iOS,
        hasResources: Bool = false,
        usesMaxSwiftVersion: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: "\(name)",
            destinations: destinations,
            product: .framework,
            bundleId: "\(bundleId).\(name)",
            sources: [SourcePaths.Modules.sources(moduleName: name)],
            resources: hasResources ? [SourcePaths.Modules.resources(moduleName: name)] : nil,
            dependencies: dependencies,
            settings: .settings(
                base: [
                    "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": false,
                    "ENABLE_MODULE_VERIFIER": true,
                    "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": ["gnu11", "gnu++14"]
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
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            sources: [SourcePaths.Modules.tests(moduleName: name)],
            resources: hasResources ? [SourcePaths.Modules.testResources(moduleName: name)] : nil,
            dependencies: [
                .target(name: "\(name)"),
            ] + dependencies,
            settings: .settings(
                base: [:]
            )
        )
    }
    
    // https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleversion
    // The tl;dr is that CFBudnleShortVersion is your app version, as we understand it, and CFBundleVersion is a build number for the system to differentiate builds of the same version
    private static func baseInfoPlist(versionNumber: String) -> [String: ProjectDescription.Plist.Value] {
        return [
            "UILaunchScreen": ["UIColorName": "AccentColor"],
            "LSApplicationCategoryType": "public.app-category.utilities",
            "ITSAppUsesNonExemptEncryption": false,
            // The release or version number of the bundle.
            "CFBundleShortVersionString": Plist.Value(stringLiteral: versionNumber),
            // The version of the build that identifies an iteration of the bundle.
            "CFBundleVersion": "1",
        ]
    }
    
    // https://developer.apple.com/documentation/xcode/build-settings-reference#Marketing-Version
    private static func createSettings(
        name: String,
        versionNumber: String,
        devTeam: String
    ) -> Settings {
        let configurations: [Configuration] =  [
            .debug(name: .debug,
                    settings: ["OTHER_SWIFT_FLAGS": "-DDEBUG"],
                    xcconfig: "\(SourcePaths.Apps.appResourcesPath(appName: name))/XCConfig/debug.xcconfig"),
            .release(name: .release, xcconfig: "\(SourcePaths.Apps.appResourcesPath(appName: name))/XCConfig/release.xcconfig"),
        ]
        
        let baseSettings = SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
            .automaticCodeSigning(devTeam: devTeam)
            //CURRENT_PROJECT_VERSION (CFBundleVersion in Info.plist):
            .currentProjectVersion("1")
            //MARKETING_VERSION (CFBundleShortVersionString in Info.plist)
            .marketingVersion(versionNumber)
        return .settings(base: baseSettings.merging(["OTHER_LDFLAGS": "$(inherited) -ObjC"]), configurations: configurations, defaultSettings: .recommended)
    }
    
}
