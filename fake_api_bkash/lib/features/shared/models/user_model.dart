class UserInfoModel {
  final String id;
  final String cus_name;
  final String cus_add;
  final String cus_city;
  final String cus_phone;
  final User user;

  UserInfoModel(
    {
      required this.id,
      required this.cus_name,
      required this.cus_add,
      required this.cus_city,
      required this.cus_phone,
      required this.user
    }
  );

factory UserInfoModel.formJson(Map<String, dynamic> json){
  return UserInfoModel(id: json['id'], cus_name: json['cus_name'], cus_add: json['cus_add'], cus_city:json['cus_city'], cus_phone: json['cus_phone'], user: User.formJson(json['user']));
}

Map<String, dynamic> toJson() {
  return {
    "id": id,
    "cus_name": cus_name,
    "cus_add": cus_add,
    "cus_city": cus_city,
    "cus_phone": cus_phone,
    "user": user.toJson(), 
  };
}
  
}

class User{
  final String id;
  final String email;

  User({
    required this.id,
    required this.email
  });

  factory User.formJson(Map<String, dynamic> json){
    return User(id: json['id'], email: json['email']);
  }
  Map<String, dynamic> toJson() {
  return {
    "id": id,
    "email": email,
  };
}
}