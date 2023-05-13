class UserModel {
  final String id, name, email, type;

  UserModel.fromDB(Map<String, dynamic> db)
      : id = db['id'],
        email = db['email'],
        name = db['name'],
        type = db['type'];
}
