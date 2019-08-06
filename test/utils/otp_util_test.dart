import 'package:dart_otp/src/components/otp_type.dart';
import 'package:dart_otp/src/utils/otp_util.dart';
import 'package:test/test.dart';

void main() {
  test('[OTPType] Should convert otp type cases into the right values', () {
    expect(OTPUtil.otpTypeValue(type: null), null);
    expect(OTPUtil.otpTypeValue(type: OTPType.TOTP), 'totp');
    expect(OTPUtil.otpTypeValue(type: OTPType.HOTP), 'hotp');
  });
}
