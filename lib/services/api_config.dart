class ApiConfig {
  static const String baseUrl = 'https://app.talktsy.com/_app/client/r0/';
  static const String mediaBaseUrl = 'https://app.talktsy.com/_app/media/r0/';
  static const String mediaUrl = 'https://app.talktsy.com/_app/media/r0/thumbnail/app.talktsy.com/';

  static const String loginEndpoint = 'login';
  static const String logoutEndpoint = 'logout';
  static const String userAvailableEndpoint = 'register/available?username=';
  // static const String registerEndpoint = 'register/available?username=';
  static const String uploadImageEndpoint = 'upload?filename=';
  static const String updateProfileImageEndpoint = 'profile/:userId/avatar_url';
  static const String profileEndpoint = 'profile/:userId';
  static const String syncEndpoint = 'sync';

  // API STATUS CODE
  static const int successCode = 200;
  static const int unauthorizedCode = 401;
}
