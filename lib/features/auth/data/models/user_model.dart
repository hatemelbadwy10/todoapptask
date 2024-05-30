class UserModel{
late final int id;
late final String userName,email,firstName,lastName,gender,image,token;
UserModel.fromJson(Map<String,dynamic>json){
  id= json['id']??0;
  userName= json['username']??"";
  email =json['email']??"";
  firstName =json['firstname']??"";
  lastName =json['lastname']??"";
  gender =json['gender']??"";
  image = json['image']??"";
  token =json['token']??"";
}
}