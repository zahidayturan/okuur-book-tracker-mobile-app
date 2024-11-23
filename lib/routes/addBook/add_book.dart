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
import 'package:okuur/ui/components/rich_text.dart';
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
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  addBookAppBar(context),
                  const SizedBox(height: 16,),
                  OkuurSwitchButton(buttonCount: 2,buttonNames: const ["Kendin Ekle","Kitabı Ara"],onChanged:  handleButtonChange,),
                  const SizedBox(height: 12,),
                  currentButtonIndex == 0 ?
                  Column(
                    children: [
                      const BookInfo(),
                      const SizedBox(height: 12,),
                      addBookState(context),
                      const SizedBox(height: 12,),
                      addBookCurrentPage(context),
                      addBookFinishDate(context),
                      addBookReadingTime(context),
                      //SizedBox(height: 12,),
                      addBookImage(context),
                      const SizedBox(height: 12,),
                      addBookInit(context),
                      //SizedBox(height: 12,),
                      const AddBookButton(),
                      const SizedBox(height: 12,)
                    ],
                  ) : 
                  Column(
                    children: [
                      const SizedBox(height: 12,),
                      RichTextWidget(
                          texts: const ["Bu özellik ","Okuur+ ","aboneliği gerektirir"],
                          colors: [Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.inversePrimary,Theme.of(context).colorScheme.secondary],
                          fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                      )
                    ],
                  ),

                ],),
            ),
          ),
        ),
      ),
    );
  }

}