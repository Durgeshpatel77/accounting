import 'package:accounting/DeopboxViwerpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    final email = emailController.text;
    final password = passwordController.text;

    // Hardcoded credentials
    if (email == 'superadmin@mail.com' && password == '123456') {
      // If credentials are correct, navigate to the next screen
      Get.to(() => const DropboxViewerPage());
    } else {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect email or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7), // Light background color
      appBar: AppBar(
        title: const Text('Mani-D Accounting',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff9d2a8a), // Change to a more subtle color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo or title image (optional)
                Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Color(0xff9d2a8a),
                ),
                const SizedBox(height: 30),

                // Email field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email, color: Color(0xff9d2a8a)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock, color: Color(0xff9d2a8a)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login button
                Container(
                  height: 60,
                //  width: double.infinity,
                 // margin: const EdgeInsets.symmetric(vertical: 10), // Add margin if needed
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9d2a8a), // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white), // Text style
                    ),
                  ),
                ),
                 SizedBox(height: 20),

                // Forgot Password (optional)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
