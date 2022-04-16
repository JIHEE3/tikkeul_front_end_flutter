import 'package:tikkeul/api/user.dart' as users;

Future<bool> isExistedId(String id) async {
  return await users.isExistedId(id);
}

bool emailIsOk(String s) {
  if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(s)) {
    return false;
  }
  return true;
}
