import 'dart:convert';
import 'dart:io';

import 'package:chatappfront/Api/services/api_services.dart';
import 'package:chatappfront/Api/services/shared_preferences.dart';
import 'package:chatappfront/models/user_models.dart';
import 'package:chatappfront/views/home/home.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  RxBool isSecured = RxBool(true);
  RxBool isLoading = RxBool(false);

  var userModel = UserModel().obs;

  var selectedImage = File('').obs;

  pickImage () async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      update();
      userModel.value.profilePicture = selectedImage.value.path;
    }
    print(pickedImage!.path);
  }

  register() async {
    isLoading.value = true;

    update();

    try {
      final response = await ApiServices.register(userModel.value);
      final responseBody = await response.stream.bytesToString();

      print(responseBody);

      if (response.statusCode != 200) {
        Get.snackbar('Error', response.reasonPhrase ?? 'Registration failed');
        return;
      }

      final decoded = jsonDecode(responseBody);
      await SharedServices.setData(SetType.string, 'token', decoded['token']);

      Get.offAll(() => const HomeScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  login() async {
    isLoading.value = true;

    final response = await ApiServices.login(userModel.value);

    isLoading.value = false;

    final decode = jsonDecode(response.body);

    if (response.statusCode != 200) {
      Get.snackbar('Error', decode['message'] ?? 'Login failed');
      return;
    }

    await SharedServices.setData(SetType.string, 'token', decode['token']);
    Get.offAll(() => const HomeScreen());
  }
}