# massage-booking-app

## Author

**Name:** Aleksander Laasmägi  
**Student code:** 253134IAPM

---

## Description

**UI language:** English  
**Development year:** 2025

**Languages and technologies:** Dart, Flutter, Firebase (Authentication, Firestore, Cloud Messaging), Google OAuth2

**Halóre** is a comprehensive massage booking application that enables users to browse massage services, book appointments with available therapists, and manage their bookings seamlessly. The app provides a modern, user-friendly interface with advanced features like push notifications, biometric authentication, and real-time availability checking.

**Target users:** Individuals seeking massage therapy services, wellness centers, and massage therapists.

---

## How to Run

### Prerequisites

#### Android:
- Flutter SDK (^3.10.0)
- Dart SDK
- Android Studio or physical Android device
- Firebase project configured with Android app

#### iOS:
- Flutter SDK (^3.10.0)
- Dart SDK
- Mac with Xcode
- iOS device or simulator
- Firebase project configured with iOS app

### Running the App

After meeting all prerequisites above:

1. Navigate to project root folder `/massage_booking_app` and open terminal or cmd

2. Application needs Flutter packages which can be obtained by executing command:
   ```bash
   flutter pub get
   ```

3. Set up Firebase configuration:
   - Download `google-services.json` from Firebase Console for Android (place in `/android/app/`)
   - Download `GoogleService-Info.plist` from Firebase Console for iOS (place in `/ios/Runner/`)
   - Ensure `firebase_options.dart` is generated using FlutterFire CLI

4. Run code generation for Riverpod and Freezed:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. There are two ways to run the application:

   **Option 1: Development mode**
   ```bash
   flutter run
   ```

   **Option 2: Build and install**
   ```bash
   flutter build apk --release    # For Android devices
   flutter build ios --release     # For iOS devices
   ```

---

## Features

### Mandatory Features Implemented

#### 1. User Authentication
- **OAuth2 Integration with Firebase Auth**
  - Google Sign-In implemented using `google_sign_in` package
  - Microsoft Sign-In support for enterprise users
  - Firebase Authentication backend for secure user management
  
- **Error Handling:**
  - Network connectivity errors caught and displayed
  - Invalid credentials handling
  - Session timeout management
  - Automatic token refresh

- **Implementation Details:**
  - [AuthService](lib/services/auth/auth_service.dart) manages authentication flow
  - [GoogleAuthService](lib/services/auth/google_auth_service.dart) handles Google OAuth2
  - [MicrosoftAuthService](lib/services/auth/microsoft_auth_service.dart) handles Microsoft OAuth2
  - Riverpod state management for auth state with [authProvider](lib/providers/auth/auth_provider.dart)

#### 2. Data Management
- **Cloud Firestore Database:**
  - Real-time data synchronization with Firebase Firestore
  - Collections: `bookings`, `services`, `service_providers`, `locations`, `users`
  - Efficient querying with indexes for performance optimization
  
- **Local Storage:**
  - Flutter Secure Storage for sensitive data (user settings, biometric preferences)
  - Settings persisted locally for offline access
  
- **Data Modification:**
  - Create new bookings with validation
  - Cancel existing bookings
  - Update user settings and preferences
  - FCM token management for push notifications
  
- **Validation:**
  - Booking conflict detection (user and provider availability)
  - Date/time validation for appointments
  - Input sanitization for user data
  - [BookingValidation](lib/utils/booking_validation.dart) utility class
  
- **Error Handling:**
  - Firestore connection errors with user-friendly messages
  - Data parsing failures with fallback mechanisms
  - Transaction rollback on failures
  - Comprehensive logging throughout data layer

- **Architecture:**
  - Repository pattern: [BookingRepository](lib/repositories/bookings/booking_repository.dart), [SettingsRepository](lib/repositories/settings/settings_repository.dart)
  - Service layer: [BookingService](lib/services/booking/booking_service.dart) for business logic
  - Providers: Riverpod-based state management

#### 3. User Interface (5+ Screens)

**Screen 1: Authentication View** ([auth_view.dart](lib/views/auth/auth_view.dart))
- Login screen with OAuth2 options
- Google and Microsoft sign-in buttons
- Loading states and error messages
- Automatic navigation upon successful authentication

**Screen 2: Bookings View** ([bookings_view.dart](lib/views/bookings/bookings_view.dart))
- Lists all user bookings (past and upcoming)
- Displays booking details: service, provider, time, location
- Swipe-to-cancel functionality
- Real-time updates from Firestore
- Empty state when no bookings exist

