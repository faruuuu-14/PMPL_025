import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/data_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  // Memastikan binding Flutter terinisialisasi sebelum Firebase Core
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase Core menggunakan konfigurasi platform
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase.initializeApp warning/error: $e');
  }

  // Bypass verifikasi reCAPTCHA emulator sesuai modul praktikum
  try {
    FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  } catch (e) {
    debugPrint('FirebaseAuth setSettings: $e');
  }

  final authProvider = AuthProvider();

  // Pola authStateChanges() -> AuthProvider.setUser() untuk perpindahan layar otomatis
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    authProvider.setUser(user);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 04 - Firebase Authentication',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Auth Gating: otomatis berpindah antara LoginScreen dan HomeScreen secara reaktif
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
