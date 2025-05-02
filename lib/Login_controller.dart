import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'DeopboxViwerpage.dart'; // Import your viewer page

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> loginUser(String credential, String password) async {
    isLoading.value = true;

    final url = Uri.parse('https://mani-d.in/admin/public/api/v1/login');
    final response = await http.post(
      url,
      body: {
        'credential': credential,
        'password': password,
      },
    );

    isLoading.value = false;
print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['isSuccess'] == true) {
        final data = jsonResponse['data'];
        final driveLink = data['driveLink'] ?? '';
        final apiToken = data['api_token'] ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('api_token', apiToken);
        await prefs.setString('driveLink', driveLink);

        Get.snackbar("Success", "Login successful");

        // Navigate to Dropbox Viewer page
        Get.to(() => DropboxViewerPage(driveLink: driveLink));
      } else {
        Get.snackbar("Login Failed", jsonResponse['message']);
      }
    } else {
      Get.snackbar("Error", "Server error: ${response.statusCode}");
    }
  }
}
