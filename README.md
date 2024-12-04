
# Flutex Admin  

*Edited by Shubham Choudhary*  

## Overview  

**Flutex Admin** is an administrative tool designed for efficient data management and improved user experience. The app integrates Firebase for database operations, replacing the previous Prefix CRM system. Utilizing the **GetX MVVM** architecture, it ensures seamless state management and data flow. Key features like shared preferences and caching enhance performance and offline usability.  

---

## Features  

- **Firebase Integration**:  
  - Migrated the database to Firebase for scalability and real-time updates.  
  - Developed services for Firebase Authentication and Functions.  

- **State Management with GetX**:  
  - Implemented **GetX controllers** to fetch and display data dynamically.  
  - Simplified MVVM architecture for clear separation of concerns.  

- **Shared Preferences**:  
  - Added support for local data storage to maintain a consistent user experience.  

- **Cache Management**:  
  - Optimized caching for faster data access and reduced API calls.  

---

## App Architecture  

The app is structured following the **MVVM (Model-View-ViewModel)** architecture and uses **GetX** for state management.  

```
lib/
├── assignment_work/                
│   ├── firebase_auth.dart          # Firebase Authentication service
│   └── firebase_functions.dart     # Service for Firebase Functions
├── core/
│   ├── di_service/                 # Dependency Injection services
│   ├── helper/                     # Utility classes
│   ├── route/                      # Routing logic for navigation
│   └── utils/                      # General utility functions
├── data/                           # Models and related logic
├── view/
│   ├── components/                 # UI components
│   ├── screens/                    # App screens
│   └── main.dart                   # App entry point
```

---

## Technology Stack  

- **Firebase**: Used for authentication, real-time database, and cloud functions.  
- **GetX**: Provides state management, routing, and dependency injection.  
- **MVVM Architecture**: Ensures a modular and scalable app structure.  
- **Shared Preferences**: Handles local storage for offline mode.  
- **Caching**: Improves performance by reducing data-fetching overhead.  

---

## Setup Instructions  

1. Clone the repository.  
2. Navigate to the project directory.  
3. Install dependencies by running:  
   ```bash
   flutter pub get
   ```  
4. Set up Firebase:  
   - Configure your Firebase project and add the necessary JSON/keys to the app.  
   - Modify the Firebase configuration in `firebase_auth.dart` and `firebase_functions.dart`.  

5. Run the app using:  
   ```bash
   flutter run
   ```  

---

## Usage  

- **Authentication**: Users can log in securely via Firebase Authentication.  
- **Data Management**: Retrieve and manage data in real-time with Firebase services.  
- **Offline Mode**: Leverages caching and shared preferences for offline usability.  

---

## Screenshots  

<p align="center">
  <img src="assets/images/app_logo.png" width="30%" />
</p>

---

## License  

This project is licensed under the MIT License.  
