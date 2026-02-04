# Vector Operations

A modern Flutter application for performing vector operations across multiple coordinate systems with an elegant dark-themed UI.

## Features

### 🎯 Core Functionality
- **Vector Management**: Add, store, and manage multiple vectors
- **Point Operations**: Work with points in 3D space
- **Vector Operations**: 
  - Vector Addition
  - Vector Subtraction
- **Multiple Coordinate Systems**:
  - Cartesian (x, y, z)
  - Cylindrical (r, θ, z)
  - Spherical (r, θ, φ)

### 🎨 Modern UI/UX
- Beautiful dark theme with Material Design 3
- Custom color scheme with purple accents (#BB86FC)
- Google Fonts integration (Outfit font family)
- Smooth animations and transitions
- Responsive design with modern card layouts

## Architecture

This application follows the **MVVM (Model-View-ViewModel)** architecture pattern with **Riverpod** for state management.

### Project Structure

```
lib/
├── main.dart                    # App entry point & theme configuration
├── models/                      # Data models
│   ├── coordinate_system.dart   # Coordinate system enum
│   ├── operation_state.dart     # Operation state management
│   ├── operation_type.dart      # Vector operation types
│   ├── point_model.dart         # Point data model
│   └── vector_model.dart        # Vector data model
├── services/                    # Business logic services
│   ├── coordinate_converter_service.dart
│   └── vector_operation_service.dart
├── viewmodels/                  # State management
│   ├── operation_view_model.dart
│   ├── points_view_model.dart
│   └── vectors_view_model.dart
├── views/                       # UI screens
│   ├── home_view.dart
│   ├── add_vector_view.dart
│   ├── add_points_view.dart
│   ├── operation_selection_view.dart
│   ├── vector_selection_view.dart
│   ├── point_selection_view.dart
│   └── calculation_view.dart
├── widgets/                     # Reusable UI components
│   ├── labeled_text_field.dart
│   ├── modern_card.dart
│   └── primary_button.dart
└── utils/                       # Utilities
    ├── app_router.dart
    ├── app_routes.dart
    └── format_utils.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/eslam-9/vectors_task.git
   cd vectors_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Dependencies

- **flutter_riverpod** (^2.5.1) - State management
- **vector_math** (^2.1.4) - Vector mathematics operations
- **google_fonts** (^6.2.0) - Custom typography

## Usage

1. **Launch the app** - Start from the home screen
2. **Add vectors** - Tap "Add New Vector" to create vectors in your preferred coordinate system
3. **Select operation** - Choose between addition or subtraction
4. **Select vectors** - Pick the vectors you want to operate on
5. **View results** - See the calculated result in all coordinate systems

## Color Scheme

The app uses a carefully crafted dark theme:
- **Primary**: #BB86FC (Purple)
- **Secondary**: #03DAC6 (Teal)
- **Background**: #121212 (Dark Gray)
- **Surface**: #1E1E1E (Slightly Lighter Gray)
- **Error**: #CF6679 (Red)


```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.


## Support

For issues, questions, or suggestions, please open an issue in the repository.

---

Built with ❤️ using Flutter
