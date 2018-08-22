///
/// @module   : HOTP module to generate and verify HOTP password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'otp.dart';

class HOTP extends OTP {
  HOTP(String secret, [int digits = 6]) : super(secret, digits);

  ///
  /// Generate the OTP with the given count
  ///
  /// @param {count}
  /// @type {int}
  /// @desc the OTP HMAC counter
  ///
  /// @return {String}
  ///
  /// @example
  /// HOTP hotp = dotp.HOTP('BASE32_ENCODED_SECRET');
  /// hotp.at(0); // => 432143
  ///
  String at(int count) {
    return super.generateOTP(count);
  }

  ///
  /// Verifies the OTP passed in against the current time OTP.
  ///
  /// @param {otp}
  /// @type {String}
  /// @desc the OTP waiting for checking
  ///
  /// @param {counter}
  /// @type {int}
  /// @desc the OTP HMAC counter
  ///
  /// @return {Boolean}
  ///
  /// @example
  /// TOTP totp = dotp.TOTP('BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  /// // Verify for current time
  /// totp.verify(432143); // => true
  /// // Verify after 30s
  /// totp.verify(432143); // => false
  ///
  bool verify(String otp, int counter) {
    String otpCount = this.at(counter);

    if (otp == otpCount) {
      return true;
    }
    return false;
  }

  ///
  /// Generate a url with TOTP instance.
  ///
  /// @param {issuer}
  /// @type {String}
  /// @desc maybe it is the Service name
  ///
  /// @return {String}
  ///
  @override
  String urlGen(String _issuer, String _type) {
    _issuer ??= '';
    _type = 'totp';
    return super.urlGen(_issuer, _type);
  }
}
