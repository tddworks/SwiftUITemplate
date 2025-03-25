
import ProjectDescription

extension Project {

    public static func app(
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
    
    public static func makeFrameworkTargets(
        name: String,
        bundleId: String,
        destinations: Destinations,
        platform: Platform,
        dependencies: [TargetDependency],
        noResources: Bool = true
    ) -> [Target] {
        let sourceTarget = createFrameworkTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations,
            dependencies: dependencies,
            noResources: noResources
        )
        
        let testTarget = createFrameworkTestTarget(
            name: name,
            bundleId: bundleId,
            destinations: destinations
        )
        
        return [sourceTarget, testTarget]
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
    
    private static func createFrameworkTarget(
        name: String,
        bundleId: String,
        destinations: Destinations,
        dependencies: [TargetDependency],
        noResources: Bool
    ) -> Target {
        return Target.target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: "\(bundleId).\(name)",
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: noResources ? [] : ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
    }
    
    private static func createFrameworkTestTarget(
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
            resources: [],
            dependencies: [.target(name: name)]
        )
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
}
