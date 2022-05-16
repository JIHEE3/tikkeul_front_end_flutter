import 'package:flutter/material.dart';
import 'package:tikkeul/constants/enums.dart';
import 'package:tikkeul/utils/secure_storage.dart';
import 'package:tikkeul/utils/tikkeul_snack_bar.dart';

import 'package:tikkeul/widget/text_form_field.dart';
import 'package:tikkeul/api/user.dart' show signIn;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _id = '';
  String _password = '';

  final _formkey = GlobalKey<FormState>();
  bool _submitted = false;

  _handleSubmit(BuildContext context) => () async {
        setState(() {
          _submitted = true;
        });

        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();

          var res = await signIn(_id, _password);

          if (res.data['resultCode'] == 0 && res.data['message'] != '') {
            TikkeulSnackBar(
              message: res.data['message'],
              type: SnackBarType.warning,
            ).showSnackBar();
          } else if (res.data['resultCode'] == 1) {
            addAccessToken(res.data['accessToken']);
            addRefreshToken(res.data['refreshToken']);

            TikkeulSnackBar(
              message: '로그인 성공',
              type: SnackBarType.success,
            ).showSnackBar();

            Navigator.pushNamed(context, '/home');
          }
        }
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 350,
            height: 340,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _formkey,
                autovalidateMode: _submitted
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextFormField(
                        label: 'ID',
                        onSaved: (val) {
                          _id = val;
                        },
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return '아이디를 입력해 주세요.';
                          }

                          return null;
                        }),
                    CommonTextFormField(
                        label: 'Password',
                        obscureText: true,
                        onSaved: (val) {
                          _password = val;
                        },
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return '비밀번호를 입력해 주세요.';
                          }

                          return null;
                        }),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40)),
                      onPressed: _handleSubmit(context),
                      child: Text('로그인'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
