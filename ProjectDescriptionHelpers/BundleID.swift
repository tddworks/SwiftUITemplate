//
//  BundleID.swift
//  SwiftUITemplate
//
//  Created by hanrenwei on 3/26/25.
//


// MARK: - Bundle IDs

public enum BundleID {
    public static func app(_ appName: String, base: String) -> String { "\(base).\(appName.lowercased())" }
    public static func appTests(_ appName: String, base: String) -> String { "\(base).\(appName.lowercased())Tests" }
    public static func module(_ moduleName: String, base: String) -> String { "\(base).\(moduleName.lowercased())" }
    public static func moduleTests(_ moduleName: String, base: String) -> String { "\(base).\(moduleName.lowercased())Tests" }
}
