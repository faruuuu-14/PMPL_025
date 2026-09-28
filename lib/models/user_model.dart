class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  get name => null;

  static Object? fromJson(json) {}

  // TODO: buat factory UserModel.fromJson untuk mapping respons
  // GET https://reqres.in/api/users.
  // Field JSON: id, email, first_name, last_name, avatar.
}