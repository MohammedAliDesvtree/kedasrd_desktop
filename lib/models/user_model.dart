class User {
  final String email;
  final String password;
  final String role;
  final String name;

  User({
    required this.email,
    required this.password,
    required this.role,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'role': role,
        'name': name,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        role: json['role'],
        name: json['name'],
      );
}
