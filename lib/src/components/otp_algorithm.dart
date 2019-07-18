import 'package:crypto/crypto.dart';

enum OTPAlgorithm { SHA1, SHA256 }

String rawValue({OTPAlgorithm algorithm}) {
  switch (algorithm) {
    case OTPAlgorithm.SHA1:
      return 'SHA1';
    case OTPAlgorithm.SHA256:
      return 'SHA256';

    default:
      return null;
  }
}

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
