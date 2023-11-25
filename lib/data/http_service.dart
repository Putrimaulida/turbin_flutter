
class HttpService {
  static const String baseUrl = 'http://36.89.142.91:8000/api';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String onboarding = 'onboarding';
  final String login = 'auth/login';
  final String logout = 'auth/logout';
  final String categories = '/categories';
}
