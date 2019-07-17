import 'package:dart_otp/dart_otp.dart';
import 'package:test/test.dart';

void main() {

    var hotp = HOTP(secret: "J22U6B3WIWRRBTAV");

  test('[HOTP] Should check the token with default digits', () {

    expect(hotp.digits, 6);
    expect(hotp.secret, "J22U6B3WIWRRBTAV");

  });

  test('[HOTP] Should check the token with custom digits', () {

    var token = HOTP(secret: "J22U6B3WIWRRBTAV", digits: 8);

    expect(token.digits, 8);
    expect(token.secret, "J22U6B3WIWRRBTAV");

  });

  test('[HOTP] Should generate and verify using a specific counter', () {

    var otpValue = hotp.at(counter: 0);
    expect(hotp.verify(otp: otpValue, counter: 0), true);

  });

  test('[HOTP] Should generate, verify using a specific counter and comare with a superior counter', () {

    var otpValue = hotp.at(counter: 10);
    expect(hotp.verify(otp: otpValue, counter: 10), true);
    expect(hotp.verify(otp: otpValue, counter: 20), false);

  });

}