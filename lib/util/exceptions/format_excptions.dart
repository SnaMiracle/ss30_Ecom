class EFormatException implements Exception {
  final String message;

  const EFormatException([this.message = 'And unexpected format error occurred. Please check your input.']);

  factory EFormatException.fromMessage(String message) {
    return EFormatException(message);
  }

  String get formattedMessage => message;

  factory EFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const EFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const EFormatException('The provided phone number format is invalid. Please enter a valid number');
      case 'invalid-data-format':
        return const EFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const EFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const EFormatException('The credit card format is invalid. Please enter a valid card number.');
      case 'invalid-numeric-format':
        return const EFormatException('The input should be a valid numeric format.');
      default:
        return const EFormatException();
    }
  }
}

