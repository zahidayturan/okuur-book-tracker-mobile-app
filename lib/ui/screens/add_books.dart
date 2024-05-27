import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/dropdown_menu.dart';
import 'dart:ui';
import 'package:okuur/ui/components/icon_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/switch_button.dart';
import 'package:okuur/ui/components/text_form_field.dart';
import 'package:okuur/ui/const/book_type_list.dart';
import 'package:okuur/ui/utils/validator.dart';

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

  int currentButtonIndex = 0;

  void handleButtonChange(int newButton) {
    setState(() {
      currentButtonIndex = newButton;
    });
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
                  iconButton("assets/icons/close.png", colors.greenDark, context)
                ],
              ),
              SizedBox(height: 16,),
              OkuurSwitchButton(buttonCount: 2,buttonNames: ["Kendin Ekle","Kitabı Ara"],onChanged:  handleButtonChange,),
              SizedBox(height: 16,),
              Visibility(
                visible: currentButtonIndex == 0,
                child: Column(
                  children: [
                    nameForm(), //nameForm(),
                    SizedBox(height: 16,),
                    authorForm(),
                    SizedBox(height: 16,),
                    pageForm(),
                    SizedBox(height: 16,),
                    typeForm(),
                    SizedBox(height: 16,),
                    imageForm(),
                  ],
                ),
              ),
              Visibility(
                  visible: currentButtonIndex == 1,
                  child: SizedBox(height: 254,child: Center(child: Text("Not yet")),)),

              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        bookNameValidate = OkuurValidator.basicValidate(_bookNameController.text);
                        bookAuthorValidate = OkuurValidator.basicValidate(_bookAuthorController.text);
                        bookPageValidate = OkuurValidator.basicValidate(_bookPageController.text);
                        bookTypeValidate = OkuurValidator.compareValidate(_bookTypeController.text,bookTypeList.first);
                      });
                      if(bookNameValidate == true &&
                          bookAuthorValidate == true &&
                          bookPageValidate == true &&
                          bookTypeValidate == true){
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                          color: colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child:
                            text("Kitabı Ekle", colors.grey, 15, "FontMedium",1),
                      )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _bookNameKey = GlobalKey<FormState>();
  final TextEditingController _bookNameController = TextEditingController();
  bool bookNameValidate = true;
  Widget nameForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/books.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTextFormField(
                label: "Kitabın Adı",
                hint: "Adını yazınız",
                controller: _bookNameController,
              key: _bookNameKey
            ).getTextFormFieldForPage(),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",bookNameValidate),

        ],
      ),
    );
  }

  final _bookAuthorKey = GlobalKey<FormState>();
  final TextEditingController _bookAuthorController = TextEditingController();
  bool bookAuthorValidate = true;
  Widget authorForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/people.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTextFormField(
                label: "Kitabın Yazarı",
                hint:  "Yazarını yazınız",
                controller: _bookAuthorController,
                key: _bookAuthorKey
            ).getTextFormFieldForPage(),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",bookAuthorValidate),

        ],
      ),
    );
  }

  final _bookPageKey = GlobalKey<FormState>();
  final TextEditingController _bookPageController = TextEditingController();
  bool bookPageValidate = true;
  Widget pageForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/page.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTextFormField(
                label: "Kitabın Sayfa Sayısı",
                hint:  "Sayfa sayısını yazınız",
                controller: _bookPageController,
                key: _bookPageKey
            ).getTextFormFieldForPage(),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",bookPageValidate),

        ],
      ),
    );
  }

  final _bookTypeKey = GlobalKey<FormState>();
  final TextEditingController _bookTypeController = TextEditingController();
  bool bookTypeValidate = true;
  Widget typeForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/list.png"),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Kitabın Türü",colors.blue,13,"FontMedium",1),
                OkuurDropdownMenu(
                    controller: _bookTypeController,
                    key: _bookTypeKey,
                  list: bookTypeList
                ),
              ],
            ),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",bookTypeValidate),

        ],
      ),
    );
  }

  Widget imageForm() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          formIcon("assets/icons/add_box.png"),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Kitabın Kapak Fotoğrafı",colors.blue,13,"FontMedium",1),
                text("Yüklemek için dokunun",colors.greyDark,15,"FontMedium",1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container formIcon(String path) {
    return Container(
      height: 38,
      width: 38,
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(color: colors.blue, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(path,color: colors.white,),
      ),
    );
  }

  AnimatedContainer errorIcon(String path,bool validate) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: validate == true ? 0 : 34,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path,color: colors.red,),
      ),
    );
  }
}
