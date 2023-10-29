# ⚡ Basic Setup

A brick to create the basic structure for the API Integration and Beta setup foran application. This brick will create a massive structure on your directory and genrates some ready to use code.

All you have to do is to call the mehtods in controllers and do business logic stuff.

## 💫 Features

This brick will create following modules for you:

- Constants
  - api constants file
  - assets constants file
- Environment
  - env model file
  - all envrionments file
- Model
  - Repository model file
  - API response model file
- Repository
  - Sample auth repository file
- Services
  - api service
    - sample auth service file
  - Dio service
    - api interceptor
    - dio builder
  - exception handler
  - snackbar manager
  - api token manager
- Utils
  - image utils
  - general utils
- widgets
  base widget (with predefined ThemeData)

## How to use 🚀

```
mason make basic_setup
```

## Variables ✨

| Variable        | Description                   | Default | Type      |
| --------------- | ----------------------------- | ------- | --------- |
| `using_snakbar` | If you are using snackbar     | true    | `boolean` |
|                 | from this mason_cli           |         |           |
| `baseUrl`       | The base URL you want to      | -       | `string`  |
|                 | keep for your API             |         |           |
|                 | (http://yourWebsite.com/api/) |         |           |

## Outputs 📦

```
constants
├── api_constants.dart
├── assets_constants.dart

env
├── env.dart
├── envs.dart

models
├── repository_response_model.dart
├── response_model.dart

repositories
├── auth_repository.dart

services
├── api_service
    ├── auth_service.dart
├── dio_service
    ├── api_interceptor.dart
    ├── dio_builder.dart
├── exception_handler.dart
├── snackbar_manager.dart
├── token_manager.dart

utils
├── image_utils.dart
├── utils.dart

widgets
├── base_widget.dart

```

## Dependencies

This setup is dependent on the following packages. You always add or remove as per your requirements. To avoid any error in code copy the following dependencies and add it in your pubspec.yaml file.

```dart

  cached_network_image: ^3.3.0
  carousel_slider: ^4.2.1
  cupertino_icons: ^1.0.2
  dio: ^5.3.3
  dio_cache_interceptor: ^3.4.4
  dropdown_button2: ^1.7.2
  flutter:
    sdk: flutter
  flutter_facebook_auth: ^6.0.2
  flutter_staggered_animations: ^1.1.1
  get: 4.6.5
  google_fonts: ^6.1.0
  google_sign_in: ^6.1.5
  image_cropper: ^5.0.0
  image_picker: ^1.0.4
  intl: ^0.18.1
  intl_phone_number_input: ^0.7.3+1
  package_info_plus: ^4.2.0
  pin_code_fields: ^8.0.1
  pull_to_refresh: ^2.0.0
  shared_preferences: ^2.2.2
  shimmer: ^3.0.0
  sign_in_with_apple: ^5.0.0
  sizer: ^2.0.15
  video_player: ^2.7.2


```
