import 'package:default_screen/screen/login&sign_up/login_screen.dart';
import 'package:default_screen/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String testId = 'test@test.com';
const String testPw = '1234';
RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
RegExp pwRegex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-1])(?=.*?[!@#\$&*~]).{6,20}$');
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
