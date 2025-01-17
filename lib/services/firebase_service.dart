import 'package:http/http.dart' as http;

class FirebaseService {
  static const String _baseUrl = 'https://helloworld-ecu3v622dq-uc.a.run.app';

  Future<String> getHelloWorld() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
