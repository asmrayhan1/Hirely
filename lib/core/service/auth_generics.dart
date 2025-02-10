class AuthModel {
  int? id;
  String email;
  bool role;

  // Constructor
  AuthModel({this.id, required this.email, required this.role});

  // Convert AuthModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
    };
  }

  // Create an AuthModel instance from a Map
  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'],
      email: map['email'],
      role: map['role'],
    );
  }
}

class AuthGenerics{
  String? email;
  bool? role;
  AuthGenerics({this.email, this.role});

  AuthGenerics update({bool? isRole, String? newEmail}) {
    return AuthGenerics(
        email: newEmail ?? email,
        role: isRole ?? role
    );
  }
}