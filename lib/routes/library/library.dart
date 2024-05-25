import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/database_helper.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  FloatingActionButton(onPressed: () {
                    DatabaseHelper db = DatabaseHelper();
                    db.insertBookInfo(OkuurBookInfo(
                        name: "Kitap1",
                        author: "Yazar1",
                        pageCount: 124,
                        imageLink: "imageLink",
                        type: "type",
                        startingDate: "15.05.2024",
                        finishingDate: "-",
                        currentPage: 96,
                        readingTime: 122,
                        status: 0,
                        logIds: ""));
                  },),
                  FloatingActionButton(onPressed: () {
                    DatabaseHelper db = DatabaseHelper();
                    db.deleteAllBookInfo();
                  },),
                  SizedBox(height: 12,),
                  FutureBuilder<List<OkuurBookInfo>>(
                    future: DatabaseHelper().getBookInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      } else {
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              OkuurBookInfo bookInfo = snapshot.data![index];
                              return ListTile(
                                title: Text(bookInfo.name),
                                subtitle: Text(bookInfo.author),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}