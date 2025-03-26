# 📱 Codebase Project Assignment

A **Flutter-based application** that fetches user data from an API, supports **pagination**, **offline storage using Hive**, and **real-time internet connectivity detection using Bloc**.

---

## 🚀 Features

- **User List with Pagination** (Loads more users dynamically as you scroll)
- **State Management using Bloc (No `setState()`)**
- **Dependency Injection with GetIt**
- **API Calls using `http`**
- **Offline Storage with Hive**
- **Real-Time Internet Connectivity Check**
- **Optimized Performance with Clean Architecture**

---

## 🏠 Project Structure

```
lib/
│—— core/
│   ├—— platform/
│   │   ├—— network_info.dart       # Handles network connectivity check
│   ├—— service_locator.dart        # Dependency injection setup (GetIt)
│
│—— feature/user_list/
│   ├—— data/
│   │   ├—— models/                 # API response models
│   │   ├—— repositories/           # Repository implementation
│   │   ├—— data_sources/           # Remote and local data sources
│   │   ├—— services/               # Hive local storage service
│   │
│   ├—— domain/
│   │   ├—— entity/                 # Entity models for business logic
│   │   ├—— repositories/           # Repository contracts (abstract classes)
│   │   ├—— usecases/               # Use Cases (Business Logic Layer)
│   │
│   ├—— presentation/
│   │   ├—— bloc/                   # Bloc state management
│   │   ├—— screens/                # UI Screens
│   │   ├—— widgets/                # Reusable UI components
│
│—— main.dart                        # App entry point
```

---

## 📺 Setup & Installation

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/sumitsg/codebase_project_assignment.git
cd codebase_project_assignment
```

### **2️⃣ Install Dependencies**
```sh
flutter pub get
```

### **3️⃣ Setup Hive for Local Storage**
Run the following command to generate `.g.dart` files for Hive models:
```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

### **4️⃣ Run the App**
```sh
flutter run
```

---

## 📡 Internet Connectivity Handling

- **`NetworkInfoImpl`** checks if the device is connected to the internet.
- **`ConnectivityBloc`** listens for **network type changes** (WiFi, Mobile, None).
- **`InternetConnectionChecker`** verifies if the internet is actually available.

### **How it Works:**
1. If **online**, fetch data from API.
2. If **offline**, fetch cached data from **Hive**.
3. Show real-time status updates using **SnackBars**.

---

## 📚 State Management (Bloc)

The app follows the **Bloc architecture**:
- **Event-Driven State Updates**  
- **No `setState()`, Fully Reactive UI**  
- **Handles API calls, pagination, and connectivity changes inside Bloc**  

### **Bloc Flow Example**
```plaintext
UserEvent → UserBloc → Repository → API / Hive → Emit UserState → UI Updates
```

---

## ✨ Key Features Implemented

✅ **Bloc for State Management (No `setState()`)**  
✅ **Hive for Offline Storage (No Internet? No Problem!)**  
✅ **GetIt for Dependency Injection (Easy to Scale)**  
✅ **Real-Time Internet Detection (Auto UI Update)**  
✅ **Efficient API Calls with Pagination**  
✅ **Optimized Performance**  

## ✨ Watch video
[[click here]](https://drive.google.com/file/d/13_O_AYqwiz0ClgfZRKPBP-CmYRadMoT8/view?usp=drive_link)
