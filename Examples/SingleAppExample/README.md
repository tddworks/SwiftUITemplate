#### Single App Project

```bash
# 1. Create the main app and project structure
tuist scaffold app --name MyApp --platform ios --bundle-id com.mycompany

# 2. Generate initial project
tuist generate

# 3. Add components safely to existing project
tuist scaffold addframework --name Core --has-resources false
tuist scaffold addframework --name NetworkLayer --has-resources false

# 4. Add feature modules  
tuist scaffold addmodule --name Authentication
tuist scaffold addmodule --name UserProfile

# 5. Add extensions
tuist scaffold addextension --name MyWidget --type widget --host-app MyApp
tuist scaffold addextension --name MyCloudSync --type fileprovider --host-app MyApp

# 6. Add additional apps to the same project (optional)
tuist scaffold addapp --name MyApp1 --platform macos --bundle-id com.mycompany.macos
tuist scaffold addapp --name DemoApp --platform ios --bundle-id com.mycompany.demo

# 7. Generate final project with all components
tuist generate
```