class User {
  String? name;
  String? email;
  int? id;

  User({this.name, this.id, this.email});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
