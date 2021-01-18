import 'dart:convert';
import 'dart:core';
import 'package:ocr_mobile/src/constant/appConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../models/userProfileInfo.dart';

class ProfileApi {
  static getValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var tk = pref.getString('token');
    var firstname = pref.getString('firstname');
    var lastName = pref.getString('lastName');
    var phoneNo = pref.getString('phoneNo');
    var company = pref.getString('company');
    var email = pref.getString('email');
    Map<String, String> userDetails = {
      "token": tk,
      "firstName": firstname,
      "lastname": lastName,
      "phoneNumber": phoneNo,
      "companyName": company,
      "email": email,
    };

    return userDetails;
  }

  static Future<void> saveUserDetails(
    String firstname,
    String lastName,
    String phoneNo,
    String company,
    String email,
    String tk,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("applicationUserFirstName", firstname);
      pref.setString("applicationUserLast", lastName);
      pref.setString("applicationUserPhoneNumber", phoneNo);
      pref.setString('appicationSubscriberName', company);
      pref.setString('applicationUserEmail', email);
      pref.setString('token', tk);
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<UserProfileInfo> login(String email, String password) async {
    try {
      Dio _dio = new Dio();

      var url = AppConstant.baseUrl + AppConstant.userLoginEndpoint;

      _dio.options.headers['content-Type'] = 'application/json';

      Map<String, String> body = {
        'email': email,
        'password': password,
      };
      
      var response = await _dio.post(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      var result = UserProfileInfo.fromJson(response.data); // result from API

      await saveUserDetails(
        result.applicationUserFirstName,
        result.applicationUserLast,
        result.applicationUserPhoneNumber,
        result.appicationSubscriberName,
        result.applicationUserEmail,
        result.token,
      );
      
      return result;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }
}
