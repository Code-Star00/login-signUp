import 'package:default_screen/component/dialog_component.dart';
import 'package:default_screen/main.dart';
import 'package:default_screen/modules/app_bar.dart';
import 'package:default_screen/modules/elevated_button.dart';
import 'package:default_screen/modules/text.dart';
import 'package:default_screen/modules/unfocus_gesture.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _pwController = TextEditingController();
  late final TextEditingController _pwCheckController = TextEditingController();
  late final TextEditingController _nickController = TextEditingController();

  late final FocusNode _emailFocus = FocusNode();
  late final FocusNode _pwFocus = FocusNode();
  late final FocusNode _pwCheckFocus = FocusNode();
  late final FocusNode _nickFocus = FocusNode();

  String? emailChk, pwChk, pwCheckChk, nickChk;
  late bool pwBool = false, pw2Bool = false;

  _signUp() async {
    String email = _emailController.text;
    String pw = _pwController.text;
    String pwCheck = _pwCheckController.text;
    String nick = _nickController.text;

    if (email == '') {
      await showFailDialog('아이디를 입력해 주세요.');
      return;
    } else if (pw == '') {
      await showFailDialog('비밀번호를 입력해 주세요.');
      return;
    } else if (pwCheck == '') {
      await showFailDialog('비밀번호 확인을 입력해 주세요.');
      return;
    } else if (nick == '') {
      await showFailDialog('닉네임을 입력해 주세요.');
      return;
    }

    if (!emailRegex.hasMatch(_emailController.text)) {
      await showFailDialog('아이디가 이메일 형식이 아닙니다.');
      return;
      // } else if (emailChk != null && emailChk != '사용 가능한 아이디입니다.') {
    } else if (_emailController.text.trim() == testId) {
      await showFailDialog('중복된 아이디입니다.');
      return;
    } else if (!pwRegex.hasMatch(_pwController.text)) {
      await showFailDialog('비밀번호 형식에 맞게 입력해 주세요.');
      return;
    } else if (_pwController.text != _pwCheckController.text) {
      await showFailDialog('비밀번호가 일치하지 않습니다.');
      return;
    }

    await showFailDialog('회원가입 성공');
  }

  @override
  Widget build(BuildContext context) {
    return unFocus(
      context: context,
      child: Scaffold(
        appBar: xAppBar(title: '회원가입'),
        body: Column(
          children: [
            _textfield(
              '아이디',
              _emailController,
              _emailFocus,
              () {
                setState(() {
                  if (_emailController.text.trim().isEmpty) {
                    emailChk = '아이디를 입력해 주세요.';
                    return;
                  }
                  if (!emailRegex.hasMatch(_emailController.text)) {
                    emailChk = '아이디가 이메일 형식이 아닙니다.';
                    return;
                  }
                  // 중복체크 서버 API 통신
                  if (_emailController.text == testId) {
                    emailChk = '중복된 아이디입니다.';
                  } else {
                    emailChk = '사용 가능한 아이디입니다.';
                  }
                });
              },
              textInputType: TextInputType.emailAddress,
            ),
            if (emailChk != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: xText(
                    emailChk!,
                    13,
                    color: emailChk == '사용 가능한 아이디입니다.' ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
            _textfield(
              '비밀번호',
              _pwController,
              _pwFocus,
              () {
                setState(() {
                  if (_pwController.text.trim().isEmpty) {
                    pwChk = '비밀번호를 입력해 주세요.';
                    return;
                  }
                  if (!pwRegex.hasMatch(_pwController.text)) {
                    pwChk = '영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 6~20자로 입력해 주세요';
                    if (_pwController.text == _pwCheckController.text) {
                      pwCheckChk = null;
                    } else {
                      pwCheckChk = '비밀번호가 일치하지 않습니다.';
                    }
                    return;
                  } else if (_pwCheckController.text.trim().isNotEmpty && _pwController.text != _pwCheckController.text) {
                    pwChk = null;
                    pwCheckChk = '비밀번호가 일치하지 않습니다.';
                  } else {
                    pwChk = null;
                    pwCheckChk = null;
                    return;
                  }
                });
              },
            ),
            if (pwChk != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: xText(
                    pwChk!,
                    13,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            _textfield(
              '비밀번호 확인',
              _pwCheckController,
              _pwCheckFocus,
              () {
                setState(() {
                  if (_pwCheckController.text.trim().isEmpty) {
                    pwCheckChk = '비밀번호 확인을 입력해 주세요.';
                    return;
                  }

                  if (_pwController.text != _pwCheckController.text) {
                    pwCheckChk = '비밀번호가 일치하지 않습니다.';
                  } else {
                    pwCheckChk = null;
                    if (_pwController.text.trim().isEmpty) {
                      pwChk = '비밀번호를 입력해 주세요.';
                    } else if (!pwRegex.hasMatch(_pwController.text)) {
                      pwChk = '영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 6~20자로 입력해 주세요';
                    } else {
                      pwChk = null;
                    }
                  }
                });
              },
            ),
            if (pwCheckChk != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: xText(
                    pwCheckChk!,
                    13,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            _textfield(
              '닉네임',
              _nickController,
              _nickFocus,
              () {},
            ),
            if (nickChk == '닉네임을 입력해 주세요') ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: xText(
                    nickChk!,
                    13,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            xElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 32, 42),
              ),
              text: '회원가입',
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
        '회원가입 실패',
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
          if (content == '회원가입 성공') {
            Navigator.pop(context);
          } else {
            if (content.contains('아이디')) {
              FocusScope.of(context).requestFocus(_emailFocus);
            } else if (content.contains('비밀번호 확인을') || content.contains('비밀번호가 일치하지 않습니다.')) {
              FocusScope.of(context).requestFocus(_pwCheckFocus);
            } else if (content.contains('비밀번호')) {
              FocusScope.of(context).requestFocus(_pwFocus);
            } else if (content.contains('닉네임')) {
              FocusScope.of(context).requestFocus(_nickFocus);
            }
          }
        },
        '확인',
        Colors.blue
      ],
      [],
    );
  }

  Widget _textfield(
    String hintText,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onChanged, {
    TextInputType textInputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) => onChanged(),
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(179, 179, 179, 1),
          ),
          hintMaxLines: 3,
        ),
      ),
    );
  }
}
