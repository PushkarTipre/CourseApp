class Register_State {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  Register_State(
      {this.userName = '',
      this.confirmPassword = '',
      this.email = '',
      this.password = ''});

  Register_State copyWith(
      {String? userName,
      String? email,
      String? password,
      String? confirmPassword}) {
    return Register_State(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
