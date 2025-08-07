//
//  TargetExtensions.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

import ProjectDescription

// MARK: - Extension Types

public enum ExtensionType: String {
    case widget = "widget"
    case notification = "notification-service"
    case action = "action"
    case share = "share"
    case today = "today"
    case intents = "intents"
    case intentsUI = "intents-ui"
    case fileProvider = "file-provider"
    case fileProviderUI = "file-provider-ui"
    
    var product: Product {
        switch self {
        case .widget:
            return .appExtension
        case .notification:
            return .appExtension
        case .action:
            return .appExtension
        case .share:
            return .appExtension
        case .today:
            return .appExtension
        case .intents:
            return .appExtension
        case .intentsUI:
            return .appExtension
        case .fileProvider:
            return .appExtension
        case .fileProviderUI:
            return .appExtension
        }
    }
}

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
            bundleId: "\(bundleId).\(name.lowercased())",
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
            bundleId: "\(bundleId).\(name.lowercased())Tests",
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
            bundleId: "\(bundleId).\(name.lowercased())",
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

    public static func frameworkTarget(
        name: String,
        bundleId: String,
        destinations: Destinations = .iOS,
        hasResources: Bool = false,
        isStatic: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: isStatic ? .staticFramework : .framework,
            bundleId: "\(bundleId).\(name.lowercased())",
            sources: [SourcePaths.Frameworks.sources(frameworkName: name)],
            resources: hasResources ? [SourcePaths.Frameworks.resources(frameworkName: name)] : nil,
            dependencies: dependencies,
            settings: SettingsFactory.frameworkSettings(usesMaxSwiftVersion: true)
        )
    }
    
    public static func frameworkTestTarget(
        name: String,
        bundleId: String,
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleId).\(name.lowercased())Tests",
            sources: [SourcePaths.Frameworks.tests(frameworkName: name)],
            resources: hasResources ? [SourcePaths.Frameworks.testResources(frameworkName: name)] : nil,
            dependencies: [
                .target(name: name),
            ] + dependencies,
            settings: SettingsFactory.testSettings()
        )
    }
    
    public static func extensionTarget(
        name: String,
        bundleId: String,
        extensionType: ExtensionType,
        destinations: Destinations = .iOS,
        hostApp: String,
        version: String = "1.0.0",
        hasUI: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: extensionType.product,
            bundleId: "\(bundleId).\(hostApp.lowercased()).\(name.lowercased())",
            infoPlist: .extendingDefault(with: extensionInfoPlist(type: extensionType)),
            sources: [SourcePaths.Extensions.sources(extensionName: name)],
            resources: hasUI ? [SourcePaths.Extensions.resources(extensionName: name)] : nil,
            entitlements: SourcePaths.Extensions.entitlements(extensionName: name),
            dependencies: dependencies,
            settings: SettingsFactory.extensionSettings()
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
            bundleId: "\(bundleId).\(name.lowercased())Tests",
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
    
    // MARK: - Private Helpers
    
    private static func extensionInfoPlist(type: ExtensionType) -> [String: Plist.Value] {
        var plist: [String: Plist.Value] = [
            "CFBundleDisplayName": "$(PRODUCT_NAME)",
            "NSExtension": [:]
        ]
        
        switch type {
        case .widget:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
            ]
        case .notification:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.usernotifications.service",
                "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).NotificationService"
            ]
        case .action:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.ui-services"
            ]
        case .share:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.share-services"
            ]
        case .today:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.widget-extension"
            ]
        case .intents:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.intents-service"
            ]
        case .intentsUI:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.intents-ui-service"
            ]
        case .fileProvider:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.fileprovider-nonui",
                "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).FileProviderExtension"
            ]
        case .fileProviderUI:
            plist["NSExtension"] = [
                "NSExtensionPointIdentifier": "com.apple.fileprovider-actionsui",
                "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).FileProviderUIExtension",
                "NSExtensionActivationRule": "TRUEPREDICATE"
            ]
        }
        
        return plist
    }
}
