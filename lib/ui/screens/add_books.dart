import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'dart:ui';
import 'package:okuur/ui/components/icon_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_form_field.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    color: colors.white.withOpacity(0.4),
                  ),
                ),
              ),
              formContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget formContent() {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colors.grey,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colors.greyDark.withOpacity(0.4),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text("Yeni Kitap Ekle", colors.greenDark, 16, "FontBold",1),
                  iconButton(
                      "assets/icons/close.png", colors.greenDark, context)
                ],
              ),
              SizedBox(
                height: 16,
              ),
              nameForm(), //nameForm(),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child:
                          text("Kitabı Ekle", colors.grey, 15, "FontMedium",1),
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/books.png"),
          SizedBox(width: 8,),
          Expanded(
            child: getTextFormFieldForPage(),
          )
        ],
      ),
    );
  }

  Container formIcon(String path) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(color: colors.blue, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path),
      ),
    );
  }
}
