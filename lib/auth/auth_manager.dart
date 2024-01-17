class AuthManager {
  static bool isLoggedIn = false;
  static String username = "";
  static String name = "";

  // Singleton pattern to access the instance of AuthManager
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }

  void setUsername(String username) {
    username = username;
  }

  void setName(String name) {
    name = name;
  }

  static String getName () {
    return name;
  }

  static String getUsername () {
    return username;
  }

  void login() {
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }

  AuthManager._internal();
}
