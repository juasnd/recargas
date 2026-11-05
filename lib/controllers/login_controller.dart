class LoginController {
  bool authenticate({
    required String username,
    required String password,
  }) {
    return username.trim().toLowerCase() == 'fabian' && password == '1234';
  }
}
