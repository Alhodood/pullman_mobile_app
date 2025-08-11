import 'package:flutter/material.dart';
import 'package:pullman_mobile_app/Home/screen/home_screen.dart';
import 'package:pullman_mobile_app/const/app_typography.dart';
import 'package:pullman_mobile_app/const/router/routes.dart';
import 'package:pullman_mobile_app/const/ui_utils/custom_colors.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
print("object");
print(emailController.text);
      // if(emailController.text.toLowerCase()=='registerdesk'.toLowerCase()){
Routes.push(screen:EIDScannerScreen() );
      // }else if(emailController.text.toLowerCase()=="housekeep".toLowerCase()){
      //   Routes.push(screen: DashboardView());

      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Logging in...")),
      // );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor,primaryColor.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 12,
              shadowColor: primaryColor.withOpacity(0.5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo or Icon placeholder
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 48,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          "Welcome Back",
                          style: AppText.h1b!.copyWith(color: primaryColor)
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Please login to your account",
                          style:AppText.b1!.copyWith(color: primaryColor)
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter your email" : null,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter your password" : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 6,
                            shadowColor: primaryColor,
                          ),
                          child:  Text(
                            "Login",
                            style:AppText.b1b!.copyWith(color: Colors.white)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.blueAccent.shade700,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
