import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:library_app/class/class.dart';
import 'package:library_app/model/book.dart';
import 'package:library_app/pages/bookstore_home_page.dart';
import 'package:provider/provider.dart';
class BookDetails extends StatefulWidget {
  BookList bookList;
  BookDetails({super.key,required this.bookList});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("About Novels",style: myStyle(30,Colors.white,FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,size: 30
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ManageState>(
          builder: (context,ms,_){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage("${widget.bookList.image}"),
                      ),
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              itemSize: 25,
                              initialRating: widget.bookList.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  widget.bookList.rating = rating;
                                });
                              },
                            ),
                            Text(
                              widget.bookList.rating.toStringAsFixed(1),
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name:  ${widget.bookList.bookName}",style: TextStyle(fontSize:  22)),
                            Text("Author: ${widget.bookList.authore}",style:  TextStyle(fontSize:  22)),
                            Text("Published Date: ${widget.bookList.publishDate}",style:  TextStyle(fontSize:  22)),
                            Gap(10),
                            Text("${widget.bookList.summary}",style:  TextStyle(fontSize:  16))
                          ],
                        ),
                        Gap(10),
                        Divider(),
                        Gap(10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "\$ ${widget.bookList.price}",
                                style: TextStyle(fontSize:  25),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      bool added = ms.addToBookmark(widget.bookList);
                                      String message = added
                                          ? "Book has been added"
                                          : "Book has been removed";
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text(message),
                                        ),
                                      );
                                    },
                                    icon: widget.bookList.Bookmarked ?Icon(
                                      Icons.favorite,
                                      size: 30, color: Colors.red,
                                    ): Icon(
                                      Icons.favorite_border,
                                      size: 30, color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bool added = ms.addToCard(widget.bookList);
                                      String message = added
                                          ? "Book has been added "
                                          : "Book has been removed";
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds:1),
                                          content: Text(message),
                                        ),
                                      );
                                    },
                                    icon: widget.bookList.Bookmarked ?Icon(
                                      Icons.shopping_cart,
                                      size: 30, color: Colors.grey,
                                    ): Icon(
                                      Icons.shopping_cart,
                                      size: 30, color: Colors.grey,
                                    ),
                                    ),
                                ],
                              ),
        
                            ],
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
    );
  }
}
