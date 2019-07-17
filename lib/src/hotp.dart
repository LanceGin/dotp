///
/// @module   : HOTP module to generate and verify HOTP password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'otp.dart';
import 'package:meta/meta.dart';

class HOTP extends OTP {
  ///
  /// @param {secret}
  /// @type {String}
  /// @desc random base32-encoded key to generate OTP.
  ///
  /// @param {digits}
  /// @type {int}
  /// @desc the length of the one-time password.
  /// This defaults to 6.
  ///
  /// @return {HOTP}
  ///
  HOTP({@required String secret, int digits = 6})
  : super(secret: secret, digits: digits);

  ///
  /// Generate the OTP with the given count
  ///
  /// @param {counter}
  /// @type {int}
  /// @desc the OTP HMAC counter
  ///
  /// @return {String}
  ///
  /// @example
  /// HOTP hotp = HOTP(secret: 'BASE32ENCODEDSECRET');
  /// hotp.at(counter: 0); // => 432143
  ///
  String at({int counter}) {
    if (counter == null || counter < 0) {
      return null;
    }

    return super.generateOTP(input: counter);
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
  /// HOTP hotp = HOTP(secret: 'BASE32ENCODEDSECRET');
  /// hotp.at(counter: 0); // => 432143
  /// // Verify for current time
  /// hotp.verify(otp: 432143, counter: 0); // => true
  /// // Verify after 30s
  /// hotp.verify(otp: 432143, counter: 10); // => false
  ///
  bool verify({String otp, int counter}) {
    if (otp == null || counter == null) return null;

    String otpCount = this.at(counter: counter);
    return otp == otpCount;
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
