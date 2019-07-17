import 'package:dart_otp/dart_otp.dart';

void main() {
  TOTP totp = TOTP(secret: "J22U6B3WIWRRBTAV");
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV");

  print(totp.now());
  print(hotp.at(counter: 2018));
}
