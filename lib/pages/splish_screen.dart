// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:untitled1/pages/lets_shop_page.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(
//         Duration(seconds: 3),
//             () => Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (builder) => Welcome_page()),
//                 (route) => false));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 785,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   image: DecorationImage(image: AssetImage("assets/images/book store.jpg"),fit: BoxFit.cover)
//               ),
//               child:  Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(color: Colors.blue,)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:library_app/pages/lets_shop_page.dart';
import 'package:lottie/lottie.dart';
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
    Timer(Duration(seconds: 5), ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)
    =>Welcome_page())));
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body:Column(
            children: [
              Center(child:
              Container(
                margin: EdgeInsets.only(top: 150),
                child:Column(
                  children: [
                    Lottie.asset("assets/animation/Good.json",fit: BoxFit.contain),

                  ],


                ),),
              ) ],
          )
      ),
    );
  }
}

