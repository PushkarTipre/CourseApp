class Sign_In_State {
  final String email;
  final String password;

  const Sign_In_State({this.email = '', this.password = ''});

  Sign_In_State copyWith({
    String? email,
    String? password,
  }) {
    return Sign_In_State(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
