  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

import 'Login_controller.dart';

  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final LoginController controller = Get.put(LoginController());
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
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Obx(() {
                      return controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          controller.loginUser(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9d2a8a),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                   SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
