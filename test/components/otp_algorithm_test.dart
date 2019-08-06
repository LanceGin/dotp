import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dart_otp/src/components/otp_algorithm.dart';
import 'package:test/test.dart';

void main() {
  var key = utf8.encode('sample key string');

  test(
      '[OTPAlgorithm] Should create an Hmac object for each available algorithm type',
      () {
    expect(createHmacFor(algorithm: OTPAlgorithm.SHA1, key: key).toString(),
        Hmac(sha1, key).toString());
    expect(createHmacFor(algorithm: OTPAlgorithm.SHA256, key: key).toString(),
        Hmac(sha256, key).toString());
    expect(createHmacFor(algorithm: OTPAlgorithm.SHA384, key: key).toString(),
        Hmac(sha384, key).toString());
    expect(createHmacFor(algorithm: OTPAlgorithm.SHA512, key: key).toString(),
        Hmac(sha512, key).toString());
  });

  test(
      '[OTPAlgorithm] Should return a raw value for each available algorithm type',
      () {
    expect(rawValue(algorithm: OTPAlgorithm.SHA1), 'SHA1');
    expect(rawValue(algorithm: OTPAlgorithm.SHA256), 'SHA256');
    expect(rawValue(algorithm: OTPAlgorithm.SHA384), 'SHA384');
    expect(rawValue(algorithm: OTPAlgorithm.SHA512), 'SHA512');
  });

  test('[OTPAlgorithm] Fail conditions', () {
    expect(rawValue(algorithm: null), null);

    expect(createHmacFor(algorithm: null, key: null), null);
    expect(createHmacFor(algorithm: OTPAlgorithm.SHA1, key: null), null);
    expect(createHmacFor(algorithm: null, key: key), null);
  });
}
