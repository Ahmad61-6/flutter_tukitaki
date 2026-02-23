import 'package:get/get.dart';

class MockBackend {
  static final List<Map<String, dynamic>> _usersDB = [
    {
      'username': 'testuser',
      'email': 'test@example.com',
      'password': 'password123',
    },
  ];

  static Future<Map<String, dynamic>> login(String emailOrUsername, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final user = _usersDB.firstWhereOrNull(
          (u) => (u['email'] == emailOrUsername || u['username'] == emailOrUsername) &&
          u['password'] == password,
    );

    if (user != null) {
      return {
        'isSuccess': true,
        'data': {
          'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
          'user': {
            'username': user['username'],
            'email': user['email'],
          }
        }
      };
    } else {

      return {
        'isSuccess': false,
        'msg': 'Invalid email/username or password.',
      };
    }
  }


  static Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    bool userExists = _usersDB.any((u) => u['username'] == username || u['email'] == email);
    if (userExists) {
      return {'isSuccess': false, 'msg': 'Username or Email already exists.'};
    }

    _usersDB.add({'username': username, 'email': email, 'password': password});

    return {
      'isSuccess': true,
      'msg': 'Signup successful!',
      'data': {
        'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': {
          'username': username,
          'email': email,
        }
      }
    };
  }}