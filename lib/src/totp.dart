///
/// @module   : TOTP module to generate and verify TOTP password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'otp.dart';
import 'util.dart';
import 'package:meta/meta.dart';

class TOTP extends OTP {

  int interval;

  ///
  /// @param {secret}
  /// @type {String}
  /// @desc random base32-encoded key to generate OTP.
  ///
  /// @param {interval}
  /// @type {int}
  /// @desc the time interval in seconds for OTP.
  /// This defaults to 30.
  ///
  /// @param {digits}
  /// @type {int}
  /// @desc the length of the one-time password.
  /// This defaults to 6.
  ///
  /// @return {TOTP}
  ///
  TOTP({ @required String secret, int interval = 30, int digits = 6 }) : super(secret, digits) {
    this.interval = interval;
  }

  ///
  /// Generate the OTP with current time.
  ///
  /// @return {OTP}
  ///
  /// @example
  /// TOTP totp = dotp.TOTP('BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  ///
  String now() {
    DateTime _now = DateTime.now();
    int _formatTime = Util.timeFormat(_now, this.interval);

    return super.generateOTP(_formatTime);
  }

  ///
  /// Verifies the OTP passed in against the current time OTP.
  ///
  /// @param {otp}
  /// @type {String}
  /// @desc the OTP waiting for checking
  ///
  /// @param {time}
  /// @type {int or datetime}
  /// @desc Time to check OTP at (defaults to now)
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
  bool verify(String otp, [DateTime time]) {
    DateTime _time = time;
    _time ??= DateTime.now();

    String otpTime = super.generateOTP(Util.timeFormat(_time, this.interval));
    if (otp == otpTime) {
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
