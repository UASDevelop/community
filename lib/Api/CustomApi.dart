import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomApi {
  //baseUrl
  static const String baseUrl = 'https://communities-hkvi.vercel.app';

  ///Endpoints
  static const signup_end_point = '/api/v2/user/create-user';
  static const login_end_point = '/api/v2/user/login-user';
  static const alluser_end_point = '/api/v2/user/getAllUsers';
  static const singleuser_end_point = '/api/v2/user/ getUser/';
  static const allcommunity_end_point = '/api/v2/community/getAllCommunity';
  static const allreport_end_point = '/api/v2/report/getAllReports';
  static const singlereport_end_point = '/api/v2/report/getReport/:id';
  static const createreport_end_point = '/api/v2/report/create-report';
  static const givefeedbacke_end_point = '/api/v2/report/getReport/:id';
  // Function to make a GET request
  static Future<dynamic> get(String endpoint) async {
    final apiUrl = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  // Function to make a POST request
  static Future<dynamic> post(
      String endpoint, Map<String, dynamic> data) async {
    final apiUrl = Uri.parse('$baseUrl/$endpoint');

    // Optionally, if your API requires authentication, set headers here
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      apiUrl,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }
}
