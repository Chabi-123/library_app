import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/Controller/getX_controller.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/data/book_list.dart';
import 'package:library_app/data/sign_list.dart';
import 'package:library_app/pages/CartPage.dart';
import 'package:library_app/pages/book_details.dart';
import 'package:library_app/pages/favorite.dart';
import 'package:library_app/pages/log%20In.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../model/book.dart';
class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  // List to hold search results
  List<BookList> filteredBooks = [];

  // Variable to hold the search query
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Initially, all books should be displayed
    filteredBooks = store;
  }

  // Method to filter the books based on search query
  void searchBooks(String query) {
    List<BookList> results = [];
    if (query.isEmpty) {
      // If the search query is empty, display all books
      results = store;
    } else {
      results = store.where((book) {
        // Search by book name (convert to lower case to make the search case-insensitive)
        return book.bookName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    // Update the filtered list and refresh the UI
    setState(() {
      filteredBooks = results;
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageState>(
      builder: (context, ms, constraints) {
        return Scaffold(
          drawer:
            Drawer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(clipBehavior: Clip.none, children: [
                        Container(
                          height: 200,
                          width: 304,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                             ),
                          child: Lottie.asset('assets/animation/Animation3.json'),
                        ),
                        Positioned(
                            left: 180,
                            top: 130,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/pro.png'),
                                      fit: BoxFit.cover),
                                  border: Border.all(color: Colors.black)),
                            )),
                        Positioned(
                          left: 20,
                          top: 220,
                          child: Container(
                            width: 200,
                            height: 90,
                            child: Column(
                              children: [
                                Text(
                                  '${userData[0].name}',
                                  style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold
                                  )
                                ),
                                Text('${userData[0].email}',style: TextStyle(
                                    fontSize: 15,
                                ))
                              ],
                            ),
                          ),
                        ),

                      ]),
                    ],
                  ),
                  Gap(100),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            //Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>SettingsPage()));
                          },
                          leading: Icon(
                            Icons.settings_outlined,
                            size: 35,
                          ),
                          title: Text(
                            "Settings",
                            style: style(20),
                          ),
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.question_answer_outlined,
                            size: 35,
                          ),
                          title: Text(
                            "Help and Feedback",
                            style: style(20),
                          ),
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.info_outline_rounded,
                            size: 35,
                          ),
                          title: Text(
                            "Updates",
                            style: style(20),
                          ),
                        ),

                        // Add the Theme toggle button
                        Switch(
                          value: Provider.of<ThemeProvider>(context).isDarkMode, // Current theme mode
                          onChanged: (value) {
                            // Toggle the theme
                            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();

                            // Show Snackbar using GetX
                            Get.snackbar(
                              "Theme Mode",
                              value ? "Dark Mode is On" : "Dark Mode is Off", // Message depending on the switch state
                              snackPosition: SnackPosition.TOP, // Position of the Snackbar
                              duration: Duration(seconds: 1), // Duration to display the Snackbar
                              backgroundColor: Colors.transparent, // Snackbar background color
                              colorText: Colors.white, // Snackbar text color
                            );
                          },
                          activeTrackColor: Colors.white, // Optional: Track color when switch is on (for light mode)
                          activeColor: Colors.black, // Optional: Thumb color when switch is on
                          inactiveThumbColor: Colors.white, // Optional: Thumb color when switch is off
                          inactiveTrackColor: Colors.black, // Optional: Track color when switch is off
                        )

                      ],
                    ),
                  ),
                  Divider(),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AlertDialog(
                                  title: Text("Do you want to Log Out?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(builder: (builder) => Login()),
                                                  (route) => false);
                                        },
                                        child: Text(
                                          "Yes",
                                          style: style(19),
                                        )),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "No",
                                          style: style(19),
                                        ))
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 35,color: Colors.red,
                      ),
                      title: Text(
                        "Log Out",
                        style: style(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white, size: 30),
            title: Text(
              'Good Reads',
              style: GoogleFonts.greyQo(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => Favorite()));
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${ms.bookmarkCounter}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => CartPage()));
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${ms.counter}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(15),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover Your',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Best Books Now',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                Text(
                  'Find your dream book according to your preferences ',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'and join our family. What are you searching for?',
                  style: TextStyle(fontSize: 15),
                ),
                Gap(20),
                Row(
                  children: [
                    SizedBox(
                      width: 310,
                      child: TextFormField(
                        onChanged: searchBooks, // Call searchBooks on input change
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search for a book',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                      ),
                      child: Icon(Icons.tune),
                    ),
                  ],
                ),
                Gap(20),
                Text(
                  "Top Rated Novels",
                  style: TextStyle(fontSize: 23)
                ),
                Gap(20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.556,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredBooks.length, // Use the filtered list
                    itemBuilder: (context, index) {
                      var book = filteredBooks[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                                MaterialPageRoute(
                            builder: (builder) => BookDetails(bookList: book),
                                       ),
                                      );
                                      },
                                child: Image.asset(
                                  book.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.bookName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RatingBarIndicator(
                                    rating: book.rating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(
                                    "\$${book.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

TextStyle style(double size) {
  return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
}

TextStyle myStyle(double size, Color color, FontWeight fw) {
  return TextStyle(fontSize: size, color: color, fontWeight: fw);
}
