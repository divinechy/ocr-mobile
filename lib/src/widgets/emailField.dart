// import 'package:flutter/material.dart';

// import '../component/validation_mixin.dart';

// class EmailField extends StatefulWidget{
//   String email;

//   EmailField({this.email});

//   @override
//   _EmailFieldState createState() => _EmailFieldState();
// }

// class _EmailFieldState extends State<EmailField> with ValidationMixin {
//   //final email = EmailField(email: value);

//   FocusNode passwordnode = new FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onFieldSubmitted: (String value) {
//         FocusScope.of(context).requestFocus(passwordnode);
//       },
//       textInputAction: TextInputAction.next,
//       cursorColor: Color(0xff05a081),
//       autofocus: false,
//       keyboardType: TextInputType.emailAddress,
//       validator: validateEmail,
//       onSaved: (String value) {
//         widget.email = value;
//       },
//       autocorrect: false,
//       decoration: InputDecoration(
//         contentPadding:
//             new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
//         hintText: 'Email Address',
//         errorStyle: TextStyle(fontWeight: FontWeight.bold),
//         prefixIcon: Icon(
//           Icons.email,
//           color: Color(0xff05a081),
//         ),
//         hintStyle: TextStyle(color: Colors.grey),
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
