class ReqAuth {
  String email;
  String? phone;
  String password;

  ReqAuth({required this.email, this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'phone': phone, 'password': password};
  }
}
