class PersonDto {
  final String name;
  final String phone;
  final String email;
  final String password;
  final int gender;

  PersonDto({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'gender':gender,
    };
  }
}
