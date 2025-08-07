import ProjectDescription

/// Automatically managed file that collects all scaffolded targets
/// This file is updated by scaffold commands to include new targets
public enum ProjectTargets {
    
    /// Returns all available targets for the project
    public static func allTargets(appTargets: [Target]) -> [Target] {
        return appTargets + allAppTargets + frameworkTargets + moduleTargets + extensionTargets
    }
    
    /// Additional app targets - automatically updated by `tuist scaffold addapp`
    private static let allAppTargets: [Target] = [
        // Additional app targets will be added here automatically
    ]
    
    /// Framework targets - automatically updated by `tuist scaffold framework`
    private static let frameworkTargets: [Target] = [
        // Framework targets will be added here automatically
    ]
    
    /// Module targets - automatically updated by `tuist scaffold module`
    private static let moduleTargets: [Target] = [
        // Module targets will be added here automatically
    ]
    
    /// Extension targets - automatically updated by `tuist scaffold extension`
    private static let extensionTargets: [Target] = [
        // Extension targets will be added here automatically
    ]
}