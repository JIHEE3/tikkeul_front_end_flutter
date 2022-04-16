import 'package:flutter/material.dart';
import 'package:tikkeul/utils/render_text_form_field.dart';
import 'package:tikkeul/utils/validate.dart' as validate;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();

  void onSubmit() {}
}

class _SignUpState extends State<SignUp> {
  // 폼의 상태를 얻기 위한 키
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pw2Controller = TextEditingController();

  bool? _isIdExisted;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    // id로 공백 없이 소문자
    _idController.addListener(() {
      final String text = _idController.text.toLowerCase().trim();
      _idController.value = _idController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _pw2Controller.dispose();
    super.dispose();
  }

  void _idExistCheck(String val) {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      bool? data;
      if (val.isEmpty) {
        data = null;
      } else {
        data = await validate.isExistedId(val);
      }
      setState(() {
        _isIdExisted = data;
      });
    });
  }

  String? get _idErrorText {
    if (_isIdExisted == true) {
      return '존재하는 아이디 입니다.';
    }

    return null;
  }

  /**
   * 
   * 
   * 이메일도 중복체크하기 탈퇴회원 아닌사람으로 해가지고
   * 
   * 
   * 아이디도!!!
   * 
   * 
   * TextFormField 값 변경되면 값없다 등의 errorText 안나오게 하기!!
   * 
   * 
   * 
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          autovalidate: _submitted ? true : false,
          child: Column(
            children: [
              renderTextFormField(
                controller: _idController,
                label: 'ID',
                onSaved: (val) {},
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return '필수사항입니다.';
                  }
                  return null;
                },
                onChanged: _idExistCheck,
                decoration: InputDecoration(
                  errorText: _idErrorText,
                ),
              ),

              renderTextFormField(
                label: '비밀번호',
                onSaved: (val) {},
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return '필수사항입니다.';
                  }
                  return null;
                },
                obscureText: true,
              ),
              // renderTextFormField(
              //   label: '비밀번호 확인',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }
              //     return null;
              //   },
              //   obscureText: true,
              // ),
              // renderTextFormField(
              //   label: '이름',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }
              //     return null;
              //   },
              // ),
              // renderTextFormField(
              //   label: '생년월일',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }
              //     return null;
              //   },
              // ),
              // renderTextFormField(
              //   label: '성별',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }
              //     return null;
              //   },
              // ),
              // renderTextFormField(
              //   label: '이메일',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }

              //     if (!validate.emailIsOk(val)) {
              //       return '잘못된 이메일 형식입니다.';
              //     }

              //     return null;
              //   },
              // ),
              // renderTextFormField(
              //   label: '휴대전화',
              //   onSaved: (val) {},
              //   validator: (val) {
              //     if (val!.trim().isEmpty) {
              //       return '필수사항입니다.';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // 현재 route를 스택에서 제거함으로써 첫 번째 스크린으로 되돌아 갑니다.
                  // Navigator.pop(context);
                  // _idExistCheck(_idController.text);
                  // print(_isIdExisted);
                  // 폼에 입력된 값 검증
                  if (_formkey.currentState!.validate() &&
                      _idErrorText == null) {
                    // 검증시 처리
                    print('검증 완료');
                    setState(() {
                      _submitted = true;
                    });
                    widget.onSubmit();
                  }
                },
                child: Text('가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
