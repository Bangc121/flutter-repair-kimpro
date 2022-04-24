import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kimpro/utils/logger/logger.dart';

/// 카카오 인증 api
class KVerifyApi {

  Future verifyToken(Map data) async {
    final response = await http.post(
      Uri.parse('https://us-central1-today-house-cebe6.cloudfunctions.net/app/api/kakao/verifyToken'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      log.d('[verifyToken] response: $responseBody');
      return responseBody;
    } else {
      throw Exception(response.statusCode.toString() + ":" + response.body.toString());
    }
  }

}
