class UserModel {
  int? id;
  String? email;
  String? name;
  String? phone;
  String? imgUrl;
  String? bio;
  String? address;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.imgUrl,
    this.bio,
    this.address,
  });

  // Factory method to create a User from a Map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      imgUrl: json['img_url'] ?? '',
      bio: json['bio'] ?? '',
      address: json['address'] ?? '',
    );
  }

  // Method to convert a User instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'img_url': imgUrl,
      'bio': bio,
      'address': address,
    };
  }
}
