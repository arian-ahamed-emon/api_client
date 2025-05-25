import 'dart:convert';

import 'package:api_client/data/model/network_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri);
      responseData(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSucsess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSucsess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSucsess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await post(
        uri,
        headers: {'content-type': 'Application/json'},
        body: jsonEncode(body),
      );
      responseData(url, response);
      if (response.statusCode == 200) {
        final encodeData = jsonEncode(response.body);
        return NetworkResponse(
          isSucsess: true,
          statusCode: response.statusCode,
          responseData: encodeData,
        );
      } else {
        return NetworkResponse(
          isSucsess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSucsess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void responseData(String url, Response response) {
    debugPrint(
      'URL:$url\nStatusCode: ${response.statusCode}\nBODY:${response.body}',
    );
  }
}
