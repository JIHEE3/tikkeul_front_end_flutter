import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tikkeul/api/user.dart';
import 'package:tikkeul/utils/validate.dart' as validate;
import 'package:tikkeul/widget/text_form_field.dart';

import '../constants/enums.dart';
import '../utils/tikkeul_snack_bar.dart';
import '../widget/circle_avatar.dart';
import '../widget/gender_dropdown.dart';
import '../widget/label_wrapper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();

  void onSubmit() {}
}

class _SignUpState extends State<SignUp> {
  String _avatar = '';
  String _id = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _birthDate = '';
  String _gender = 'N';
  String _email = '';
  String _phoneNumber = '';

  // 폼의 상태를 얻기 위한 키
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pw2Controller = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool? _isIdExisted;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    // pw로 공백 없게
    _pwController.addListener(() {
      final String text = _pwController.text.trim();
      _pwController.value = _pwController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    _phoneNumberController.addListener(() {
      final String text = _phoneNumberController.text.trim();

      _phoneNumberController.value = _phoneNumberController.value.copyWith(
        text: text.replaceAllMapped(RegExp(r'(\d{3})(\d{3,4})(\d{4})'),
            (m) => '${m[1]}-${m[2]}-${m[3]}'),
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
    _phoneNumberController.dispose();
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

  void _handleAvatarChange(String path) {
    _avatar = path;
  }

  void _handleGenderChange(String value) {
    _gender = value;
  }

  _handleSubmit(BuildContext context) => () async {
        setState(() {
          _submitted = true;
        });

        // 폼에 입력된 값 검증
        if (_formkey.currentState!.validate() && _idErrorText == null) {
          // 검증시 처리
          _formkey.currentState!.save();

          var map = Map<String, dynamic>();

          if (_avatar != '') {
            map['avatar'] = await MultipartFile.fromFile(_avatar);
          }
          map['id'] = _id;
          map['password'] = _password;
          map['firstName'] = _firstName;
          map['lastName'] = _lastName;
          map['birthDate'] = _birthDate;
          map['gender'] = _gender;
          map['email'] = _email;
          map['phoneNumber'] = _phoneNumber;

          FormData formData = FormData.fromMap(map);

          var res = await signUp(formData);

          var message = '';
          SnackBarType type = SnackBarType.info;
          if (res.data['resultCode'] == 0) {
            message = res.data['message'];
            type = SnackBarType.error;
          } else if (res.data['message'] != '') {
            message = res.data['message'];
            type = SnackBarType.warning;
          }

          if (message != '') {
            TikkeulSnackBar(
              message: message,
              type: type,
            ).showSnackBar();
          }

          if (res.data['resultCode'] == 1) {
            TikkeulSnackBar(
              message: '회원가입 성공!',
              type: SnackBarType.success,
            ).showSnackBar();

            Navigator.pushNamed(context, '/signIn');
          }
        } else {
          TikkeulSnackBar(
            message: "입력사항을 다시 확인해 주세요.",
            type: SnackBarType.error,
          ).showSnackBar();
        }
      };

  /**
   * 
   * 
   * 이메일도 중복체크하기 탈퇴회원 아닌사람으로 해가지고
   * 
   * 
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
            autovalidateMode: _submitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                Column(
                  children: [
                    CommonCircleAvatar(
                      onChange: _handleAvatarChange,
                    ),
                    CommonTextFormField(
                      controller: _idController,
                      label: 'ID',
                      onSaved: (val) {
                        _id = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (!validate.idPatternIsOk(val)) {
                          return '영어 소문자로 시작하는, 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.';
                        }
                        return null;
                      },
                      onChanged: _idExistCheck,
                      decoration: InputDecoration(
                        errorText: _idErrorText,
                      ),
                    ),
                    CommonTextFormField(
                      controller: _pwController,
                      label: '비밀번호',
                      onSaved: (val) {
                        _password = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (!validate.pwPatternIsOk(val)) {
                          return '8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합해 주세요.';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    CommonTextFormField(
                      label: '비밀번호 확인',
                      onSaved: (val) {},
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (val != _pwController.text) {
                          return '비밀번호가 일치하지 않습니다.';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    CommonTextFormField(
                      label: '성',
                      onSaved: (val) {
                        _lastName = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (!validate.userNamePatternIsOk(val)) {
                          return '한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)';
                        }
                        return null;
                      },
                    ),
                    CommonTextFormField(
                      label: '이름',
                      onSaved: (val) {
                        _firstName = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (!validate.userNamePatternIsOk(val)) {
                          return '한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)';
                        }
                        return null;
                      },
                    ),
                    CommonTextFormField(
                      label: '생년월일',
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        _birthDate = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }
                        if (!validate.birthDatePatternIsOk(val)) {
                          return '생년월일 8자리를 입력해 주세요.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: '19900101(8자)',
                      ),
                    ),
                    LabelWrapperField(
                      label: '성별',
                      childrenWidget: Container(
                        alignment: Alignment.centerLeft,
                        child: GenderDropdownButton(
                            selected: _gender, onChange: _handleGenderChange),
                      ),
                    ),
                    CommonTextFormField(
                      label: '이메일',
                      onSaved: (val) {
                        _email = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }

                        if (!validate.emailIsOk(val)) {
                          return '잘못된 이메일 형식입니다.';
                        }

                        return null;
                      },
                    ),
                    CommonTextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      label: '휴대전화',
                      onSaved: (val) {
                        _phoneNumber = val;
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return '필수사항입니다.';
                        }

                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                      maxLength: 11,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: _handleSubmit(context),
                      child: Text('가입하기'),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
