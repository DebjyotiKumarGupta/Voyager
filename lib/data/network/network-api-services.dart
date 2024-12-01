import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:voyager/data/network/base-api-services.dart';
import 'package:voyager/data/response/api-exception.dart';

class NetworkServices extends BaseApiServices {
  @override
  Future<dynamic> postApi(String token, dynamic data, String url) async {
    if (kDebugMode) {
      print(data);
      print(url);
      print(token);
    }
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'content-Type': 'application/json',
    };
    print("ok hai ");
    dynamic responseData;
    try {
      print("yaha tak bhi ok hai ");
      final response = await http
          .post(Uri.parse(url), headers: requestHeaders, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      print("hua kya ");
      responseData = returnResponse(response);
    } catch (e) {
      print("An error occurred: $e");
    }
    print(responseData.toString());
    return responseData;
  }

  dynamic returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response);
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = response.body;
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);
        // if (responseJson["message"] == "cannot redeem before time") {
        Get.snackbar("message", "${responseJson["message"]}");
        // } else
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        Get.snackbar("message", "${responseJson["message"]}");
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);

      case 403:
        dynamic responseJson = jsonDecode(response.body);
        Get.snackbar("message", "${responseJson["message"]}");

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
    }
  }

  @override
  Future getApi(String token, String Url) {
    // TODO: implement getApi
    throw UnimplementedError();
  }
}