**Screen 3: New Booking View** ([new_booking_view.dart](lib/views/new_booking/new_booking_view.dart))
- Multi-step booking flow with accordion UI
- Step 1: Location selection with cards
- Step 2: Service selection with images and pricing
- Step 3: Service provider selection
- Step 4: Date and time picker
- Real-time availability checking
- Form validation at each step

**Screen 4: Confirm Booking View** ([confirm_booking_view.dart](lib/views/confirm_booking/confirm_booking_view.dart))
- Summary of booking details
- Price breakdown
- Provider information
- Location details with map integration option
- Confirmation button with loading state
- Navigation back to bookings upon success

**Screen 5: Settings View** ([settings_view.dart](lib/views/settings/settings_view.dart))
- Theme toggle (light/dark mode)
- Notification preferences
- Biometric authentication toggle
- Account management (logout, delete account)
- About section

**Navigation Flow:**
- Implemented using [go_router](lib/router/router.dart)
- Deep linking support
- Route guards for authenticated routes
- Smooth transitions between screens

**UI/UX Considerations:**
- Material Design 3 principles
- Consistent color scheme and typography
- Loading states with progress indicators
- Error states with retry options
- Success feedback with snackbars
- Responsive layout for different screen sizes
- Accessibility considerations (semantic labels, contrast ratios)

#### 4. Technical Architecture & Code Quality

**Architecture Pattern:**
- **Riverpod** for state management (Provider pattern)
- **Repository Pattern** for data access abstraction
- **Service Layer** for business logic separation
- **MVVM-like** structure with Controllers and ViewModels

**Code Organization:**
```
lib/
├── constants/       # App-wide constants and localization
├── controllers/     # Business logic controllers
├── enums/          # Type-safe enumerations
├── models/         # Data models (Freezed for immutability)
├── providers/      # Riverpod providers
├── repositories/   # Data access layer
├── router/         # Navigation configuration
├── services/       # Business logic services
├── typedef/        # Type aliases for clarity
├── utils/          # Helper utilities
└── views/          # UI screens and widgets
```

**Code Quality:**
- Comprehensive error handling throughout all layers
- Extensive inline comments explaining complex logic
- Type safety with strong typing
- Immutable data models using Freezed
- Dependency injection via Riverpod
- Separation of concerns (UI, logic, data)
- Consistent naming conventions
- Flutter lints enabled for code quality

**Design Patterns Used:**
- Repository Pattern (data abstraction)
- Provider Pattern (state management)
- Factory Pattern (model creation)
- Singleton Pattern (services)
- Observer Pattern (reactive updates)

---

### Advanced Features (2+ Implemented)

#### 1. Push Notifications (Firebase Cloud Messaging)
- **Implementation:** [NotificationService](lib/services/notification/notification_service.dart)
- Real-time push notifications for booking confirmations
- Background notification handling
- Foreground notification display
- Token management and refresh
- Permission handling with graceful degradation
- FCM token stored in user profile for targeted notifications

**Technical Details:**
- `firebase_messaging` package integration
- Background message handler: `firebaseMessagingBackgroundHandler`
- Notification listeners in [main.dart](lib/main.dart)
- Platform-specific notification channels

#### 2. Biometric Authentication
- **Implementation:** [BiometricAuthService](lib/services/auth/biometric_auth_service.dart)
- Face ID support (iOS)
- Fingerprint authentication (Android/iOS)
- Device availability checking
- Optional security layer for app access
- Settings toggle to enable/disable
- Fallback to regular authentication

**Technical Details:**
- `local_auth` package for biometric APIs
- Platform-specific biometric type detection
- Secure enclave/keystore integration
- User preference saved in secure storage

#### 3. Real-time Availability Checking
- Live booking conflict detection
- Provider schedule validation
- User double-booking prevention
- Instant feedback on time slot availability
- Firestore queries for concurrent booking checks

#### 4. Social Login (OAuth2)
- Multiple OAuth providers (Google, Microsoft)
- Seamless authentication flow
- Profile information auto-population
- Token management and refresh
- Secure credential storage

---

## Screenshots / Demo

### Authentication Screen
![Authentication Screen Placeholder](./screenshots/auth_screen.png)
*OAuth2 login with Google and Microsoft options*

### Bookings List
![Bookings List Placeholder](./screenshots/bookings_list.png)
*User's booking history and upcoming appointments*

### New Booking Flow
![New Booking Placeholder](./screenshots/new_booking.png)
*Multi-step booking process with location, service, provider, and time selection*

### Booking Confirmation
![Confirmation Placeholder](./screenshots/confirmation.png)
*Final booking details before confirmation*

