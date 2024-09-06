class UserModel {
  final String id;
  final String email;
  final String avatar;
  final String name;

  UserModel(
      {required this.name,
      required this.id,
      required this.email,
      required this.avatar});
  factory UserModel.formJson(Map<String, dynamic> json) {
    String checkname;
    if (json['id'].toString().length > 5) {
      if (json['name'] == null) {
        checkname = 'Not updated';
      } else {
        checkname = json['name'];
      }
    } else {
      if (json['firstName'] == null && json['lastName'] == null) {
        checkname = 'Not updated';
      }
      checkname = '${json['firstName']} ${json['lastName']}';
    }
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      name: checkname,
      avatar: json['image'],
    );
  }
}
