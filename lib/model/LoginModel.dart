class LoginModel {
  String status;
  String msg;
  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  LoginModel({required this.status,required this.msg,required this.accessToken, required this.tokenType,required this.expiresIn,required this.user});

 factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        status:json['status'],
        msg: json['msg'],
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        user: User.fromJson(json['user']) );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status']= this.status;
    data['msg']= this.msg;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {

  String name;
  String mobile;
  String city;
  String gender;
  String region;
  String city_id;
  String region_id;
  String image;

  User(
      {
        required  this.name,
        required  this.mobile,
        required this.city,
        required this.gender,
        required this.region,
        required this.city_id,
        required this.region_id,
        required this.image});

 factory User.fromJson(Map<String, dynamic> json) {
   return User(
   name: json['name']==null?"":json['name'],
       mobile: json['mobile']==null?"":json['mobile'],
       city: json['city']==null ? "":json['city'],
       gender: json['gender'] ==null ?"a":json['gender'],
       region:  json['region']==null?'':json['region'],
       city_id:  json['city_id'] ==null ?"a":json['city_id'],
       region_id: json['region_id']== null?"a":json['region_id'],
       image: json['image']==null?"a":json['image']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['region'] = this.region;
    data['city_id'] = this.city_id;
    data['region_id'] = this.region_id;
    data['image'] = this.image;
    return data;
  }

}
User dummyUser =User(name: "", mobile: '', city: '', gender: '', region: '', city_id: '', region_id:'', image: '');
