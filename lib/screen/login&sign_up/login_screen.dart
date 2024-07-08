import 'package:default_screen/component/dialog_component.dart';
import 'package:default_screen/main.dart';
import 'package:default_screen/modules/app_bar.dart';
import 'package:default_screen/modules/elevated_button.dart';
import 'package:default_screen/modules/loading.dart';
import 'package:default_screen/modules/navigator_push.dart';
import 'package:default_screen/modules/sized_box.dart';
import 'package:default_screen/modules/text.dart';
import 'package:default_screen/modules/unfocus_gesture.dart';
import 'package:default_screen/screen/login&sign_up/sign_up_screen.dart';
import 'package:default_screen/screen/main_page/home_screen.dart';
import 'package:default_screen/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  late SharedPreferences _prefs;

  late final _vmr = context.read<LoginViewModel>();
  late final _vmw = context.watch<LoginViewModel>();

  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _pwController = TextEditingController();

  late final FocusNode _emailFocus = FocusNode();
  late final FocusNode _pwFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    init();

    /*
     initState에서 async await 키워드를 사용하면
     initState가 끝나기 전에 Widget build 메서드가 호출 되므로
     addPostFrameCallback 함수로 build가 끝나고 notifyListeners를 호출하여 필요 위젯을 다시 생성한다.

     *loading 변수를 사용해서 화면에 로딩을 걸어도 상관없음*
    */
    WidgetsBinding.instance.addPostFrameCallback((_) => _vmr.noti());
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();

    final String? storedPassword = _prefs.getString('password');
    final bool autoLogin = storedPassword != null;
    if (autoLogin) {
      if (mounted) xPushReplace(context, const HomeScreen());
      return;
    }
    final String? storedEmail = _prefs.getString('email');
    final bool isStoredEmail = storedEmail != null;

    _vmr.saveEmailChanged = (bool? value) {
      _vmr.isSaveEmail = value ?? false;
      _vmr.noti();
    };
    _vmr.setAutoLogin = (bool? isAutoLogin) {
      if (isAutoLogin!) {
        _vmr.isAutoLogin = true;
        _vmr.saveEmailChanged = null;
        _vmr.isSaveEmail = null;
      } else {
        _vmr.isAutoLogin = false;
        _vmr.saveEmailChanged = (bool? value) {
          _vmr.isSaveEmail = value ?? false;
          _vmr.noti();
        };
        _vmr.isSaveEmail = false;
      }
      _vmr.noti();
    };
    if (isStoredEmail) {
      _vmr.isSaveEmail = true;
      _emailController.text = storedEmail;
    } else {
      _vmr.isSaveEmail = false;
    }
  }

  // 로그인 함수
  _login() async {
    String email = _emailController.text;
    String pw = _pwController.text;

    if (email == '') {
      await showFailDialog('아이디를 입력해 주세요.');
      return;
    } else if (pw == '') {
      await showFailDialog('비밀번호를 입력해 주세요.');
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      await showFailDialog('아이디가 이메일 형식이 아닙니다.');
      return;
    }

    // 로그인 API 통신 부분
    if (email != testId) {
      await showFailDialog('아이디를 확인해 주세요.');
      return;
    } else if (pw != testPw) {
      await showFailDialog('비밀번호를 확인해 주세요.');
      return;
    }

    loading(context);

    Navigator.pop(context); // loading 종료

    // if (result == null) {
    //   await showFailDialog();
    //   return;
    // }

    /// 로그인 성공 -----------------------------------------------------
    if (_vmr.isAutoLogin) {
      await _prefs.setString('email', email);
      await _prefs.setString('password', pw);
    } else if (_vmr.isSaveEmail ?? false) {
      await _prefs.setString('email', email);
      await _prefs.remove('password');
    } else {
      await _prefs.remove('email');
      await _prefs.remove('password');
    }

    if (mounted) xPushReplace(context, const HomeScreen());

    /// 로그인 성공 -----------------------------------------------------
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _emailFocus.dispose();
    _pwFocus.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return unFocus(
      context: context,
      child: Scaffold(
        appBar: xAppBar(
          title: '로그인',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일 주소를 입력해 주세요';
                  } else {
                    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                    if (!emailRegex.hasMatch(value)) {
                      return '아이디가 이메일 형식이 아닙니다';
                    }
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: '아이디를 입력해 주세요',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _pwController,
                focusNode: _pwFocus,
                obscureText: _vmw.pwObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '올바른 비밀번호가 아닙니다';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력해 주세요',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      _vmr.pwObscure = !_vmr.pwObscure;
                      _vmr.noti();
                    },
                    child: Icon(
                      _vmw.pwObscure == true ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                16.w,
                GestureDetector(
                  onTap: () => _vmr.setAutoLogin(!_vmr.isAutoLogin),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: const Color(0xff4f47cc),
                        value: _vmw.isAutoLogin,
                        onChanged: _vmr.setAutoLogin,
                      ),
                      xText('자동 로그인', 12),
                    ],
                  ),
                ),
                10.w,
                GestureDetector(
                  onTap: _vmr.saveEmailChanged == null ? null : () => _vmr.saveEmailChanged!(!(_vmr.isSaveEmail ?? true)),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: const Color(0xff4f47cc),
                        value: _vmw.isSaveEmail,
                        onChanged: _vmr.saveEmailChanged,
                        tristate: true,
                      ),
                      xText(
                        '아이디 저장',
                        12,
                        color: _vmw.isAutoLogin ? Colors.grey : Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            xElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 32, 42),
              ),
              text: '로그인',
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: xElevatedButton(
                      onPressed: () {},
                      text: '아이디 찾기',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: xElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      text: '비밀번호 찾기',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: xElevatedButton(
                      onPressed: () {
                        xPush(context, const SignUpScreen());
                      },
                      text: '회원가입',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 로그인 실패 alert dialog 위젯
  showFailDialog(String content) {
    DialogComponent.dialogComponent(
      context,
      xText(
        '로그인 실패',
        17,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
      ),
      xText(
        content,
        14,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
      ),
      true,
      [
        () {
          Navigator.pop(context);
          if (content.contains('아이디')) {
            FocusScope.of(context).requestFocus(_emailFocus);
          } else {
            FocusScope.of(context).requestFocus(_pwFocus);
          }
        },
        '확인',
        Colors.blue
      ],
      [],
    );
  }
}
