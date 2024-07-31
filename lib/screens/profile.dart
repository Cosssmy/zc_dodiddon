import 'package:flutter/material.dart';
import 'package:zc_dodiddon/theme/theme.dart';
import '../services/firebase_auth.dart';
import '../pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = _authService.user;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DoDidDoneTheme.lightTheme.colorScheme.primary,
            DoDidDoneTheme.lightTheme.colorScheme.secondary,
          ],
        ),
      ),
      child: Center(
        // Добавляем Center для вертикального центрирования
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment
                  .center, // Убираем лишний MainAxisAlignment.center
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!) as ImageProvider
                      : const AssetImage('assets/avatar.jpg'),
                ),
                const SizedBox(height: 20),
                Text(
                  user?.email ?? 'example@email.com',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (user != null && !user.emailVerified)
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.sendEmailVerification();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Подтверждение почты'),
                          content: const Text(
                              'Письмо с подтверждением отправлено на ваш адрес.'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await _authService.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Подтвердить почту'),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _authService.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
