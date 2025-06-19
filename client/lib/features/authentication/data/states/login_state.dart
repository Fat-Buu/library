class LoginState {
  final String accessToken;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  LoginState({
    this.accessToken = "",
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });
}
