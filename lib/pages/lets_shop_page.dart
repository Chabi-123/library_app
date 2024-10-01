import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:library_app/pages/log%20In.dart';
import 'package:lottie/lottie.dart';

import '../goggle_fornts.dart';


class Welcome_page extends StatelessWidget {
  const Welcome_page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      child: Lottie.asset('assets/animation/Animation2.json')),
                  Positioned(
                    top: 550,
                    left: 30,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hey, are you ready? ",
                              style: style(25, Colors.black,FontWeight.bold),
                            ),
                            Text(
                              "Let's get ready and head ",
                              style: style(25, Colors.black,FontWeight.bold),
                            ),Text(
                              "out to shop for some books!  ",
                              style: style(25, Colors.black,FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => Login()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: third, width: 4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Let's Shop", style: myStyle(25, third)),
                      Gap(10),
                      Icon(Icons.arrow_forward, color: third, size: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


