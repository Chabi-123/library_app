import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:library_app/Controller/authantition.dart';
import 'package:library_app/data/sign_list.dart';
import 'package:library_app/goggle_fornts.dart';
import 'package:library_app/model/sign.dart';
import 'package:library_app/pages/log%20In.dart';
import 'package:lottie/lottie.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  AuthClass _authClass = AuthClass();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isRePasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Registration",style: myStyle(30,Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/app_icon.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _firstNameController,
                      label: "Full Name",
                      hint: "Your name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Please enter your number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your number";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _emailController,
                      label: "Email",
                      hint: "Enter your email",
                      suffixIcon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        if (!value.contains("@")) {
                          return "Enter a valid email address";
                        }
                        if (!value.contains("gmail.com")) {
                          return "Email should contain 'gmail.com'";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _passwordController,
                      label: "Password",
                      hint: "Enter your password",
                      obscureText: _isPasswordObscured,
                      suffixIcon: _isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _rePasswordController,
                      label: "Re-enter Password",
                      hint: "Re-enter your password",
                      obscureText: _isRePasswordObscured,
                      suffixIcon: _isRePasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isRePasswordObscured = !_isRePasswordObscured;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please re-enter your password";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.black,
                      onPressed: () async{
                        User? user = await _authClass.signUpWithEmailAndPassword(
                          _emailController.text, _passwordController.text,);
                        if (_formKey.currentState?.validate() ?? false) {
                          userData.add(
                            Register(
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString(),
                              name: _firstNameController.text.toString(),
                              phoneNo: _phoneController.text.toString()
                            ),
                          );
                          if (user != null) {
                            Get.snackbar(
                                backgroundColor: Colors.white,
                                "Success",
                                "Sign In Successful");
                            Get.offAllNamed('/log_in');
                          } else {
                            Get.snackbar(
                              backgroundColor: Colors.white,
                              "Sorry",
                              "Your email or Password may be wrong",
                            );
                          }
                        }
                      },
                      child: Text(
                        "Register Now",
                        style: style(18, Colors.white,FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    IconData? suffixIcon,
    void Function()? onSuffixIconPressed,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
      validator: validator,
    );
  }
}
