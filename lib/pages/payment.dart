import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/data/address_list.dart';
import 'package:library_app/data/payment_list.dart';
import 'package:library_app/goggle_fornts.dart';
import 'package:library_app/model/class_payment.dart';
import 'package:library_app/pages/Buy_Page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentModel _selectedMethod = allMethods[0];
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Boolean to track if "COD" is selected
  bool isCodSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Payment Information",
          style: myStyle(29, Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, size: 27,
        ),
      ),
      body: Consumer<ManageState>(
        builder: (context, ms, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Displaying customer information (commented out for now)
                  Text(
                    'Name: ${customer[0].name}',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Email: ${customer[0].email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse("tel: ${customer[0].phoneNo}"),
                      );
                    },
                    child: Text(
                      'Contact: ${customer[0].phoneNo}',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Text(
                    'Address: ${customer[0].address}',
                    style: TextStyle(fontSize: 22),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Placeholder for number of books and total price (commented out for now)
                                Text(
                                  "Number of Books:  ${ms.cardProducts.length}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  "Total Price:  \$ ${ms.calculate()}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Gap(10),
                                Card(
                                  elevation: 4,
                                  child: DropdownButton<PaymentModel>(
                                    value: _selectedMethod,
                                    onChanged: (PaymentModel? newValue) {
                                      setState(() {
                                        _selectedMethod = newValue!;
                                        // Check if "COD" is selected
                                        isCodSelected = _selectedMethod.paymentMethod == 'COD'; // Corrected to check for 'COD'
                                      });
                                    },
                                    items: allMethods.map<DropdownMenuItem<PaymentModel>>(
                                          (PaymentModel method) {
                                        return DropdownMenuItem<PaymentModel>(
                                          value: method,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 36,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("${method.imgUrl}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Gap(10),
                                              Text("${method.paymentMethod}"),
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                Gap(10),

                                // Show form fields only when COD is NOT selected
                                if (!isCodSelected)
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _cardNumber,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: 'Card number',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please enter card number";
                                            }
                                            return null;
                                          },
                                        ),
                                        Gap(10),
                                        TextFormField(
                                          controller: _amount,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: 'Amount',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please enter the amount";
                                            }
                                            return null;
                                          },
                                        ),
                                        Gap(10),
                                        TextFormField(
                                          controller: _password,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please enter your password";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                Gap(20),

                                // Show "Make Payment" button only when COD is selected
                                if (isCodSelected)
                                  MaterialButton(
                                    height: 45,
                                    color: Color(0xff9d0208),
                                    minWidth: double.infinity,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Confirm Purchase"),
                                            content: Text("Do you want to buy?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context) => BuyPage()),
                                                  ); // Navigate to BuyPage
                                                },
                                                child: Text("Buy Now"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Make Payment",
                                      style: myStyle(20, Colors.white),
                                    ),

                                  ),

                                // Show "Buy Now" button when COD is NOT selected
                                if (!isCodSelected)
                                  MaterialButton(
                                    height: 45,
                                    color: Color(0xff9d0208),
                                    minWidth: double.infinity,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Sorry!",
                                                style: myStyle(20),
                                              ),
                                              content: Text(
                                                "This method is not available right now.",
                                                style: myStyle(15),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: myStyle(14),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Buy Now",
                                      style: myStyle(20, Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
