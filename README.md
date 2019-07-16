# dart_otp

`dart_otp` is a dart package to generate and verify one-time passwords that were used to implement 2FA and MFA authentication method in web applications and other login-required systems.

The package was implement based on [RFC4226](https://tools.ietf.org/html/rfc4226) (HOTP: An HMAC-Based One-Time Password Algorithm) and [RFC6238](https://tools.ietf.org/html/rfc6238) (TOTP: Time-Based One-Time Password Algorithm).

## Feature

* Generate a `otpauth url` with the b32 encoded string
* Create a HOTP object with verification
* Verify a HOTP token
* Create a TOTP object with verification
* Verify a TOTP token

### Installation

#### Pubspec

Add `dart_otp` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  dart_otp: ^1.0.3
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
  totp.verify(432143); /// => true

  /// verify after 30s
  totp.verify(432143); /// => false
}
```

#### Counter-based OTPs

```dart
import 'package:dart_otp/dart_otp.dart';

void main() {

  /// default initialization 6 digit tokens
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV");

  /// initialization for custom digit value
  HOTP hotp = HOTP(secret: "J22U6B3WIWRRBTAV", digits: 8);

  hotp.at(0); /// => 432143
  hotp.at(1); /// => 231434
  hotp.at(2132); /// => 242432

  /// verify with a counter
  hotp.verify(242432, 2132); /// => true
  hotp.verify(242432, 2133); /// => false
}
```

### Release notes

See [CHANGELOG.md](./CHANGELOG.md).
