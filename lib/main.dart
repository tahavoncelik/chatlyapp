import 'package:chatlyapp/bloc/auth_bloc.dart';
import 'package:chatlyapp/pages/auth_page.dart';
import 'package:chatlyapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => AuthService(),
        child: BlocProvider(create: (context) => AuthBloc(authService: AuthService()),
        child: const AuthPage()),
      ),
    );
  }
}
