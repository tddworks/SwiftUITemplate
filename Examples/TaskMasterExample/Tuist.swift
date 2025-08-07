import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .local(path: "../../../") // Point to our SwiftUITemplate
    ])
)