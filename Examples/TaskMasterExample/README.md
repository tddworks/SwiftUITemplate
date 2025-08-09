# TaskMaster - Multi-App Workspace Example

This example demonstrates a complete multi-app workspace created using the SwiftUITemplate system.

## Project Overview

TaskMaster is a productivity app ecosystem consisting of:

1. **TaskMaster** - Main consumer iOS app for task management
2. **TaskMaster Admin** - Administrative app for team/organization management  
3. **TaskMaster Lite** - Simplified version for basic users
4. **Shared Frameworks** - Common business logic and UI components
5. **Extensions** - Widget, File Provider, and other app extensions

## Architecture

```
TaskMasterWorkspace/
├── TaskMaster/              # Main consumer app
├── TaskMasterAdmin/         # Admin/management app  
├── TaskMasterLite/          # Simplified version
├── Shared/                  # Shared frameworks project
│   ├── Core/               # Business logic
│   ├── UI/                 # Shared UI components
│   ├── Networking/         # API layer
│   └── Database/           # Data persistence
├── Extensions/             # App extensions
└── Tuist/                  # Configuration
```

## Setup

1. **Configure Tuist Plugin**: Create `Tuist.swift` in your project root:

\`\`\`swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(plugins: [
        .local(path: "path/to/SwiftUITemplate") // Point to SwiftUITemplate
        // OR use git version:
        // .git(url: "https://github.com/tddworks/SwiftUITemplate", tag: "v1.0.1")
    ])
)
\`\`\`

2. **Run Generation Script**: Execute `./generate-project.sh` or run commands individually.

## Commands Used to Generate This Project

\`\`\`bash
# 1. Create the main workspace
tuist scaffold workspace --name TaskMasterWorkspace \\
  --apps "TaskMaster,TaskMasterAdmin,TaskMasterLite" \\
  --bundleIdPrefix com.taskmaster \\
  --structure multi \\
  --sharedFrameworks "Core,UI,Networking,Database"

# 2. Add additional shared frameworks
tuist scaffold framework --name Analytics --hasResources false
tuist scaffold framework --name Security --hasResources false

# 3. Add extensions
tuist scaffold extension --name TaskMasterWidget --type widget --hostApp TaskMaster
tuist scaffold extension --name TaskMasterFileSync --type fileprovider --hostApp TaskMaster
tuist scaffold extension --name AdminNotifications --type notification --hostApp TaskMasterAdmin

# 4. Add feature modules
tuist scaffold module --name TaskManagement
tuist scaffold module --name UserManagement  
tuist scaffold module --name TeamCollaboration
tuist scaffold module --name ReportGeneration

# 5. Generate the complete workspace
tuist generate
\`\`\`

## App Details

### TaskMaster (Main App)
- **Target**: Consumer users
- **Features**: Task creation, organization, reminders, collaboration
- **Dependencies**: Core, UI, Networking, Database, TaskManagement, UserManagement
- **Extensions**: Widget for quick task view, File Provider for document attachment

### TaskMaster Admin
- **Target**: Team administrators and managers
- **Features**: User management, team organization, analytics dashboard
- **Dependencies**: Core, UI, Networking, Database, UserManagement, TeamCollaboration, ReportGeneration
- **Extensions**: Notification service for admin alerts

### TaskMaster Lite  
- **Target**: Users who want simple task management
- **Features**: Basic task creation and completion
- **Dependencies**: Core, UI (minimal), Database (local only)
- **Extensions**: None (lightweight)

## Shared Frameworks

### Core Framework
Contains business logic shared across all apps:
- Task models and business rules
- User authentication logic
- Data validation
- Common utilities

### UI Framework  
Shared user interface components:
- Design system components
- Common SwiftUI views
- Theme and styling
- Custom controls

### Networking Framework
API communication layer:
- REST API client
- WebSocket connections for real-time features
- Request/response models
- Network reachability

### Database Framework
Data persistence layer:
- Core Data stack
- CloudKit integration
- Local caching
- Data migration utilities

## Feature Modules

### TaskManagement Module
- Task creation, editing, deletion
- Task organization (projects, tags, priorities)
- Scheduling and reminders
- Task templates

### UserManagement Module  
- User authentication
- Profile management
- Preferences and settings
- Account synchronization

### TeamCollaboration Module
- Team creation and management
- Task sharing and assignment
- Real-time collaboration features
- Activity feeds

### ReportGeneration Module
- Analytics and reporting
- Data visualization
- Export functionality
- Custom report builders

## Development Workflow

1. **Individual App Development**: Each app can be developed independently
2. **Shared Code**: Common functionality lives in shared frameworks
3. **Testing**: Each component has its own test suite
4. **Deployment**: Apps can be released on different schedules
5. **Feature Flags**: Use shared Core framework for feature toggling across apps

## Benefits of This Architecture

- **Code Reuse**: Shared frameworks eliminate duplication
- **Modular Development**: Teams can work on different apps/modules independently  
- **Scalability**: Easy to add new apps or features
- **Testing**: Isolated testing for each component
- **Maintenance**: Centralized business logic in shared frameworks