import 'package:flutter/material.dart';
import 'package:okuur/controllers/add_book_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addBook/components/add_book_app_bar.dart';
import 'package:okuur/routes/addBook/components/add_book_button.dart';
import 'package:okuur/routes/addBook/components/add_book_finish_date.dart';
import 'package:okuur/routes/addBook/components/book_current_page.dart';
import 'package:okuur/routes/addBook/components/book_image.dart';
import 'package:okuur/routes/addBook/components/book_info.dart';
import 'package:okuur/routes/addBook/components/book_init.dart';
import 'package:okuur/routes/addBook/components/book_rating.dart';
import 'package:okuur/routes/addBook/components/book_state.dart';
import 'package:okuur/ui/components/switch_button.dart';
import 'package:get/get.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {

  @override
  void initState() {
    super.initState();
    Get.put(AddBookController());
    AddBookController controller = Get.find();
    controller.clearAll();
  }

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
                  addBookAppBar(context),
                  SizedBox(height: 16,),
                  OkuurSwitchButton(buttonCount: 2,buttonNames: ["Kendin Ekle","Kitabı Ara"],onChanged:  handleButtonChange,),
                  SizedBox(height: 12,),
                  BookInfo(),
                  SizedBox(height: 12,),
                  addBookState(context),
                  SizedBox(height: 12,),
                  addBookCurrentPage(context),
                  addBookFinishDate(context),
                  addBookReadingTime(context),
                  //SizedBox(height: 12,),
                  addBookImage(context),
                  SizedBox(height: 12,),
                  addBookInit(context),
                  //SizedBox(height: 12,),
                  AddBookButton(),
                  SizedBox(height: 12,)
                ],),
            ),
          ),
        ),
      ),
    );
  }

}