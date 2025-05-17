import 'package:chatappfront/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () => controller.pickImage(),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        image: controller.selectedImage.value.path == ''
                            ? null
                            : DecorationImage(
                                image:
                                    FileImage(controller.selectedImage.value),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'enter your name',
                  ),
                  onChanged: (value) {
                    controller.userModel.value.name = value;

                    print(controller.userModel.value.name);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'enter your email address',
                  ),
                  onChanged: (value) {
                    controller.userModel.value.email = value;

                    print(controller.userModel.value.email);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'enter your password',
                  ),
                  onChanged: (value) {
                    controller.userModel.value.password = value;

                    print(controller.userModel.value.password);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: 'enter your phone',
                  ),
                  onChanged: (value) {
                    controller.userModel.value.phone = value;

                    print(controller.userModel.value.phone);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date Of Birth',
                    hintText: 'enter your date of birth',
                  ),
                  onChanged: (value) {
                    controller.userModel.value.dateOfBirth = value;

                    print(controller.userModel.value.dateOfBirth);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.register();
                    },
                    child: Text(
                      controller.isLoading.value ? 'Loading' : 'Sign Up',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already Have An Account ?'),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
