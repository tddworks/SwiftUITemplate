# SwiftUITemplate

A ready-to-use [Tuist](https://tuist.io/) template for kickstarting SwiftUI projects and modular frameworks with best practices.

## 🚀 Features

- Quickly scaffold a SwiftUI application or reusable module.
- Organized folder structure for easy project maintenance.
- Pre-configured test targets and resource folders.

---

## 🛠️ Getting Started

### 1. Add the Template to Your Project

Add this template as a Tuist plugin in your `Project.swift`:

```swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .git(url: "https://github.com/tddworks/SwiftUITemplate", tag: "v1.0.1")
    ])
)
```

---

### 2. Create a New SwiftUI App

Generate a new SwiftUI application using:

```sh
tuist scaffold app --name AppName
```

**Resulting Structure:**
```
Root/
├── Tuist/ProjectDescriptionHelpers/Targets/Products/AppName.swift
├── Products/
│   ├── AppName/
│   │   ├── Resources/
│   │   │   └── Info.plist
│   │   └── Sources/
│   │       ├── AppNameApp.swift
│   │       └── ContentView.swift
│   └── AppNameTests/
│       ├── Resources/
│       └── Sources/
│           └── AppNameTests.swift
└── Project.swift
```

---

### 3. Create a New Module (Framework)

Generate a reusable module with:

```sh
tuist scaffold module --name ModuleName
```

**Resulting Structure:**
```
Root/
├── Tuist/ProjectDescriptionHelpers/Targets/Products/ModuleName.swift
├── Modules/
│   ├── ModuleName/
│   │   ├── Resources/
│   │   │   └── Info.plist
│   │   └── Sources/
│   │       └── ModuleName.swift
│   └── ModuleNameTests/
│       ├── Resources/
│       └── Sources/
│           └── ModuleNameTests.swift
```

---

## 📚 Learn More

- [Tuist Documentation](https://docs.tuist.io/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.
