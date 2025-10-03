import 'package:get/get.dart';
import '../../../services/auth/auth_services.dart';

class AccountController extends GetxController {
  final authServices = AuthServices();
  var userName = ''.obs;
  var userEmail = ''.obs;
  @override
  void onReady() {
    super.onReady();
    loadUserData();
  }

  void loadUserData() {
    try {
      final user = authServices.getCurrentUser();
      if (user != null) {
        String? displayName = authServices.getCurrentUserDisplayName();

        if (displayName != null && displayName.isNotEmpty) {
          userName.value = displayName.split(' ').first;
        }

        userEmail.value = authServices.getCurrentUserEmail() ?? '';
      }
    } catch (e) {
      throw Exception('Error loading user data: $e');
    }
  }
}
