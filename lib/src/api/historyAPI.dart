import 'dart:convert';
import 'dart:core';
import 'package:ocr_mobile/src/constant/appConstant.dart';

import 'package:ocr_mobile/src/models/resultResponse.dart';

import 'package:dio/dio.dart';



class HistoryAPI {

static Future<List<Map<String, String>>> getSavedForms() async {
  try {
      var token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZGVtb2xhQGdtYWlsLmNvbSIsIkFwcGxpY2F0aW9uU3Vic2NyaWJlcklkIjoiYWYyZGFhMzctMDAzMS00ODc3LWE4MzUtN2U2MmRiNDMwYWQ1IiwiQXBwbGljYXRpb25Vc2VySWQiOiJiODdkZDM5Ny0xOTIzLTQzY2EtOGQ4OC00NWQxYjg0MWNjNmYiLCJBcHBsaWNhdGlvblVzZXJFbWFpbCI6IkFkZW1vbGFAZ21haWwuY29tIiwiSXNBbmFseXRpY3NFbmFibGVkIjoiVHJ1ZSIsIkFwcGxpY2F0aW9uU3Vic2NyaWJlck5hbWUiOiJTaWRtYWNoIiwiZXhwIjoxNjAxNjExNzM3LCJpc3MiOiJTaWRtYWNoT0NSLmNvbSIsImF1ZCI6IlNpZG1hY2hPQ1IuY29tIn0.B_3uHxAQ-dDqxB7XqB9XpVaYsKklnXzJQO-Cmdo8m10";
      var url = AppConstant.baseUrl + AppConstant.savedFormsEndpoint;

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

}

