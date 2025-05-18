import 'dart:convert';

import 'package:chatappfront/Api/services/api_services.dart';
import 'package:chatappfront/models/message_model.dart';
import 'package:chatappfront/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class MessageController extends GetxController {
  var messages = <MessageModel>[].obs;
  RxBool isLoading = RxBool(false);
  var user = UsersModel().obs;

  final message = TextEditingController();

  late IOWebSocketChannel channel;

  void websocket () async {
    channel = IOWebSocketChannel.connect('ws://127.0.0.1:6001/app/example');

    await channel.ready;

    channel.sink.add(jsonEncode({
      'event' : 'pusher:subscribe',
      'data' : {
        'channel' : 'chat.1'
      }
    }));
  }

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
