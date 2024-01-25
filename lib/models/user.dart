class User {
  String? id;
  String? name;
  String? email;
  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString());
  }
}
// class CurUser {
//   CurUser({
//     required this.uid,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     this.ref,
//   });
//   final String? uid;
//   final String? firstname;
//   final String? lastname;
//   final String? email;
//   final String? ref;

//   @override
//   String toString() {
//     return '{uid: $uid, firstname: $firstname, lastname: $lastname, email: $email, ref: $ref}';
//   }
// }
