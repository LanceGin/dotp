# dart_otp

[![pub package](https://img.shields.io/pub/v/dart_otp.svg)](https://pub.dev/packages/dart_otp)
[![Build Status](https://travis-ci.org/BrunoMiguens/dart_otp.svg?branch=master)](https://travis-ci.org/BrunoMiguens/dart_otp)
[![Coverage Status](https://coveralls.io/repos/github/BrunoMiguens/dart_otp/badge.svg?branch=master)](https://coveralls.io/github/BrunoMiguens/dart_otp?branch=master)

`dart_otp` is a dart package to generate and verify one-time passwords that were used to implement 2FA and MFA authentication method in web applications and other login-required systems.

The package was implement based on [RFC4226](https://tools.ietf.org/html/rfc4226) (HOTP: An HMAC-Based One-Time Password Algorithm) and [RFC6238](https://tools.ietf.org/html/rfc6238) (TOTP: Time-Based One-Time Password Algorithm).

## Feature

* Generate a `otpauth url` with the b32 encoded string
* Create and verify a HOTP object
* Create and verify a TOTP object

### Installation

#### Pubspec

Add `dart_otp` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  dart_otp: ^1.1.0
```

### Example

#### Time-based OTPs

```dart
import 'package:dart_otp/dart_otp.dart';

void main() {

  /// default initialization for intervals of 30 seconds and 6 digit tokens
  TOTP totp = TOTP(secret: "J22U6B3WIWRRBTAV");

  /// initialization for custom interval and digit values
  TOTP totp = TOTP(secret: "J22U6B3WIWRRBTAV", interval: 60, digits: 8);

  totp.now(); /// => 432143

  /// verify for the current time
  totp.verify(otp: 432143); /// => true

  /// verify after 30s
  totp.verify(otp: 432143); /// => false
}
```

#### Counter-based OTPs

```dart
import 'package:dart_otp/dart_otp.dart';

void main() {

  /// default initialization 6 digit tokens
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV");

  /// initialization for custom digit value
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV", counter: 50, digits: 8);

  hotp.at(counter: 0); /// => 432143
  hotp.at(counter: 1); /// => 231434
  hotp.at(counter: 2132); /// => 242432

  /// verify with a counter
  hotp.verify(otp: 242432, counter: 2132); /// => true
  hotp.verify(otp: 242432, counter: 2133); /// => false
}
```

### Release notes

See [CHANGELOG.md](./CHANGELOG.md).
