import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addBook/components/add_book_app_bar.dart';
import 'package:okuur/routes/addBook/components/book_image.dart';
import 'package:okuur/routes/addBook/components/book_info.dart';
import 'package:okuur/routes/addBook/components/book_init.dart';
import 'package:okuur/routes/addBook/components/book_state.dart';
import 'package:okuur/ui/components/switch_button.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {

  AppColors colors = AppColors();

  int currentButtonIndex = 0;

  void handleButtonChange(int newButton) {
    setState(() {
      currentButtonIndex = newButton;
    });
  }

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
                  SizedBox(height: 12,),
                  addBookAppBar(),
                  SizedBox(height: 16,),
                  OkuurSwitchButton(buttonCount: 2,buttonNames: ["Kendin Ekle","Kitabı Ara"],onChanged:  handleButtonChange,),
                  SizedBox(height: 12,),
                  BookInfo(),
                  SizedBox(height: 12,),
                  addBookState(),
                  SizedBox(height: 12,),
                  addBookImage(),
                  SizedBox(height: 12,),
                  addBookInit()
                ],),
            ),
          ),
        ),
      ),
    );
  }

}