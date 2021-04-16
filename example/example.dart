import 'package:dart_otp/dart_otp.dart';

void main() {
  TOTP totp = TOTP(secret: "J22U6B3WIWRRBTAV");
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV");

  print(totp.now());
  print(totp.value(date: DateTime.parse('2019-01-01 00:00:00.000')));

  print(hotp.at(counter: 0));
  print(hotp.at(counter: 2019));
}
