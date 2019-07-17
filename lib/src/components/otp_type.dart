enum OTPType { TOTP, HOTP }

String otpTypeValue({OTPType type}) {
  switch (type) {
    case OTPType.TOTP:
      return "totp";

    case OTPType.HOTP:
      return "hotp";

    default:
      return null;
  }
}
