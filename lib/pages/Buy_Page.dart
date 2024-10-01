import 'package:flutter/material.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/pages/BottonNa.dart';
import 'package:library_app/pages/bookstore_home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Purchase",
          style: TextStyle(fontSize: 25,color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 27),
      ),
      body: Consumer<ManageState>(
        builder: (context, ms, _) {
          if (ms.cardProducts.isEmpty) {
            return Center(
              child: Text(
                "No products in cart",
                style:TextStyle(fontSize: 20),
              ),
            );
          }

          return ms.cardProducts.length == 1
              ? ListView.builder(
            itemCount: ms.cardProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                            "${ms.cardProducts[index].image}")),
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PracticeBottomNavBar()), (route) => false,);
                        },
                        child: Lottie.asset("assets/animation/complete.json")),
                    Text(
                      "You have Purchased",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            },
          )
              : GridView.builder(
            padding: const EdgeInsets.all(30),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: ms.cardProducts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: 100,
                    height: 200,
                    child: Image.asset("${ms.cardProducts[index].image}",fit: BoxFit.cover,),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NewPage()), (route) => false,);
                      },
                      child: Lottie.asset("assets/animation/complete.json")),
                  Text(
                    "Purchased",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
