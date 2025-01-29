class AppUser {
  final String uid;
  final String email;
  final String name;

  AppUser({required this.uid, required this.email, required this.name});

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "name": name,
      };

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
      );
}
