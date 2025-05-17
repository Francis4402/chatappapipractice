import 'package:chatappfront/helpers/token_helpers.dart';
import 'package:chatappfront/models/user_models.dart';
import 'package:chatappfront/utils/endPoints.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<http.StreamedResponse> register(UserModel data) async {
    final request = http.MultipartRequest('POST', ApiEndpoints.register);

    request.fields.addAll({
      'email': data.email!,
      'name': data.name!,
      'password': data.password!,
      'phone': data.phone!,
      'date_of_birth': data.dateOfBirth!,
    });

    request.files.add(
      await http.MultipartFile.fromPath('profile_image', data.profilePicture!),
    );

    request.headers.addAll({
      'Accept' : 'application/json'
    });

    final response = await request.send();

    return response;
  }

  static Future<http.Response> login(UserModel data) async {
    return await http.post(
      ApiEndpoints.login,
      headers: {
        'Accept': 'application/json',
      },
      body: data.toLogin(),
    );
  }

  static Future<http.Response> getUsers() async {
    return await http.get(
      ApiEndpoints.users,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> getMessages(String id) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.messages}/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> sendMessage(String receiverId, String message) async {
    return await http.post(
      ApiEndpoints.sendMessage,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
      body: {
        'receiver_id' : receiverId,
        'message' : message,
        'type' : 'text',
      }
    );
  }
}
