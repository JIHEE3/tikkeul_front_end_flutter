import 'package:tikkeul/api/user.dart' as users;

Future<bool> isExistedId(String id) async {
  return await users.isExistedId(id);
}

bool idPatternIsOk(String id) {
  String idPattern = r'^[a-z]+[a-z0-9\-\_]{4,19}$';
  RegExp idRegex = RegExp(idPattern);

  if (idRegex.hasMatch(id)) {
    return true;
  } else {
    return false;
  }
}

bool pwPatternIsOk(String pw) {
  String pwPattern =
      r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$';
  RegExp pwRegex = RegExp(pwPattern);

  if (pwRegex.hasMatch(pw)) {
    return true;
  } else {
    return false;
  }
}

bool userNamePatternIsOk(String name) {
  String namePattern = r'^[a-zA-Zㄱ-힣][a-zA-Zㄱ-힣]*$';
  RegExp nameRegex = RegExp(namePattern);

  if (nameRegex.hasMatch(name)) {
    return true;
  } else {
    return false;
  }
}

bool birthDatePatternIsOk(String birthDate) {
  String birthDatePattern =
      r'^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$';
  RegExp birthDateRegex = RegExp(birthDatePattern);

  if (birthDateRegex.hasMatch(birthDate)) {
    return true;
  } else {
    return false;
  }
}

bool emailIsOk(String s) {
  String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp emailRegex = RegExp(emailPattern);

  if (emailRegex.hasMatch(s)) {
    return true;
  } else {
    return false;
  }
}

bool phoneNumberPatternIsOk(String s) {
  String birthDatePattern =
      r'^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$';

  RegExp birthDateRegex = RegExp(birthDatePattern);

  if (birthDateRegex.hasMatch(s)) {
    return true;
  } else {
    return false;
  }
}
