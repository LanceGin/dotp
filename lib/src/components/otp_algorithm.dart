import 'package:crypto/crypto.dart';

enum OTPAlgorithm { SHA1, SHA256 }

Hmac createHmacFor({OTPAlgorithm algorithm, List<int> key}) {
  if (key == null) {
    return null;
  }

  switch (algorithm) {
    case OTPAlgorithm.SHA1:
      return Hmac(sha1, key);
    case OTPAlgorithm.SHA256:
      return Hmac(sha256, key);

    default:
      return null;
  }
}
