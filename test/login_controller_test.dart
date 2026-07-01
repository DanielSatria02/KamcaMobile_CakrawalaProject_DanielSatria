import 'package:flutter_test/flutter_test.dart';
import 'package:kamca_app/Controller/Login_controller.dart';
import 'package:kamca_app/Model/Login_Model.dart';

void main() {
  group('LoginController', () {
    test('accepts a valid username and password', () async {
      final controller = LoginController(
        users: [
          LoginUser(username: 'Galinda', password: 'Elph4ba', name: 'Glinda', id: 1),
        ],
      );

      final result = await controller.login(username: 'Galinda', password: 'Elph4ba');

      expect(result.isSuccess, isTrue);
      expect(result.user?.name, 'Glinda');
    });

    test('returns a validation error when the form is empty', () async {
      final controller = LoginController(
        users: [
          LoginUser(username: 'Galinda', password: 'Elph4ba', name: 'Glinda', id: 1),
        ],
      );

      final result = await controller.login(username: ' ', password: '');

      expect(result.isSuccess, isFalse);
      expect(result.message, 'Login form cannot be empty.');
      expect(result.emptyFields, contains(LoginField.username));
      expect(result.emptyFields, contains(LoginField.password));
    });

    test('rejects an incorrect password', () async {
      final controller = LoginController(
        users: [
          LoginUser(username: 'Galinda', password: 'Elph4ba', name: 'Glinda', id: 1),
        ],
      );

      final result = await controller.login(username: 'Galinda', password: 'wrong');

      expect(result.isSuccess, isFalse);
      expect(result.message, 'The username or password is incorrect.');
    });
  });
}
