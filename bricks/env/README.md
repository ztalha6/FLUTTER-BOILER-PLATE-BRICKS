# ⚡ Basic Setup

A brick to create the basic structure for controlling the environments of your any Dart and Flutter Project.

All you have to do set the current Environment variable in your main.dart file.

## 💫 Features
This brick will create following modules for you:

- Environment
    - env model file
    - all envrionments file
## How to use 🚀

```
mason make env
```

## Variables ✨

| Variable         | Description                      | Default | Type      |
| ---------------- | -------------------------------- | ------- | --------- |
| `baseUrl`        | The base URL you want to         |   -     | `string`  |
|                  | keep for your API                |         |           |
|                  | (http://yourWebsite.com/api/)    |         |           |

## Outputs 📦

```
env
├── env.dart 
├── envs.dart 

```

```dart

import 'envs.dart';

class Env {
  final String label;
  final EnvUser? user;
  final String baseUrl;
  final bool prefillForms;

  const Env(
    this.label,
    this.user,
    this.baseUrl,
    this.prefillForms,
  );

  static Env currentEnv = Envs.DevEnv;
}

class EnvUser {
  final String email;
  final String password;

  const EnvUser(this.email, this.password);
}

```