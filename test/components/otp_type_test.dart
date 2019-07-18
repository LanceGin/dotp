import 'package:dart_otp/src/components/otp_type.dart';
import 'package:test/test.dart';

void main() {
  test('[OTPType] Should convert otp type cases into the right values', () {
    expect(otpTypeValue(type: null), null);
    expect(otpTypeValue(type: OTPType.TOTP), 'totp');
    expect(otpTypeValue(type: OTPType.HOTP), 'hotp');
  });
}
