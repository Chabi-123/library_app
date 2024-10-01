// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled1/goggle_fornts.dart';
// import 'package:untitled1/pages/CartPage.dart';
// import 'package:untitled1/data/book_list.dart';
// import 'package:untitled1/class/class.dart';
// import 'package:untitled1/pages/book_details.dart';
// import 'package:untitled1/pages/favorite.dart';
// import 'package:untitled1/pages/log%20In.dart';
//
// import '../model/book.dart';
//
// class NewPage extends StatefulWidget {
//   const NewPage({super.key});
//
//   @override
//   State<NewPage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<NewPage> {
//   // List to hold search results
//   List<BookList> filteredBooks = [];
//
//   // Variable to hold the search query
//   String searchQuery = '';
//
//   @override
//   void initState() {
//     super.initState();
//     // Initially, all books should be displayed
//     filteredBooks = store;
//   }
//
//   // Method to filter the books based on search query
//   void searchBooks(String query) {
//     List<BookList> results = [];
//     if (query.isEmpty) {
//       // If the search query is empty, display all books
//       results = store;
//     } else {
//       results = store.where((book) {
//         // Search by book name (convert to lower case to make the search case-insensitive)
//         return book.bookName.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     }
//
//     // Update the filtered list and refresh the UI
//     setState(() {
//       filteredBooks = results;
//       searchQuery = query;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ManageState>(
//       builder: (context, ms, constraints) {
//         return Scaffold(
//           drawer:
//           Drawer(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           onTap: (){
//                             //Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>SettingsPage()));
//                           },
//                           leading: Icon(
//                             Icons.settings_outlined,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Settings",
//                             style: style(20),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.lock_outline,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Privacy and Security",
//                             style: style(20),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.question_answer_outlined,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Help and Feedback",
//                             style: style(20),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.question_mark_outlined,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Book Store Information",
//                             style: style(20),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.info_outline_rounded,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Updates",
//                             style: style(20),
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.delete_outline_rounded,
//                             size: 35,
//                           ),
//                           title: Text(
//                             "Recycle Bin",
//                             style: style(20),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(),
//                   MaterialButton(
//                     onPressed: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 AlertDialog(
//                                   title: Text("Do you want to Log Out?"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pushAndRemoveUntil(
//                                               MaterialPageRoute(builder: (builder) => Login()),
//                                                   (route) => false);
//                                         },
//                                         child: Text(
//                                           "Yes",
//                                           style: style(19),
//                                         )),
//                                     SizedBox(
//                                       width: 120,
//                                     ),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text(
//                                           "No",
//                                           style: style(19),
//                                         ))
//                                   ],
//                                 ),
//                               ],
//                             );
//                           });
//                     },
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.logout,
//                         size: 35,color: Colors.red,
//                       ),
//                       title: Text(
//                         "Log Out",
//                         style: style(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             iconTheme: IconThemeData(
//                 color: Colors.white,size: 30
//             ),
//               title: Text('Good Reads',
//                   style: GoogleFonts.greyQo(
//                     fontSize: 40,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   )),
//             centerTitle: true,
//             actions: [
//               Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Icon(
//                       Icons.favorite,
//                       size: 30, color: Colors.red,
//                     ),
//                     Positioned(
//                       right: -10,
//                       top: -10,
//                       child: Container(
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                           color: Colors.blue, shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             "${ms.bookmarkCounter}",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               SizedBox(width: 10),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CartPage()));
//                 },
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Icon(
//                       Icons.shopping_cart_outlined,
//                       size: 30, color: Colors.white,
//                     ),
//                     Positioned(
//                       right: -10,
//                       top: -10,
//                       child: Container(
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                           color: Colors.blue, shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             "${ms.counter}",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Gap(15)
//       ]
//         ),
//           body:
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Discover Your',
//                   style: GoogleFonts.robotoCondensed(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Best Books Now',
//                   style: GoogleFonts.robotoCondensed(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Gap(10),
//                 Text(
//                   'Find your dream book according to your preferences ',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 Text(
//                   'and join our family. What are you searching for?',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 Gap(20),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 310,
//                       child: TextFormField(
//                         onChanged: searchBooks, // Call searchBooks on input change
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.search),
//                           hintText: 'Search for a book',
//                           filled: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Gap(10),
//                     Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.orangeAccent,
//                       ),
//                       child: Icon(Icons.tune),
//                     ),
//                   ],
//                 ),
//                 Gap(20),
//                 Text(
//                   "Top Rated Novels",
//                   style: myStyle(29, Colors.black, FontWeight.bold),
//                 ),
//                 Gap(20),
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 0.556,
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: filteredBooks.length, // Use the filtered list
//                     itemBuilder: (context, index) {
//                       var book = filteredBooks[index];
//                       return Card(
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (builder) => BookDetails(
//                                   bookList: book,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             height: 200,
//                             width: double.infinity,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 171,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     image: DecorationImage(
//                                       image: AssetImage(book.image),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Gap(10),
//                                 Container(
//                                   padding: EdgeInsets.all(15),
//                                   height: 140,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(book.bookName,
//                                           style: myStyle(18)),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text("\$${book.price}", style: myStyle(20)),
//                                           Row(
//                                             children: [
//                                               IconButton(
//                                                 onPressed: () {
//                                                   bool added = ms.addToBookmark(book);
//                                                   String message = added
//                                                       ? "Book has been added"
//                                                       : "Book has been removed";
//                                                   ScaffoldMessenger.of(context).showSnackBar(
//                                                     SnackBar(
//                                                       duration: Duration(seconds: 2),
//                                                       content: Text(message),
//                                                     ),
//                                                   );
//                                                 },
//                                                 icon: book.Bookmarked
//                                                     ? Icon(Icons.favorite, size: 30, color: Colors.red)
//                                                     : Icon(Icons.favorite_border, size: 30, color: Colors.grey),
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {
//                                                   bool added = ms.addToCard(book);
//                                                   String message = added
//                                                       ? "Book has been added"
//                                                       : "Book is already added";
//                                                   ScaffoldMessenger.of(context).showSnackBar(
//                                                     SnackBar(
//                                                       duration: Duration(seconds: 2),
//                                                       content: Text(message),
//                                                     ),
//                                                   );
//                                                 },
//                                                 icon: Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//

