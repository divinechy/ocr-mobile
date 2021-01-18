class ValidationMixin {
  //validating email
  String validateEmail(String value) {
     Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
     RegExp regex = new RegExp(pattern);
     if (!regex.hasMatch(value))
      return 'Please Enter a Valid Email Address';
        else
     return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return "Please Enter a Valid Password. Must be greater than 6 characters";
    }
    return null;
  }
}
