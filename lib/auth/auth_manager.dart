class AuthManager {
  static bool isLoggedIn = false;

  // Singleton pattern to access the instance of AuthManager
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }

  void login() {
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }

  AuthManager._internal();
}
