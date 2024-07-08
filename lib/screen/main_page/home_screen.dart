import 'package:default_screen/modules/app_bar.dart';
import 'package:default_screen/modules/elevated_button.dart';
import 'package:default_screen/modules/navigator_push.dart';
import 'package:default_screen/screen/login&sign_up/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: xAppBar(title: 'HomeScreen'),
      body: Column(
        children: [
          xElevatedButton(
            onPressed: () async {
              _prefs = await SharedPreferences.getInstance();

              if (context.mounted) xPushReplace(context, const LoginScreen());

              // shared 로그인 데이터 초기화
              List<String> keysToRemove = ['password', 'kakao', 'apple', 'google', 'easyLogin', 'userId', 'device', 'ip', 'location'];

              for (String key in keysToRemove) {
                if (_prefs.containsKey(key)) {
                  await _prefs.remove(key);
                }
              }
            },
            text: '로그아웃',
          ),
        ],
      ),
    );
  }
}
