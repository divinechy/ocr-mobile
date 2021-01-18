import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:ocr_mobile/src/constant/appConstant.dart';
import 'package:ocr_mobile/src/models/dbHelper.dart';
import 'package:ocr_mobile/src/models/form.dart';
import 'package:ocr_mobile/src/models/formResponse.dart';
import 'package:ocr_mobile/src/models/loginResponse.dart';
import 'package:ocr_mobile/src/models/messageResponse.dart';
import 'package:ocr_mobile/src/models/resultResponse.dart';
import 'package:ocr_mobile/src/models/saveResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class RestAPI {
  static getValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var tk = pref.getString('token');
    return tk;
  }

  static Future<void> saveToken(String tk) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', tk);
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<LoginResponse> login(String email, String password) async {
    try {
      var url = AppConstant.baseUrl + AppConstant.userLoginEndpoint;
      Dio _dio = new Dio();
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
      var result = LoginResponse.fromJson(response.data);
      await saveToken(result.token);
      return result;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<FormResponse> submitForm(MyForm _form) async {
    try {
      var token = await getValues();
      var url = AppConstant.baseUrl + AppConstant.postFormEndpoint;
      Dio _dio = new Dio();
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "$token";
      Map<String, String> body = {
        'image': _form.image,
        'imageType': _form.imageType
      };
      var response = await _dio.post(url,
          data: body,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      var result = FormResponse.fromJson(response.data);
      print(result.message);
      return result;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<ResultResponse> attemptToGetResult(String endpoint) async {
    try {
      var token = await getValues();
      var url = AppConstant.baseUrl +
          AppConstant.getResultEndpoint +
          "?id=" +
          endpoint;
      Dio _dio = new Dio();
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "$token";
      var response = await _dio.get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      var res = ResultResponse.fromJson(response.data);
      return res;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Map<String, String>>> getResult(String endpoint) async {
    try {
      List<Map<String, String>> resultList = new List<Map<String, String>>();
      var res = await attemptToGetResult(endpoint);
      if (res.status == true) {
        if (res.message['status'] == "notStarted") {
          //let the user know
          throw "notStarted";
        } else {
          var result =
              res.message['analyzeResult']['documentResults'][0]['fields'];
          if (result != null) {
            Map<String, dynamic>.from(result).forEach((key, value) {
              if (value != null) {
                Map<String, String> myResult = new Map<String, String>();
                myResult = {key: value['text']};
                resultList.add(myResult);
              }
            });
          }
          print(resultList);
          return resultList;
        }
      } else
        throw res.message;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw "Something went wrong";
      }
    }
  }

  static Future<List<Map<String, String>>> getResultTest() async {
    try {
      var token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZG1pbkBzaWRtYWNoLmNvbSIsIkFwcGxpY2F0aW9uU3Vic2NyaWJlcklkIjoiYWYyZGFhMzctMDAzMS00ODc3LWE4MzUtN2U2MmRiNDMwYWQ1IiwiQXBwbGljYXRpb25Vc2VySWQiOiJmYmM2MDI3YS1mZTdjLTRkYmEtOTlkYy03NWJhMTg1M2NjZTMiLCJBcHBsaWNhdGlvblVzZXJFbWFpbCI6IkFkbWluQHNpZG1hY2guY29tIiwiSXNBbmFseXRpY3NFbmFibGVkIjoiRmFsc2UiLCJleHAiOjE2MDA5NjYwNDAsImlzcyI6IlNpZG1hY2hPQ1IuY29tIiwiYXVkIjoiU2lkbWFjaE9DUi5jb20ifQ.vcF0X9bT_2wYUSgEXqx3VGtlYYZMlkGmPEFs5jK1Z1s";
      var url = AppConstant.baseUrl +
          AppConstant.getResultEndpoint +
          "?id=" +
          "https://testformentryreader.cognitiveservices.azure.com/formrecognizer/v2.0-preview/custom/models/37d0982f-1ba2-4fa7-a910-f0a8d79ff108/analyzeresults/5133b4a0-20b9-43a0-b963-863e8972e533";
      List<Map<String, String>> resultList = new List<Map<String, String>>();
      Dio _dio = new Dio();
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "$token";
      var response = await _dio.get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      var res = ResultResponse.fromJson(response.data);
      if (res.status == true) {
        var result =
            res.message['analyzeResult']['documentResults'][0]['fields'];
        Map<String, dynamic>.from(result).forEach((key, value) {
          if (value != null) {
            Map<String, String> myResult = new Map<String, String>();
            myResult = {key: value['text']};
            resultList.add(myResult);
          }
        });
        var re = jsonEncode(resultList);
        var r = jsonDecode(re);
        print(resultList);
        return resultList;
      } else
        throw res.message;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<FormResponse> saveResult(SaveResult _saveResult) async {
    try {
      var token = await getValues();
      var url = AppConstant.baseUrl + AppConstant.saveResultEndpoint;
      Dio _dio = new Dio();
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "$token";
      Map<dynamic, dynamic> body = {
        'name': _saveResult.name,
        'result': _saveResult.result,
        'remarks': _saveResult.remarks,
        'document': _saveResult.document,
        'documentType': _saveResult.documentType,
        'form': _saveResult.form
      };
      var response = await _dio.post(url,
          data: body,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      var result = FormResponse.fromJson(response.data);
      print(result.message);
      return result;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw e.message;
      }
    }
  }

  static Future<ListMessageResponse> getUserHistory() async {
    try {
      var token = await getValues();
      var url = AppConstant.baseUrl + AppConstant.allUserFormsEndpoint;
      Dio _dio = new Dio();
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "$token";
      var response = await _dio.get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      var res = ResultResponse.fromJson(response.data);
      var result = ListMessageResponse.fromJson(res.message);
      return result;
    } catch (e) {
      if (e is String) {
        throw e;
      } else {
        throw "Something went wrong";
      }
    }
  }
}
