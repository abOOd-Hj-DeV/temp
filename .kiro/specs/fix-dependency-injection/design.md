# Design Document

## Overview

This design addresses the broken dependency injection system in the Flutter application. The current issue is that `initDependencies()` is commented out in main.dart, causing GetIt to not initialize the service locator, which results in runtime errors when BLoCs try to access their dependencies. Additionally, the SignInBloc is missing from the service locator registration.

The solution involves:
1. Uncommenting and properly calling `initDependencies()` in main.dart
2. Adding the missing SignInBloc registration to the service locator
3. Ensuring proper error handling during initialization
4. Maintaining the existing architecture with GetIt + Flutter Modular

## Architecture

The application uses a layered architecture with:
- **Presentation Layer**: BLoCs for state management
- **Data Layer**: Repositories and API services
- **Core Layer**: Network utilities and API consumers
- **Dependency Injection**: GetIt for service location
- **Routing**: Flutter Modular for navigation

### Current Dependency Graph
```
BLoCs (SignUpBloc, SignInBloc, etc.)
    ↓
AuthRepository
    ↓
AuthApiService + NetworkInfo
    ↓
DioConsumer + InternetConnectionChecker
    ↓
Dio (HTTP client)
```

## Components and Interfaces

### Service Locator (GetIt)
- **Location**: `lib/shared/services/service_locator.dart`
- **Purpose**: Central registry for all dependencies
- **Registration Types**:
  - `registerLazySingleton`: For services that should be created once and reused
  - `registerFactory`: For objects that should be created fresh each time (like BLoCs)

### Main Application Entry Point
- **Location**: `lib/main.dart`
- **Responsibilities**:
  - Initialize Flutter bindings
  - Call dependency initialization
  - Start the Modular app

### App Module (Flutter Modular)
- **Location**: `lib/app/app_module.dart`
- **Purpose**: Route configuration and BLoC providers
- **Dependencies**: Uses GetIt service locator to inject BLoCs

## Data Models

No new data models are required. The existing models and dependencies remain unchanged:
- AuthRepository
- AuthApiService
- NetworkInfo
- DioConsumer
- All existing BLoCs

## Error Handling

### Initialization Errors
- Wrap `initDependencies()` in try-catch block
- Log initialization failures with specific error details
- Prevent app startup if critical dependencies fail to register

### Runtime Errors
- GetIt will throw descriptive errors if dependencies are not registered
- BLoC creation failures will be caught by Flutter Modular's error handling
- Network-related errors are handled by existing repository layer

### Error Recovery
- If initialization fails, display error dialog to user
- Provide option to retry initialization
- Log errors for debugging purposes

## Testing Strategy

### Unit Tests
- Test service locator registration for all dependencies
- Verify BLoC creation with proper dependencies
- Test error scenarios (missing dependencies, initialization failures)

### Integration Tests
- Test complete dependency chain from BLoC to API service
- Verify app startup with proper dependency initialization
- Test navigation between screens with BLoC injection

### Widget Tests
- Test screens with mocked dependencies
- Verify BLoC providers are properly injected
- Test error states when dependencies are unavailable

## Implementation Details

### Service Locator Updates
The service locator needs to register the missing SignInBloc:
```dart
sl.registerFactory(() => SignInBloc(sl()));
```

### Main.dart Updates
Uncomment and properly handle the initialization:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
```

### Error Handling Implementation
Add proper error handling around initialization:
```dart
try {
  await initDependencies();
} catch (e) {
  // Log error and handle gracefully
}
```

## Dependencies

### Existing Dependencies
- get_it: ^7.6.4 (service locator)
- flutter_modular: (routing and dependency injection)
- flutter_bloc: (state management)
- dio: (HTTP client)
- internet_connection_checker: (network status)

### No New Dependencies Required
The fix uses existing packages and doesn't require additional dependencies.

## Security Considerations

- No sensitive data is stored in the service locator
- Dependencies are registered at app startup, not runtime
- Network dependencies use existing security configurations
- No changes to authentication or data handling logic