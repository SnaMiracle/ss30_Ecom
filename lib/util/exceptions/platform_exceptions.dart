class EPlatformException implements Exception {
  final String code;

  EPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Network error. Please check your internet connection.';
      case 'device_not_supported':
        return 'This feature is not supported on your device.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connect.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}