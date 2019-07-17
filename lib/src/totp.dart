///
/// @module   : TOTP module to generate and verify TOTP password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'otp.dart';
import 'components/otp_type.dart';
import 'util.dart';

class TOTP extends OTP {
  int interval;

  @override
  OTPType get type => OTPType.TOTP;

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
  TOTP({String secret, int interval = 30, int digits = 6})
      : super(secret: secret, digits: digits) {
    this.interval = interval;
  }

  ///
  /// Generate the OTP with current time.
  ///
  /// @return {OTP}
  ///
  /// @example
  /// TOTP totp = TOTP('BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  ///
  String now() {
    int _formatTime = Util.timeFormat(time: DateTime.now(), interval: interval);
    return super.generateOTP(input: _formatTime);
  }

  ///
  /// Generate the OTP with a custom time.
  ///
  /// @param {date}
  /// @type {DateTime}
  /// @desc time to generate the token.
  ///
  /// @return {OTP}
  ///
  /// @example
  /// TOTP totp = TOTP(secret: 'BASE32ENCODEDSECRET');
  /// totp.value(date: DateTime.now()); // => 432143
  ///
  String value({DateTime date}) {
    if (date == null) {
      return null;
    }

    int _formatTime = Util.timeFormat(time: date, interval: interval);
    return super.generateOTP(input: _formatTime);
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
  /// TOTP totp = TOTP('BASE32ENCODEDSECRET');
  /// totp.now(); // => 432143
  /// // Verify for current time
  /// totp.verify(otp: 432143); // => true
  /// // Verify after 30s
  /// totp.verify(otp: 432143); // => false
  ///
  bool verify({String otp, DateTime time}) {
    if (otp == null) {
      return false;
    }

    DateTime _time = time ?? DateTime.now();

    String otpTime = super
        .generateOTP(input: Util.timeFormat(time: _time, interval: interval));
    return otp == otpTime;
  }
}
