class MyUsers{
  static const String collectionName='users';
  String id;
  String firstname;
  String lastname;
  String username;
  String email;

  MyUsers({
      required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname
  });

MyUsers.fromJson(Map<String,dynamic> json):this
    (
    id:json['id'] as String,
    username:json['username'] as String,
    email:json['email'] as String,
    firstname:json['firstname'] as String,
    lastname:json['lastname'] as String,
  );
Map<String,dynamic> toJson(){
  return {
    "id":id,
    "username":username,
    "email":email,
    "firstname":firstname,
    "lastname":lastname,
  };
}
}