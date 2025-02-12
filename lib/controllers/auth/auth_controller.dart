import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:kedasrd_windows/models/user_model.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  final _isLoggedIn = false.obs;
  final _currentUser = Rx<User?>(null);

  static AuthController get to => Get.find();
  bool get isLoggedIn => _isLoggedIn.value;
  User? get currentUser => _currentUser.value;
  bool get isAdmin => currentUser?.role == 'admin';

  // Predefined users
  final Map<String, User> _users = {
    'admin@gmail.com': User(
      email: 'admin@gmail.com',
      password: 'admin',
      role: 'admin',
      name: 'Admin User',
    ),
    'other@gmail.com': User(
      email: 'other@gmail.com',
      password: 'other',
      role: 'user',
      name: 'Normal User',
    ),
  };

  @override
  void onInit() {
    super.onInit();
    // Check stored login state on app start
    _loadStoredUser();
  }

  void _loadStoredUser() {
    try {
      final userData = storage.read('user');
      if (userData != null) {
        _currentUser.value = User.fromJson(userData);
        _isLoggedIn.value = true;
      }
    } catch (e) {
      storage.remove('user');
      _isLoggedIn.value = false;
    }
  }

  Future<bool> login(String email, String password) async {
    final user = _users[email];
    if (user != null && user.password == password) {
      // Store both user data and login state
      await storage.write('user', user.toJson());
      await storage.write('isLoggedIn', true);

      _currentUser.value = user;
      _isLoggedIn.value = true;
      await Get.offAllNamed("landing");
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    // Clear both user data and login state
    await storage.remove('user');
    await storage.remove('isLoggedIn');

    _currentUser.value = null;
    _isLoggedIn.value = false;
    await Get.offAllNamed("signin");
  }

  // Check login state
  bool checkLoginStatus() {
    return storage.read('isLoggedIn') ?? false;
  }
}
