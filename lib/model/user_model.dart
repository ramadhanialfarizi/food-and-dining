class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    password = map['password'];
  }
}
