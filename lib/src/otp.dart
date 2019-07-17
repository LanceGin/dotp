///
/// @module   : OTP module to generate the password
/// @author   : Gin (gin.lance.inside@hotmail.com)
///

import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';
import 'util.dart';

abstract class OTP {
  String secret;
  int digits;

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
  /// @param {digest}
  /// @type {String}
  /// @desc the key that be used to do HMAC encoding, dedault and
  /// only to be "sha1"
  ///
  ///
  OTP({String secret, int digits = 6})
      : assert(secret != null),
        assert(digits != null),
        assert(digits > 0) {
    this.secret = secret;
    this.digits = digits;
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
  String generateOTP({int input}) {
    /// base32 decode the secret
    var hmacKey = base32.decode(this.secret);

    /// initial the HMAC-SHA1 object
    var hmacSha1 = Hmac(sha1, hmacKey);

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
  /// Generate a url with TOTP or HOTP instance.
  ///
  /// @param {issuer}
  /// @type {String}
  /// @desc maybe it is the Service name
  ///
  /// @param {type}
  /// @type {String}
  /// @desc type of OTP instance
  ///
  /// @return {String}
  ///
  String urlGen(String _issuer, String _type) {
    final _secret = this.secret;
    return 'otpauth://$_type/SK?secret=$_secret&issuer=$_issuer';
  }
}
