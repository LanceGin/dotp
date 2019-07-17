import 'package:dart_otp/dart_otp.dart';
import 'package:test/test.dart';

void main() {

    var totp = TOTP(secret: "J22U6B3WIWRRBTAV");

  test('[TOTP] Should check the token with default digits and interval', () {

    expect(totp.digits, 6);
    expect(totp.interval, 30);
    expect(totp.secret, "J22U6B3WIWRRBTAV");

  });

  test('[TOTP] Should check the token with custom digits and interval', () {

    var token = TOTP(secret: "J22U6B3WIWRRBTAV", digits: 8, interval: 60);

    expect(token.digits, 8);
    expect(token.interval, 60);
    expect(token.secret, "J22U6B3WIWRRBTAV");

  });

  test('[TOTP] Should generate and verify using a specific date time', () {

    var time = DateTime.now();
    var otpValue = totp.value(date: time);

    expect(totp.verify(otp: otpValue, time: time), true);

  });

  test('[TOTP] Should generate, verify hard coded date time and compare to current time (should be false)', () {

    var time = DateTime.parse('2019-01-01 00:00:00.000');
    var otpValue = totp.value(date: time);

    expect(totp.verify(otp: otpValue), false);
    expect(totp.verify(otp: otpValue, time: time), true);

  });

}