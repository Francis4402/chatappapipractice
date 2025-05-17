import 'package:chatappfront/Api/services/api_services.dart';
import 'package:chatappfront/models/message_model.dart';
import 'package:chatappfront/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <MessageModel>[].obs;
  RxBool isLoading = RxBool(false);
  var user = UsersModel().obs;

  final message = TextEditingController();

  getMessages() async {
    isLoading.value = true;

    final response = await ApiServices.getMessages(user.value.id.toString());

    isLoading.value = false;

    messages.value = messageModelFromJson(response.body);
  }

  sendMessage() async {
    final response = await ApiServices.sendMessage(
      user.value.id.toString(),
      message.text.toString(),
    );

    print(response.body);

    message.clear();
  }
}
