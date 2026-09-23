# Requirements Document

## Introduction

The Flutter application currently has broken dependency injection causing runtime errors when trying to access BLoCs. The app uses GetIt for dependency injection but the initialization is commented out, and some BLoCs are missing from the registration. This feature will fix the dependency injection system to ensure all authentication BLoCs are properly registered and accessible throughout the app.

## Requirements

### Requirement 1

**User Story:** As a developer, I want all BLoCs to be properly registered in the dependency injection container, so that the app doesn't crash with "not registered" errors.

#### Acceptance Criteria

1. WHEN the app starts THEN the dependency injection container SHALL be initialized with all required dependencies
2. WHEN any screen tries to access a BLoC THEN the BLoC SHALL be available from the service locator
3. WHEN the SignUpBloc is requested THEN it SHALL be properly instantiated with its dependencies
4. WHEN the SignInBloc is requested THEN it SHALL be properly instantiated with its dependencies

### Requirement 2

**User Story:** As a developer, I want the dependency injection initialization to happen before the app widget is created, so that all dependencies are available when needed.

#### Acceptance Criteria

1. WHEN the main function runs THEN initDependencies() SHALL be called and completed before runApp()
2. WHEN initDependencies() completes THEN all core services SHALL be registered
3. WHEN initDependencies() completes THEN all repository dependencies SHALL be registered
4. WHEN initDependencies() completes THEN all BLoC dependencies SHALL be registered

### Requirement 3

**User Story:** As a developer, I want all authentication BLoCs to be consistently registered, so that the authentication flow works without errors.

#### Acceptance Criteria

1. WHEN the service locator is initialized THEN SignUpBloc SHALL be registered as a factory
2. WHEN the service locator is initialized THEN SignInBloc SHALL be registered as a factory
3. WHEN the service locator is initialized THEN ForgotPasswordBloc SHALL be registered as a factory
4. WHEN the service locator is initialized THEN ResetPasswordBloc SHALL be registered as a factory
5. WHEN the service locator is initialized THEN VerifyOtpBloc SHALL be registered as a factory

### Requirement 4

**User Story:** As a developer, I want proper error handling during dependency initialization, so that initialization failures are clearly identified.

#### Acceptance Criteria

1. WHEN dependency initialization fails THEN the error SHALL be logged with clear details
2. WHEN a required dependency is missing THEN the initialization SHALL fail with a descriptive error
3. WHEN initialization completes successfully THEN the app SHALL proceed to start normally