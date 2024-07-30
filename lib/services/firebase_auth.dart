import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Объект для работы с Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Объект для работы с Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Получение текущего пользователя
  User? get user => _auth.currentUser;

  // Метод для входа с помощью email и пароля
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Вход в Firebase с помощью email и пароля
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('Ошибка входа: ${e.toString()}');
      return null;
    }
  }

  // Метод для регистрации с помощью email и пароля
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Регистрация в Firebase с помощью email и пароля
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('Ошибка регистрации: ${e.toString()}');
      return null;
    }
  }

  // Метод для отправки запроса подтверждения почты
  Future<void> sendEmailVerification() async {
    // Получение текущего пользователя
    final user = _auth.currentUser;

    // Отправка запроса подтверждения почты
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Метод для выхода из системы
  Future<void> signOut() async {
    // Выход из Firebase
    await _auth.signOut();

    // Выход из Google
    await _googleSignIn.signOut();
  }
}
