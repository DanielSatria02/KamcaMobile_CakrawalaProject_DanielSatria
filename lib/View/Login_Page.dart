
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kamca_app/Controller/Notification_controller.dart';
import 'package:kamca_app/Controller/Login_controller.dart';
import 'package:kamca_app/Model/Login_Model.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/Home_Page.dart';

class KamcaBackgroundScreen extends StatefulWidget {
  const KamcaBackgroundScreen({
    super.key,
    this.notificationController,
  });

  final AppNotificationController? notificationController;

  @override
  State<KamcaBackgroundScreen> createState() => _KamcaBackgroundScreenState();
}

class _KamcaBackgroundScreenState extends State<KamcaBackgroundScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final LoginController _loginController = LoginController();
  final LoginModel _loginModel = const LoginModel();
  late final AppNotificationController _notificationController;

  bool _isLoading = false;
  bool _showUsernameError = false;
  bool _showPasswordError = false;
  String? _feedbackMessage;

  @override
  void initState() {
    super.initState();
    _notificationController = widget.notificationController ?? AppNotificationController.shared;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (_isLoading) return;

    setState(() {
      _showUsernameError = false;
      _showPasswordError = false;
      _feedbackMessage = null;
      _isLoading = true;
    });

    final result = await _loginController.login(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (!result.isSuccess) {
      setState(() {
        _isLoading = false;
        _showUsernameError = result.emptyFields.contains(LoginField.username);
        _showPasswordError = result.emptyFields.contains(LoginField.password);
        _feedbackMessage = result.message;
      });
      return;
    }

    setState(() {
      _isLoading = false;
      _feedbackMessage = 'Welcome ${result.user?.name ?? ''}!';
    });

    await KamcaSessionStore.instance.saveUser(
      userName: result.user?.name ?? 'User',
      profileImageAsset: result.user?.profileImageAsset,
    );

    unawaited(
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 120));
    await _notificationController.showLoginSuccess();
  }

  void _focusPasswordField() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  TextDecoration? get contentPadding => null;

  Widget socialIcon(String assetPath, {double size = 48}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rectangleWidth = size.width * 0.8;
    final rectangleHeight = size.height * 0.5;
    final inputFontSize = 10.0;
    final buttonFontSize = 10.0;
    final loginModel = _loginModel;

    return Scaffold(
      body: Stack(
        children: [
          // background image fills the screen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(loginModel.backgroundImageAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // main centered column (logo + blurred panel)
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          loginModel.logoImageAsset,
                          width: rectangleWidth * 0.5,
                          height: rectangleHeight * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: size.width * 1,
                        height: size.height * 0.55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 126, 145, 134).withOpacity(0.02),
                              const Color.fromARGB(255, 169, 193, 184).withOpacity(0.02),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: rectangleHeight * 0.069,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 34, 60, 42).withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.35),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.20),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: SizedBox(
                                        width: rectangleWidth * 1,
                                        height: 35,
                                        child: TextField(
                                          controller: _usernameController,
                                          textInputAction: TextInputAction.next,
                                          onSubmitted: (_) => _focusPasswordField(),
                                          style: TextStyle(color: const Color.fromARGB(255, 93, 93, 93), fontSize: inputFontSize),
                                          decoration: InputDecoration(
                                            hintText: loginModel.usernameHint,
                                            hintStyle: TextStyle(color: const Color.fromARGB(179, 82, 82, 82), fontSize: inputFontSize),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.7),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: _showUsernameError ? const Color.fromARGB(255, 246, 183, 179) : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: _showUsernameError ? const Color.fromARGB(255, 234, 179, 175) : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.4),
                                            blurRadius: 16,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: SizedBox(
                                        width: rectangleWidth * 1,
                                        height: 35,
                                        child: TextField(
                                          controller: _passwordController,
                                          focusNode: _passwordFocusNode,
                                          obscureText: true,
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) => _submitLogin(),
                                          style: TextStyle(color: const Color.fromARGB(255, 93, 93, 93), fontSize: inputFontSize),
                                          decoration: InputDecoration(
                                            hintText: loginModel.passwordHint,
                                            hintStyle: TextStyle(color: const Color.fromARGB(179, 88, 88, 88), fontSize: inputFontSize),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.7),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: _showPasswordError ? const Color.fromARGB(255, 238, 162, 157) : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: _showPasswordError ? const Color.fromARGB(255, 231, 165, 160) : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: rectangleWidth * 0.85,
                                      height: 25,
                                      child: ElevatedButton(
                                        onPressed: _isLoading ? null : _submitLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 220, 192, 187),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          textStyle: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w600),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: CircularProgressIndicator(strokeWidth: 2),
                                              )
                                            : Text(
                                                loginModel.signInText,
                                                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (_feedbackMessage != null)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          _feedbackMessage!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _feedbackMessage!.contains('Welcome') ? Colors.greenAccent : Colors.redAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: handle forgot password tap
                                      },
                                      child: Text(
                                        loginModel.forgotPasswordText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 1.0,
                                            width: rectangleWidth * 0.4,
                                            color: const Color.fromARGB(179, 255, 255, 255),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Or',
                                            style: TextStyle(
                                              color: Color.fromARGB(179, 255, 255, 255),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            height: 1.0,
                                            width: rectangleWidth * 0.4,
                                            color: const Color.fromARGB(179, 255, 255, 255),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 23,
                                      runSpacing: 12,
                                      children: [
                                        socialIcon(loginModel.socialAssetPaths[0], size: 50),
                                        socialIcon(loginModel.socialAssetPaths[1], size: 50),
                                        socialIcon(loginModel.socialAssetPaths[2], size: 50),
                                        socialIcon(loginModel.socialAssetPaths[3], size: 50),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // pinned bottom bar: always touch the bottom of the screen
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: size.width * 1,
              height: size.height * 0.06,
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 7),
                    width: size.width * 1,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 34, 60, 42).withOpacity(0.3),
                      border: Border.all(color: Colors.white.withOpacity(0.28), width: 1.2),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: loginModel.accountPromptText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: loginModel.createAccountText,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 187, 239, 211),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}