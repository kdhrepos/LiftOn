class UserModel {
  final String? id, name, email;

  void showInfo() {
    print("$id, $name, $email");
  }

  UserModel.fromDB(Map<String, dynamic> db)
      : id = db['id'].toString(),
        email = db['email'],
        name = db['name'];
  // type = db['type'];
}
