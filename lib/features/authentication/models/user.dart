class User {
  String? id;
  String? name;
  String? email;
  String? fcm;
  String? profilePicture;

  User({this.id, this.name, this.email, this.fcm, this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    fcm = json['fcm'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['fcm'] = fcm;
    data['profile_picture'] = profilePicture;
    return data;
  }
}
