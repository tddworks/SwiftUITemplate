import ProjectDescription

//  AppProjectConfig.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//

// MARK: - Configuration Protocol
public protocol AppProjectConfig {
    var name: String { get }
    var baseBundleID: String { get }
    var destinations: Destinations { get }
    var versionNumber: String { get }
    var organizationName: String { get }
    var devTeam: String { get }
    var infoPlist: [String: Plist.Value] { get }
}

// MARK: - Default Implementation
public struct DefaultAppProjectConfig: AppProjectConfig {
    public let name: String
    public let baseBundleID: String
    public let destinations: Destinations
    public let versionNumber: String
    public let organizationName: String
    public let devTeam: String
    public let infoPlist: [String: Plist.Value]

    public init(
            name: String,
            baseBundleID: String,
            destinations: Destinations,
            versionNumber: String,
            organizationName: String,
            devTeam: String,
            infoPlist: [String: Plist.Value]? = nil
    ) {
        self.name = name
        self.baseBundleID = baseBundleID
        self.destinations = destinations
        self.versionNumber = versionNumber
        self.organizationName = organizationName
        self.devTeam = devTeam
        self.infoPlist = infoPlist ?? Self.defaultInfoPlist(for: versionNumber)
    }
}

// MARK: - Default Configuration
private extension DefaultAppProjectConfig {
    static func defaultInfoPlist(for version: String) -> [String: Plist.Value] {
        return [
            "CFBundleShortVersionString": Plist.Value(stringLiteral: version),
            "CFBundleVersion": "1",
            "UILaunchScreen": ["UIColorName": "AccentColor"],
            "ITSAppUsesNonExemptEncryption": false
        ]
    }
}
