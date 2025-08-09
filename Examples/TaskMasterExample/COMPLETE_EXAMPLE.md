# TaskMaster - Complete Multi-App Example

This is a **complete working example** of how to use the SwiftUITemplate as a Tuist plugin to generate a sophisticated multi-app workspace.

## 🎯 What This Example Demonstrates

- **Multi-app workspace** with 3 different apps
- **Shared frameworks** for code reuse
- **App extensions** (widgets, file provider, notifications)
- **Feature modules** for modular development
- **Proper Tuist plugin configuration**
- **Real-world project structure**

## 📁 File Structure

```
TaskMasterExample/
├── Tuist.swift                     # ✅ Plugin configuration
├── Tuist/Config.swift              # ✅ Tuist settings
├── generate-project.sh             # ✅ Complete generation script
├── test-plugin.sh                  # ✅ Plugin validation script
├── expected-structure.md            # ✅ Expected output documentation
└── README.md                       # ✅ Complete documentation
```

## 🚀 How to Use This Example

### Step 1: Plugin Configuration ✅

The `Tuist.swift` file is configured to use SwiftUITemplate as a local plugin:

```swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .local(path: "../../") // Points to SwiftUITemplate root
    ])
)
```

### Step 2: Test Plugin Setup ✅

Run the test script to verify everything is working:

```bash
./test-plugin.sh
```

This will:
- ✅ Check if Tuist is installed
- ✅ Verify plugin configuration
- ✅ List available templates
- ✅ Confirm plugin is properly loaded

### Step 3: Generate Complete Project ✅

Run the generation script to create the full workspace:

```bash
./generate-project.sh
```

This will execute **all template commands** in sequence:

1. **Workspace Creation**:
   ```bash
   tuist scaffold workspace --name TaskMasterWorkspace \
     --apps "TaskMaster,TaskMasterAdmin,TaskMasterLite" \
     --bundleIdPrefix com.taskmaster \
     --structure multi \
     --sharedFrameworks "Core,UI,Networking,Database"
   ```

2. **Additional Frameworks**:
   ```bash
   tuist scaffold framework --name Analytics --hasResources false
   tuist scaffold framework --name Security --hasResources false
   ```

3. **Feature Modules**:
   ```bash
   tuist scaffold module --name TaskManagement
   tuist scaffold module --name UserManagement
   tuist scaffold module --name TeamCollaboration
   tuist scaffold module --name ReportGeneration
   ```

4. **App Extensions**:
   ```bash
   tuist scaffold extension --name TaskMasterWidget --type widget --hostApp TaskMaster
   tuist scaffold extension --name TaskMasterFileSync --type fileprovider --hostApp TaskMaster
   tuist scaffold extension --name AdminNotifications --type notification --hostApp TaskMasterAdmin
   ```

5. **Project Generation**:
   ```bash
   tuist generate
   ```

### Step 4: Open and Build ✅

After generation:
1. Open `TaskMasterWorkspace.xcworkspace`
2. Select any app target (TaskMaster, TaskMasterAdmin, TaskMasterLite)
3. Build and run!

## 🏗️ Generated Architecture

### Apps Generated:
- **TaskMaster**: Main consumer iOS app
- **TaskMasterAdmin**: Administrative/management app
- **TaskMasterLite**: Simplified version for basic users

### Shared Frameworks:
- **Core**: Business logic and models
- **UI**: Shared SwiftUI components and design system
- **Networking**: API client and network layer
- **Database**: Core Data stack and persistence
- **Analytics**: Usage tracking and metrics
- **Security**: Authentication and encryption

### Feature Modules:
- **TaskManagement**: Task CRUD operations
- **UserManagement**: User profiles and authentication
- **TeamCollaboration**: Multi-user features
- **ReportGeneration**: Analytics and reporting

### App Extensions:
- **TaskMasterWidget**: Widget for quick task view
- **TaskMasterFileSync**: File Provider for document sync
- **AdminNotifications**: Push notifications for admins

## 🎯 Template Features Demonstrated

✅ **Multi-App Support**: Three apps sharing common frameworks
✅ **File Provider Extensions**: Cloud storage integration
✅ **Widget Extensions**: iOS home screen widgets
✅ **Notification Extensions**: Push notification handling
✅ **Framework Templates**: Reusable shared code
✅ **Module Templates**: Feature-specific modules
✅ **Workspace Templates**: Multi-project organization
✅ **Proper Dependencies**: Apps depending on shared frameworks
✅ **SwiftUI Integration**: Modern iOS development stack

## 🔧 Advanced Usage

### Add More Apps:
```bash
tuist scaffold multiapp --name TaskMasterWatch --workspace TaskMasterWorkspace
```

### Add More Extensions:
```bash
tuist scaffold extension --name TaskMasterSharing --type share --hostApp TaskMaster
```

### Add More Modules:
```bash
tuist scaffold module --name CalendarIntegration
```

## ✅ Success Validation

After running the scripts, you should see:

1. **Workspace Structure**: Multi-project workspace with separate app projects
2. **Shared Project**: Contains all frameworks with proper dependencies
3. **Working Apps**: Each app builds and runs independently
4. **Proper Schemes**: Individual schemes for each app target
5. **Test Targets**: Unit tests for all frameworks and apps
6. **Extensions**: Properly configured app extensions
7. **Modular Architecture**: Clean separation between features

## 🎓 Learning Outcomes

This example teaches:

- How to configure Tuist plugins properly
- How to structure large multi-app projects  
- How to share code between multiple apps
- How to use app extensions effectively
- How to organize complex Xcode workspaces
- How to scale iOS development with modular architecture

## 📚 Next Steps

1. **Customize**: Modify the generated code for your specific needs
2. **Extend**: Add more apps, frameworks, or extensions
3. **Deploy**: Configure CI/CD for multiple app targets
4. **Scale**: Apply these patterns to your own projects

This example represents a **production-ready** multi-app architecture generated entirely from templates! 🚀