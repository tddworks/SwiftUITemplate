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
    
    public static func createStaticFramework(
        name: String,
        baseBundleID: String,
        destinations: Destinations = [.iPhone],
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: .staticFramework,
            bundleId: BundleID.module(name, base: baseBundleID),
            sources: [SourcePaths.Modules.sources(moduleName: name)],
            resources: hasResources ? [SourcePaths.Modules.resources(moduleName: name)] : nil,
            dependencies: dependencies,
            settings: SettingsFactory.frameworkSettings(usesMaxSwiftVersion: true)
        )
    }
    
    public static func createDynamicFramework(
        name: String,
        baseBundleID: String,
        destinations: Destinations = [.iPhone],
        hasResources: Bool = false,
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
            settings: SettingsFactory.frameworkSettings(usesMaxSwiftVersion: true)
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
    
    public static func createExtension(
        name: String,
        baseBundleID: String,
        extensionType: ExtensionType,
        destinations: Destinations = [.iPhone],
        hostApp: String,
        hasResources: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: extensionType.product,
            bundleId: "\(baseBundleID).\(hostApp.lowercased()).\(name.lowercased())",
            infoPlist: .extendingDefault(with: extensionInfoPlist(type: extensionType)),
            sources: [SourcePaths.Extensions.sources(extensionName: name)],
            resources: hasResources ? [SourcePaths.Extensions.resources(extensionName: name)] : nil,
            entitlements: SourcePaths.Extensions.entitlements(extensionName: name),
            dependencies: dependencies,
            settings: SettingsFactory.extensionSettings()
        )
    }
    
    public static func createAppTarget(
        name: String,
        baseBundleID: String,
        destinations: Destinations = [.iPhone],
        version: String = "1.0.0",
        hasResources: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: BundleID.app(name, base: baseBundleID),
            infoPlist: .extendingDefault(with: appInfoPlist(version: version)),
            sources: [SourcePaths.Apps.sources(appName: name)],
            resources: hasResources ? [SourcePaths.Apps.resources(appName: name)] : nil,
            dependencies: dependencies,
            settings: SettingsFactory.appSettingsWithVersion(version: version)
        )
    }
    
    public static func createAppTestTarget(
        name: String,
        baseBundleID: String,
        destinations: Destinations = [.iPhone],
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: BundleID.appTests(name, base: baseBundleID),
            sources: [SourcePaths.Apps.tests(appName: name)],
            resources: hasResources ? [SourcePaths.Apps.testResources(appName: name)] : nil,
            dependencies: [.target(name: name)] + dependencies,
            settings: SettingsFactory.testSettings()
        )
    }
    
    // MARK: - Private Helpers
    
    private static func appInfoPlist(version: String) -> [String: Plist.Value] {
        return [
            "CFBundleShortVersionString": .string(version),
            "CFBundleVersion": "1",
            "UILaunchScreen": [
                "UIColorName": "AccentColor"
            ],
            "ITSAppUsesNonExemptEncryption": false,
            "LSApplicationCategoryType": "public.app-category.utilities"
        ]
    }
    
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
