# ⚡ Basic Setup

A brick to create the Token manager for the API token saving. Used when we need to pass the token in API headers.

## 💫 Features
This brick will create following modules for you:

- Services
    - api token manager


## How to use 🚀

```
mason make token_manager
```

## Outputs 📦

```

services
├── token_manager.dart

```

```dart

class TokenManager {
  late final SharedPreferences sharedPreferences;
  final String jwtTokenKey = 'jwtTokenKey';

  Future<String> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(jwtTokenKey)) {
      return sharedPreferences.getString(jwtTokenKey)!;
    } else {
      return '';
    }
  }

  Future<bool> setToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (token.isEmpty) {
      return false;
    }
    return await sharedPreferences.setString(jwtTokenKey, token);
  }
}

```