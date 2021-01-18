// import 'package:flutter/material.dart';
// import '../component/validation_mixin.dart';


// class PasswordField extends StatefulWidget {
//   @override
//   _PasswordFieldState createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField>  with ValidationMixin{
//   String password = "";

//   FocusNode passwordnode = new FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onFieldSubmitted: (String value) {
//         //we can login here as well
//       },
//       obscureText: true,
//       focusNode: passwordnode,
//       textInputAction: TextInputAction.done,
//       cursorColor: Color(0xff05a081),
//       autofocus: false,
//       keyboardType: TextInputType.emailAddress,
//       validator: validatePassword,
//       onSaved: (String value) {
//         password = value;
//       },
//       autocorrect: false,
//       decoration: InputDecoration(
//         contentPadding:
//             new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
//         hintText: 'Password',
//         prefixIcon: Icon(
//           Icons.lock,
//           color: Color(0xff05a081),
//         ),
//         hintStyle: TextStyle(color: Colors.grey),
//         errorStyle: TextStyle(fontWeight: FontWeight.bold),
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//           borderSide: BorderSide(color: Color(0xff05a081), width: 2),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           borderSide: BorderSide(color: Color(0xff05a081), width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           borderSide: BorderSide(color: Color(0xff05a081), width: 2),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           borderSide: BorderSide(color: Color(0xff05a081), width: 2),
//         ),
//       ),
//     );
//   }
// }