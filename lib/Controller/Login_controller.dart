import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamca_app/Model/Login_Model.dart';

class LoginController {
  LoginController({List<LoginUser>? users, this.baseUrl = 'https://6a3be06ce4a07f202e161a85.mockapi.io/Users'})
      : _users = users ?? [];

  final String baseUrl;
  List<LoginUser> _users;

  Future<List<LoginUser>> fetchUsers() async {
    if (_users.isNotEmpty) {
      return _users;
    }

    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Unable to load users');
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    _users = decoded.map((item) => LoginUser.fromJson(item as Map<String, dynamic>)).toList();
    return _users;
  }

  Future<LoginResult> login({required String username, required String password}) async {
    final emptyFields = <LoginField>[];
    if (username.trim().isEmpty) {
      emptyFields.add(LoginField.username);
    }
    if (password.trim().isEmpty) {
      emptyFields.add(LoginField.password);
    }

    if (emptyFields.isNotEmpty) {
      return LoginResult(
        isSuccess: false,
        message: 'Login form cannot be empty.',
        emptyFields: emptyFields,
      );
    }

    final users = await fetchUsers();
    final matchedUser = users.firstWhere(
      (user) => user.username.toLowerCase() == username.trim().toLowerCase(),
      orElse: () => const LoginUser(id: 0, username: '', password: '', name: ''),
    );

    final isValid = matchedUser.id != 0 && matchedUser.password == password;

    if (isValid) {
      return LoginResult(
        isSuccess: true,
        message: 'Login successful',
        user: matchedUser,
      );
    }

    return LoginResult(
      isSuccess: false,
      message: 'The username or password is incorrect.',
    );
  }
}
