import 'package:dart_otp/dart_otp.dart';

void main() {
  TOTP a = TOTP("J22U6B3WIWRRBTAV");
  print(a.now());

  List<int> _result = [];
  _result.addAll([0, 2, 3, 4, 0, 0, 0, 0]);
  _result = _result.sublist(0, 8);
  _result = _result.reversed.toList();
  print(_result);
}
