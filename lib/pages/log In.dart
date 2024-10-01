import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:library_app/Controller/authantition.dart';
import 'package:library_app/data/sign_list.dart';
import 'package:library_app/goggle_fornts.dart';
import 'package:library_app/pages/BottonNa.dart';
import 'package:library_app/pages/forget%20password.dart';
import 'package:library_app/pages/registration_page.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthClass _authServices= AuthClass();
  final TextEditingController _phoneEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Log In",style: myStyle(30,Colors.white),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Positioned(
                left: 80,
                top: 90,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/app_icon.png'),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.black)),
                )),
            Padding(
              padding:EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        suffixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        if (value != userData[0].email) {
                          return "Email does not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      maxLines: 1,
                      controller: _passwordController,
                      obscureText: _isObs,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObs = !_isObs;
                            });
                          },
                          icon: Icon(
                            _isObs ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value != userData[0].password) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgetPassword()),
                );
              },
              child: Text(
                "Forgot Password?",
                style: myStyle(20, Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minWidth: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                color: Colors.black,
                onPressed: () async {
                  User? user = await _authServices.signInWithEmailAndPassword(
                      _phoneEmailController.text, _passwordController.text);
                  if (user != null) {
                    Get.snackbar(
                        backgroundColor: Colors.white,
                        "Success",
                        "Sign In Successful");
                    Get.offAllNamed('/nav_bar');
                  } else {
                    Get.snackbar(
                      backgroundColor: Colors.white,
                      "Sorry",
                      "Your email or Password may be wrong",
                    );
                  }
                },
                child: Text(
                  "Log In",
                  style: style(19, Colors.white, FontWeight.bold),
                ),
              ),
            ),
            MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.9,
                color: Colors.black,
                child: Text(
                  'Sign Up',
                    style: style(19, Colors.white, FontWeight.bold)
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => Registration()));
                }),
            Gap(20),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.black,thickness: 1,indent:10,endIndent: 10,)),
                Text('Sign Up With ', style: style(19, Colors.black, FontWeight.bold)),
                Expanded(child: Divider(color: Colors.black,thickness: 1,indent:10,endIndent: 10,)),

              ],
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async{
                    _authServices.signInWithGoogle();
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Facebook_Logo_2023.png'),
                  ),
                ),
                Gap(50),
                InkWell(
                  onTap: () async{
                    _authServices.signInWithGoogle();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/google.png'),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