### Settings Screen
![Settings Placeholder](./screenshots/settings.png)
*User preferences, notifications, and biometric authentication*

---

## Installation & Setup

### 1. Clone the Repository
```bash
git clone https://gitlab.cs.taltech.ee/allaas/massage_booking_app.git
cd massage_booking_app
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use existing
3. Add Android app with package name: `com.example.massage_booking_app`
4. Add iOS app with bundle ID: `com.example.massageBookingApp`

#### Configure Firebase Authentication:
1. Enable Google Sign-In in Authentication > Sign-in methods
2. Enable Microsoft Sign-In (optional)
3. Add SHA-1 fingerprint for Android (for Google Sign-In)

#### Configure Firestore:
1. Create Firestore database in production mode
2. Set up security rules (see [firebase.json](firebase.json))
3. Create collections: `bookings`, `services`, `service_providers`, `locations`, `users`

#### Configure Cloud Messaging:
1. Enable Firebase Cloud Messaging
2. Download `google-services.json` for Android → `/android/app/`
3. Download `GoogleService-Info.plist` for iOS → `/ios/Runner/`

#### Generate Firebase Options:
```bash
flutterfire configure
```

### 4. Run Code Generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Configure Android
- Update `android/app/build.gradle.kts` with correct application ID
- Ensure `google-services.json` is in correct location
- Configure signing keys if building release

### 6. Configure iOS
- Open `ios/Runner.xcworkspace` in Xcode
- Set development team and signing
- Ensure `GoogleService-Info.plist` is added to project
- Configure capabilities (Push Notifications, Keychain Sharing)

### 7. API Keys & Configuration
- **Google OAuth:** Configured in Firebase Console
- **Microsoft OAuth:** Requires Azure AD app registration (client ID in code)
- **FCM Server Key:** For sending push notifications (backend)

---

## Usage

### Registration & Login
1. Launch the app
2. Select authentication method (Google or Microsoft)
3. Complete OAuth2 flow in browser/WebView
4. Automatic profile creation in Firestore

### Browsing & Booking
1. Navigate to "New Booking" from main screen
2. **Select Location:** Choose from available massage locations
3. **Select Service:** Browse massage types with images and descriptions
4. **Select Provider:** Choose from available therapists
5. **Select Date/Time:** Pick convenient time slot
6. Review booking details in confirmation screen
7. Confirm booking → Notification sent

### Managing Bookings
1. View all bookings in "Bookings" tab
2. Swipe left on booking to cancel
3. Confirm cancellation in dialog
4. Booking status updated in real-time

### Notifications
1. Grant notification permission when prompted
2. Receive push notifications for:
   - Booking confirmations
   - Booking reminders
   - Cancellation confirmations

### Biometric Authentication
1. Go to Settings
2. Toggle "Biometric Authentication"
3. Complete biometric enrollment (if not already)
4. App will prompt for biometric auth on next launch

### Settings Management
1. Access Settings from top-right menu
2. Toggle dark/light theme
3. Enable/disable push notifications
4. Enable/disable biometric authentication
5. Logout or delete account

---

## Technical Implementation

### Architecture Overview

**State Management:** Riverpod 3.0
- Providers for all business logic
- Auto-dispose for memory efficiency
- Code generation with `riverpod_generator`

**Data Layer:**
- **Repositories:** Abstract data source access (Firestore, Secure Storage)
- **Models:** Immutable with Freezed
- **Type Aliases:** Improved code readability (UserId, BookingId, etc.)

**Business Logic:**
- **Services:** Coordinate between repositories and UI
- **Controllers:** Handle user interactions and state updates
- **Validators:** Input validation and business rules

**UI Layer:**
- **Views:** Screen-level widgets
- **Widgets:** Reusable components
- **Themes:** Centralized styling

---

## Future Enhancements

1. **Enhanced Features:**
   - In-app messaging between users and therapists
   - Payment integration (Stripe, PayPal)
   - Rating and review system
   - Appointment rescheduling
   - Recurring booking support

2. **Technical Improvements:**
   - Comprehensive test coverage (unit, widget, integration)
   - CI/CD pipeline with automated testing
   - Performance monitoring with Firebase Analytics
   - Crash reporting with Firebase Crashlytics
   - Localization for multiple languages

3. **User Experience:**
   - Onboarding tutorial for first-time users
   - Advanced filtering for services/providers
   - Calendar view for bookings
   - Push notification customization
   - Accessibility improvements (screen reader, high contrast)

4. **Backend:**
   - Cloud Functions for business logic (booking reminders, cleanup)
   - Admin panel for managing services/providers
   - Analytics dashboard for business insights
   - Email notifications as backup to push


