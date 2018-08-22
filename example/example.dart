import 'package:dotp/dotp.dart';

void main() {
  TOTP totp = TOTP("J22U6B3WIWRRBTAV");
  HOTP hotp = HOTP("J22U6B3WIWRRBTAV");

  print(totp.now());
  print(hotp.at(2018));
}
