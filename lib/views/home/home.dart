import 'package:chatappfront/Api/services/shared_preferences.dart';
import 'package:chatappfront/controllers/home_controller.dart';
import 'package:chatappfront/controllers/message_controller.dart';
import 'package:chatappfront/pages/LoginScreen.dart';
import 'package:chatappfront/views/messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomeController());
    final messageController = Get.put(MessageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              SharedServices.removeData('token');
              Get.offAll(() => const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemBuilder: (_, index) {

                final user = controller.users[index];

                return ListTile(
                  onTap: () {
                    messageController.user.value = user;
                    Get.to(() => const MessageScreen());
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage!),
                  ),
                  title: Text(user.name!),
                  subtitle: Text(user.email!),
                );
              },
              itemCount: controller.users.length);
        }
      })
    );
  }
}
