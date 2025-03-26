import ProjectDescription

//  AppProjectConfig.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//


// MARK: - Configuration Structs

public struct AppProjectConfig {
    public let name: String
    public let baseBundleID: String
    public let destinations: Destinations
    public let versionNumber: String
    public let platform: Platform
    public let organizationName: String
    public let devTeam: String
    public let infoPlist: [String: Plist.Value]
    
    public init(
        name: String,
        baseBundleID: String,
        destinations: Destinations,
        versionNumber: String,
        platform: Platform,
        organizationName: String,
        devTeam: String,
        infoPlist: [String: Plist.Value]? = nil
    ) {
        self.name = name
        self.baseBundleID = baseBundleID
        self.destinations = destinations
        self.versionNumber = versionNumber
        self.platform = platform
        self.organizationName = organizationName
        self.devTeam = devTeam
        
        self.infoPlist = infoPlist ?? [
            "CFBundleShortVersionString": Plist.Value(stringLiteral: versionNumber),
            "CFBundleVersion": "1",
            "UILaunchScreen": ["UIColorName": "AccentColor"],
            "ITSAppUsesNonExemptEncryption": false
        ]
    }
}
