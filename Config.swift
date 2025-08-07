import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .all,
    swiftVersion: "5.9",
    generationOptions: .options(
        disableBundleAccessors: false,
        disableSynthesizedResourceAccessors: false,
        enforceExplicitDependencies: true
    )
)

