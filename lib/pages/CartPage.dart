import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/pages/address_page.dart';
import 'package:library_app/pages/bookstore_home_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Cart",
            style: TextStyle( fontSize: 30,color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white, size: 27),
        ),
        body: Consumer<ManageState>(
          builder: (context, ms, _) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ms.cardProducts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.28,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(19),bottomLeft: Radius.circular(19)),
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${ms.cardProducts[index].image}"),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${ms.cardProducts[index].bookName}",
                                          style: TextStyle(
                                            fontSize: 20,fontWeight: FontWeight.bold
                                          )
                                        ),
                                        Text(
                                          "\$${ms.cardProducts[index].price}",
                                          style: TextStyle(
                                              fontSize: 20,fontWeight: FontWeight.bold
                                          )
                                        ),
                                        Gap(20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                ms.decreaseQuantity(ms.cardProducts[index]);
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Gap(10),
                                            Text(
                                              "${ms.cardProducts[index].quantity}",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(10),
                                            IconButton(
                                              onPressed: () {
                                                ms.increaseQuantity(ms.cardProducts[index]);
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Gap(10),
                                            IconButton(
                                              onPressed: () async {
                                                bool confirm = await showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Confirm Deletion",style: TextStyle(fontSize: 20)),
                                                      content: Text("Are you sure you want to remove this item from your cart?",style: style(18),),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("Cancel",style: style(14),),
                                                          onPressed: () {
                                                            Navigator.of(context).pop(false);
                                                          },
                                                        ),
                                                        SizedBox(width: 90,),
                                                        TextButton(
                                                          child: Text("Delete",style: style(14),),
                                                          onPressed: () {
                                                            Navigator.of(context).pop(true);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                if (confirm) {
                                                  ms.deleteProducts(ms.cardProducts[index]);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.delete_outline_outlined,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 4,
                  shadowColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Total",style: TextStyle(
                                fontSize: 20,
                            )),
                            Text("\S${ms.calculate()}", style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold
                                  )),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>AddressPage()));
                          },
                          child: Container(
                              padding: EdgeInsets.all(19),
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff9d0208),
                              ),
                              child: Center(
                                child: Text("Check Out", style: TextStyle(
                                    fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                                ),),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
