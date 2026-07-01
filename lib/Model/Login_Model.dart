class LoginModel {
  final String usernameHint;
  final String passwordHint;
  final String signInText;
  final String forgotPasswordText;
  final String accountPromptText;
  final String createAccountText;
  final String backgroundImageAsset;
  final String logoImageAsset;
  final List<String> socialAssetPaths;
  final String errorMessage;

  const LoginModel({
    this.usernameHint = 'Username',
    this.passwordHint = 'Password',
    this.signInText = 'Sign In',
    this.forgotPasswordText = 'Forgot Password?',
    this.accountPromptText = 'Need an Account? ',
    this.createAccountText = 'Create one here.',
    this.backgroundImageAsset = 'assets/KamcaKats.png',
    this.logoImageAsset = 'assets/KamcaLogo.png',
    this.socialAssetPaths = const [
      'assets/KamcaApple.png',
      'assets/KamcaGmail.png',
      'assets/KamcaInstagram.png',
      'assets/KamcaWhatsapp.png',
    ],
    this.errorMessage = 'The username or password is incorrect.',
  });
}

class LoginUser {
  final int id;
  final String username;
  final String password;
  final String name;
  final String? profileImageAsset;

  const LoginUser({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    this.profileImageAsset,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    final parsedId = json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0;
    final parsedUsername = json['username']?.toString() ?? '';

    return LoginUser(
      id: parsedId,
      username: parsedUsername,
      password: json['password']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      profileImageAsset: _resolveProfileImageAsset(
        id: parsedId,
        username: parsedUsername,
      ),
    );
  }

  static String? _resolveProfileImageAsset({required int id, required String username}) {
    if (id == 1 || username.toLowerCase() == 'galinda') {
      return 'assets/arianagrande.webp';
    }
    return null;
  }
}

enum LoginField { username, password }

class LoginResult {
  final bool isSuccess;
  final String message;
  final LoginUser? user;
  final List<LoginField> emptyFields;

  const LoginResult({
    required this.isSuccess,
    required this.message,
    this.user,
    this.emptyFields = const [],
  });
}
