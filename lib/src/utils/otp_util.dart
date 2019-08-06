import 'package:dart_otp/dart_otp.dart';

abstract class OTPUtil {
  static String otpTypeValue({OTPType type}) {
    switch (type) {
      case OTPType.TOTP:
        return "totp";

      case OTPType.HOTP:
        return "hotp";

      default:
        return null;
    }
  }
}
