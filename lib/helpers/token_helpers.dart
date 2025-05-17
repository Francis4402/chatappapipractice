import 'package:chatappfront/Api/services/shared_preferences.dart';

Future<String> authToken () async {
  final token = await SharedServices.getData(SetType.string, 'token');

  return 'Bearer $token';
}