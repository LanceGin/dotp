# dart_otp

`dart_otp` is a dart package to generate and verify one-time passwords that were used to implement 2FA and MFA authentication method in web applications and other login-required systems.

The package was implement based on [RFC4226](https://tools.ietf.org/html/rfc4226) (HOTP: An HMAC-Based One-Time Password Algorithm) and [RFC6238](https://tools.ietf.org/html/rfc6238) (TOTP: Time-Based One-Time Password Algorithm).

### Feature

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
  dart_otp: ^1.0.2
```

### Example

#### Time-based OTPs

```dart
import 'package:dart_otp/dart_otp.dart';

void main() {
  TOTP totp = TOTP("J22U6B3WIWRRBTAV");
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
  HOTP hotp = HOTP("J22U6B3WIWRRBTAV");
  hotp.at(0); /// => 432143
  hotp.at(1); /// => 231434
  hotp.at(2132); /// => 242432
  
  /// verify with a counter
  hotp.verify(242432, 2132); /// => true
  hotp.verify(242432, 2133); /// => false
}
```

### Api

#### • [TOTP(String secret)](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/totp.dart#L23)

	param: secret
	type: String
	return: TOTP
	desc: generate TOTP instance.

#### • [TOTP.now()](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/totp.dart#L36)

	return: String
	desc: get the one-time password with current time.

#### • [TOTP.verify(String otp, [Datetime time])](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/totp.dart#L64)
	
	param: otp
	type: String
	param: time
	type: Datetime
	return: Boolean
	desc: verify the totp code.

#### • [TOTP.urlGen(String issuer)](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/totp.dart#L85)

	param: issuer
	type: String
	return: String
	desc: generate url with TOTP instance

#### • [HOTP(String secret)](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/hotp.dart#L10)

	param: secret
	type: String
	return: HOTP
	desc: generate HOTP instance.

#### • [HOTP.at(int counter)](https://github.com/BrunoMiguens/dart-_tp/blob/master/lib/src/hotp.dart#L25)

	param: counter
	type: int
	return: String
	desc: generate one-time password with counter.

#### • [HOTP.verify(String otp, int counter)](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/hotp.dart#L50)

	param: otp
	type: String
	param: counter
	type: int
	return: Boolean
	desc: verify the hotp code.

#### • [HOTP.urlGen(String issuer)](https://github.com/BrunoMiguens/dart_otp/blob/master/lib/src/hotp.dart#L69)

	param: issuer
	type: String
	return: String
	desc: generate url with HOTP instance

### Release notes

See [CHANGELOG.md](./CHANGELOG.md).



