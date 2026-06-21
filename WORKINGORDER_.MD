NOW WE ARE CONNECTING THE AUTH BLOC



dependecny injection-getit help in dependecny injection in which we can diectly pass
 the dependecies
//this is knows as registering dependency

//next thing is to store user data to database
//foreign key id connects auth.user with profiles this key connects two differtn tables foreign key it is two table connector

//ORDER OF WORK


//NOW OUR LOGIN AND SIGNUP IS OVER WE WILL JUMP TO THE SOME OTHER CLEAN ARCH TECHNIQUE
--THREE LAYERS PRESENT DOMAIN data
WE CREATED PAGES FOLDER WITH LOGIN AND SIGNIN PAGE 
WIDGETS AUTH FIEDLA ND AUTH GRADIENT 
BLOC LAYER - AUTH BLCO REQUIRED AUTH EVENT AUTH SATE WHIC CH DIRECTLY COMMUNICATES WITH USECASES 
USER SIGNUP AND USESINGN USECASE ARE IMPORTED IN BLOC LAYER 

AND WE ARE DIRECTLY ASKING AUTH REPO INTERFACE IN USERSINGUP USECASE 
IN DOMAIN LAYER WE HAVE ENTITIES WHICH HAVE USER CLASS BASE CLASS FOR MODEL IN DATA LAYER
IT HAS PROPS OF USER AND THIS CLASS SO EASY AND HTIS CLASS IS NOT TESTED AS IT AHS NO LOGIC IN IT

THE REPO IS ALSO IS IN DATA LAYER THAT  IS ITS ACTUAL IMPELEMNTATION  AND DOMAIN LAYER DOEST NOT DEPEND ON DATA LAYER SO IT IS ALSO PRESETN IN DOMAIN LAYER
// DOAMAIN IS HIGHER AND DATA IS LOWER AND THEY SHOULD BE INDEPENDENT THATWHAY BOTH OF THEM HVA REPOSITORY
//YOU SOULD ALWAYS DEPEND ON ABSTRACTION IN CLEAN ARCHITECTURE
AUTH REMOTE DATA SOURCE GIVES RAW DATA FORM SUPANASE TO US IS CONVERTED TO USEMODEL WITH FROMJSON FUNCTION 
// INDEPENDENT LAYERS IS MUST 




 USE CASES-FOLLOW OPENCLOSE SINGLE REPOSIBLILITY IT HAS ONLY ON RESPOSISBITLY 
 AS THIS CLASS IS OPEN FOR EXTENDION BUT CLOSSE FOR MODIFICATION SO IT FOLLOW THIS PRICNOITPLE
 dependency INVERSION IS ALSO USED IN THIS APP









# 📝 Blog App - Flutter Clean Architecture

A modern Flutter Blog Application built using **Clean Architecture**, **BLoC State Management**, **Supabase Backend**, **GetIt Dependency Injection**, and **Hive Local Storage**.

This project was created to learn and implement industry-standard Flutter architecture patterns that are commonly used in real-world applications and technical interviews.

---

# 🚀 Features

### Authentication

* User Sign Up
* User Login
* Secure Authentication using Supabase Auth
* Persistent User Sessions

### Blog Features

* Create Blog Posts
* View Blogs
* Read Blog Details
* Store Blog Information in Supabase
* User-wise Blog Management

### State Management

* BLoC Architecture
* Event Driven State Changes
* Reactive UI Updates

### Local Storage

* Hive Database
* Offline Data Caching
* Faster App Performance

---

# 🏗️ Architecture

The project follows **Clean Architecture**.

```text
lib/
│
├── core/
│
├── features/
│   │
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── blog/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── init_dependencies.dart
```

The architecture is divided into three independent layers:

## 1. Presentation Layer

Responsible for:

* UI Screens
* Widgets
* BLoC
* User Interaction

Contains:

```text
pages/
widgets/
bloc/
```

Flow:

```text
UI
 ↓
Bloc Event
 ↓
Bloc State
 ↓
UI Update
```

---

## 2. Domain Layer

The most important layer of the application.

Contains:

```text
entities/
repositories/
usecases/
```

Responsibilities:

* Business Logic
* Use Cases
* Repository Contracts

The Domain Layer never depends on Data Layer.

It only depends on abstractions.

Example:

```dart
abstract interface class AuthRepository
```

---

## 3. Data Layer

Responsible for:

```text
datasources/
models/
repositories/
```

Responsibilities:

* API Calls
* Supabase Communication
* Data Parsing
* Repository Implementations

Flow:

```text
Supabase
 ↓
Raw JSON
 ↓
Model
 ↓
Entity
```

---

# 🔐 Authentication Flow

Authentication is implemented using Supabase.

Flow:

```text
User
 ↓
Auth Page
 ↓
Auth Bloc
 ↓
Use Case
 ↓
Repository
 ↓
Remote Data Source
 ↓
Supabase Auth
 ↓
User Entity
 ↓
Success State
```

---

# 🗄️ Database Structure

Supabase Authentication Table:

```text
auth.users
```

Stores:

* User ID
* Email
* Password (Encrypted)

Profile Table:

```text
profiles
```

Stores:

* Name
* Email
* Profile Information

Relationship:

```text
auth.users.id
        │
        ▼
profiles.id
```

A Foreign Key connects both tables.

---

# 📦 Dependency Injection

The project uses **GetIt** for Dependency Injection.

Benefits:

* Loose Coupling
* Easy Testing
* Better Scalability
* Cleaner Code

Example:

```dart
final sl = GetIt.instance;
```

All repositories, use cases, blocs and datasources are registered once and injected throughout the app.

---

# 🧠 State Management

The application uses **flutter_bloc**.

Files:

```text
auth_bloc.dart
auth_event.dart
auth_state.dart
```

Example Flow:

```text
Button Click
 ↓
Event Added
 ↓
Bloc Processes Event
 ↓
State Emitted
 ↓
UI Rebuilds
```

---

# 📚 SOLID Principles Used

## Single Responsibility Principle (SRP)

Every class has one responsibility.

Examples:

* UserSignUp
* UserLogin
* AuthBloc
* AuthRemoteDataSource

---

## Open Closed Principle (OCP)

Classes are:

```text
Open for Extension
Closed for Modification
```

New features can be added without modifying existing business logic.

---

## Dependency Inversion Principle (DIP)

High-level modules depend on abstractions instead of implementations.

Example:

```dart
UserSignUp
    ↓
AuthRepository
    ↑
AuthRepositoryImpl
```

---

# 🛠️ Tech Stack

### Frontend

* Flutter
* Dart

### State Management

* flutter_bloc

### Backend

* Supabase

### Dependency Injection

* GetIt

### Local Storage

* Hive

### Functional Programming

* FPdart

### Architecture

* Clean Architecture

---

# 📸 Screens

* Login Screen
* Sign Up Screen
* Blog Listing Screen
* Blog Details Screen
* Create Blog Screen

---

# 🎯 What I Learned

Through this project I gained practical experience with:

* Flutter Clean Architecture
* BLoC State Management
* Repository Pattern
* Dependency Injection
* Supabase Authentication
* Hive Local Storage
* SOLID Principles
* Scalable Project Structure
* Industry Standard Flutter Development

---

# 👨‍💻 Why This Project?

This project was built to understand how production-level Flutter applications are structured and to strengthen my understanding of architecture, state management, and backend integration.

It serves as a strong learning project and demonstrates skills commonly expected in Flutter internship and entry-level developer interviews.
