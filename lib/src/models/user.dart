class User{
   String email;
   String password;

   User(this.email, this.password);

   User.fromJson(Map<String, dynamic>jsonData){
     email = jsonData['email'];
     password = jsonData['password'];
   }
}