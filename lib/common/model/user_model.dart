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
    String checkimage = '';
    if (json['id'].toString().length > 5) {
      if (json['name'] == null) {
        checkname = 'Chưa cập nhật';
      } else {
        checkname = json['name'];
      }
    } else {
      if (json['firstName'] == null && json['lastName'] == null) {
        checkname = 'Chưa cập nhật';
      }
      checkname = '${json['firstName']} ${json['lastName']}';
    }
    if (json['image'] != null) checkimage = json['image'];
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      name: checkname,
      avatar: checkimage,
    );
  }
}
