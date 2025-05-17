import 'package:chatappfront/Api/services/api_services.dart';
import 'package:chatappfront/models/users_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var users = <UsersModel>[].obs;

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  getUsers () async {
    isLoading.value = true;

    final response = await ApiServices.getUsers();

    isLoading.value = false;

    if (response.statusCode != 200) {
      print(response.body);
      return;
    }

    users.value = usersModelFromJson(response.body);

    update();
  }

}