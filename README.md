# video_call_app

A new Flutter project.

Here’s an example of a README.md file for your Flutter application:

Posts Application
Architectural Choices
1. State Management
   The app uses GetX for state management due to its simplicity and reactivity. GetX provides:

Reactive State Management: Efficient and easy-to-use reactive state updates.
Navigation: Seamless navigation between screens without the need for context.
Dependency Injection: Lightweight dependency injection for controllers.
2. Code Structure
   The code is organized into the following layers:

Controllers: Manage business logic and interact with APIs/local storage.
Views: Represent the UI components and utilize controllers for data.
Widgets: Reusable UI components (e.g., TimerIcon).

    Third-Party Libraries Used
    Library	Purpose	Link
        get	State management, navigation, and DI	GetX
        shared_preferences	Local storage for persisting read status	Shared Preferences
# Instructions to Run the Application
1. Prerequisites
   Install Flutter (v3.0.0 or later recommended).
   Install a code editor (e.g., VS Code or Android Studio).
   Set up an emulator or connect a physical device.

3. Install Dependencies
   Run the following commands to install all required dependencies:

   Copy code
   flutter pub get
4. Run the App
   Use the following command to run the application:
   Alternatively, you can run the app from your IDE.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
