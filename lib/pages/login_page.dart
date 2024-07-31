import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'main_page.dart';
import '../services/firebase_auth.dart';
import '../screens/profile.dart'; // Импортируем ProfilePage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isRegistration = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorMessage;

  final AuthService _authService = AuthService();

  void _showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  void _clearError() {
    setState(() {
      _errorMessage = null;
    });
  }

  Future<void> _handleSubmit() async {
    _clearError();
    if (_formKey.currentState!.validate()) {
      if (_isRegistration) {
        try {
          await _authService.registerWithEmailAndPassword(
              _emailController.text, _passwordController.text);
          await _authService.sendEmailVerification();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        } on FirebaseAuthException catch (e) {
          _showError(e.message ?? 'Ошибка регистрации');
        }
      } else {
        try {
          UserCredential? userCredential =
              await _authService.signInWithEmailAndPassword(
                  _emailController.text, _passwordController.text);
          if (userCredential != null && !userCredential.user!.emailVerified) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
        } on FirebaseAuthException catch (e) {
          _showError(e.message ?? 'Ошибка входа');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isRegistration
                ? [
                    DoDidDoneTheme.lightTheme.colorScheme.primary,
                    DoDidDoneTheme.lightTheme.colorScheme.secondary,
                  ]
                : [
                    DoDidDoneTheme.lightTheme.colorScheme.secondary,
                    DoDidDoneTheme.lightTheme.colorScheme.primary,
                  ],
            stops: const [0.1, 0.9],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/log0_pg.png', height: 100, width: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Personal.Guide',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'do',
                          style: TextStyle(
                            color:
                                DoDidDoneTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                        const TextSpan(
                          text: '-did-',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'done',
                          style: TextStyle(
                            color:
                                DoDidDoneTheme.lightTheme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                  ],
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Почта',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите логин';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Пароль',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Пароль должен быть не менее 6 символов';
                      }
                      return null;
                    },
                  ),
                  if (_isRegistration) ...[
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Повторить пароль',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, повторите пароль';
                        }
                        if (value != _passwordController.text) {
                          return 'Пароли не совпадают';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      _isRegistration ? 'Зарегистрироваться' : 'Войти',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isRegistration = !_isRegistration;
                      });
                    },
                    child: Text(
                      _isRegistration
                          ? 'У меня уже есть аккаунт'
                          : 'У меня еще нет аккаунта',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
