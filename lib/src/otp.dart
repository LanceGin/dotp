///
/// @module   : OTP module to generate the password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'dart:math';
import 'package:base32/base32.dart';
import 'package:dart_otp/src/components/otp_algorithm.dart';
import 'package:dart_otp/src/components/otp_type.dart';
import 'util.dart';

abstract class OTP {
  int digits;
  String secret;
  OTPAlgorithm algorithm;

  OTPType get type;
  Map<String, dynamic> get extraUrlProperties;

  ///
  /// This constructor will create OTP instance.
  ///
  /// @param {secret}
  /// @type {String}
  /// @desc random base32-encoded key, it is the
  /// key that be used to verify.
  ///
  /// @param {digits}
  /// @type {int}
  /// @desc the length of the one-time password, default to be 6
  ///
  /// @param {algorithm}
  /// @type {OTPAlgorithm}
  /// @desc the algorithm to be used on HMAC encoding, dedault to be SHA1
  ///
  ///
  OTP(
      {String secret,
      int digits = 6,
      OTPAlgorithm algorithm = OTPAlgorithm.SHA1})
      : assert(secret != null),
        assert(digits != null),
        assert(algorithm != null),
        assert(digits > 0) {
    this.secret = secret;
    this.digits = digits;
    this.algorithm = algorithm;
  }

  ///
  /// When class HOTP or TOTP pass the input params to this
  /// function, it will generate the OTP object with params,
  /// the params may be counter or time.
  ///
  /// @param {input}
  /// @type {int}
  /// @desc input params to generate OTP object, maybe
  /// counter or time.
  ///
  /// @return {String}
  ///
  String generateOTP({int input, OTPAlgorithm algorithm = OTPAlgorithm.SHA1}) {
    /// base32 decode the secret
    var hmacKey = base32.decode(this.secret);

    /// initial the HMAC-SHA1 object
    var hmacSha1 = createHmacFor(algorithm: algorithm, key: hmacKey);

    /// get hmac answer
    var hmac = hmacSha1.convert(Util.intToBytelist(input: input)).bytes;

    /// calculate the init offset
    int offset = hmac[hmac.length - 1] & 0xf;

    /// calculate the code
    int code = ((hmac[offset] & 0x7f) << 24 |
        (hmac[offset + 1] & 0xff) << 16 |
        (hmac[offset + 2] & 0xff) << 8 |
        (hmac[offset + 3] & 0xff));

    /// get the initial string code
    var strCode = (code % pow(10, this.digits)).toString();
    strCode = strCode.padLeft(this.digits, '0');

    return strCode;
  }

  ///
  /// Generate a url with TOTP instance.
  ///
  /// @param {issuer}
  /// @type {String}
  /// @desc Service name
  ///
  /// @param {account}
  /// @type {String}
  /// @desc Service identifier or detail
  ///
  /// @return {String}
  ///
  String generateUrl({String issuer, String account}) {
    final _secret = this.secret;
    final _type = otpTypeValue(type: type);
    final _account = Uri.encodeComponent(account ?? '');
    final _issuer = Uri.encodeQueryComponent(issuer ?? '');

    final _algorithm = rawValue(algorithm: algorithm);
    final _extra = extraUrlProperties
        .map((key, value) => MapEntry(key, "$key=$value"))
        .values
        .join('&');

    return 'otpauth://$_type/$_account?secret=$_secret&issuer=$_issuer&digits=$digits&algorithm=$_algorithm&$_extra';
  }
}
