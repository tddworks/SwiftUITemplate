import ProjectDescription
//  SettingsFactory.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//


// MARK: - Settings Factory

public enum SettingsFactory {
    public static func appSettings(config: AppProjectConfig) -> Settings {
        let base = SettingsDictionary()
            .automaticCodeSigning(devTeam: config.devTeam)
            .marketingVersion(config.versionNumber)
            .currentProjectVersion("Auto generated")
        return .settings(base: base, defaultSettings: .recommended)
    }
    
    public static func frameworkSettings(usesMaxSwiftVersion: Bool) -> ProjectDescription.Settings {
        return .settings(
            base: [
                "CODE_SIGN_IDENTITY": "",
                "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": false,
                "ENABLE_MODULE_VERIFIER": true,
                "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": ["gnu11", "gnu++14"],
                "SWIFT_VERSION": (usesMaxSwiftVersion ? "$(SWIFT_MAX_VERSION)" : "$(inherited)"),
            ])
    }
    
    public static func testSettings() -> Settings {
        .settings(base: ["SWIFT_VERSION": "$(SWIFT_MAX_VERSION)"])
    }
    
    public static func extensionSettings() -> Settings {
        .settings(
            base: [
                "SKIP_INSTALL": true,
                "ENABLE_MODULE_VERIFIER": true,
                "ENABLE_HARDENED_RUNTIME": true,
                "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": ["gnu11", "gnu++14"]
            ]
        )
    }
    
    public static func appSettingsWithVersion(version: String, devTeam: String = "$(DEVELOPMENT_TEAM)") -> Settings {
        let baseSettings = SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
            .automaticCodeSigning(devTeam: devTeam)
            .currentProjectVersion("1")
            .marketingVersion(version)
        return .settings(base: baseSettings, defaultSettings: .recommended)
    }
}
