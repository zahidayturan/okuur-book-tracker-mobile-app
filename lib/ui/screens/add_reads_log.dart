import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/date_picker.dart';
import 'dart:ui';

import 'package:okuur/ui/components/icon_button.dart';
import 'package:okuur/ui/components/text_form_field.dart';

import '../components/clock_picker.dart';

class AddReadsPage extends StatefulWidget {

  const AddReadsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddReadsPage> createState() => _AddReadsPageState();
}

class _AddReadsPageState extends State<AddReadsPage> {

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

  Widget formContent(){
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
                  title("Okuduklarını Kaydet", colors.greenDark, 16, "FontBold"),
                  iconButton("assets/icons/close.png",colors.greenDark,context)
                ],
              ),
              SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bookForm(),
                  SizedBox(height: 16,),
                  pageForm(),
                  SizedBox(height: 16,),
                  dateForm(),
                  SizedBox(height: 16,),
                  clockForm(),
                  SizedBox(height: 16,),
                  timeForm()
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  title("142 -> 188", colors.greenDark, 14, "FontMedium"),
                  SizedBox(width: 12,),
                  Container(
                    width: 72,
                    height: 32,
                    decoration: BoxDecoration(
                        color: colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(child: title("Kaydet", colors.grey, 15, "FontMedium")),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _selectedBookKey = GlobalKey<FormState>();
  final TextEditingController _selectedBookController = TextEditingController();
  bool selectedBookValidate = true;
  Widget bookForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/books.png"),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title("Okunan Eser", colors.blue, 14, "FontMedium"),
              title("Seçildi", colors.lemon, 15, "FontMedium")
            ],
          )

        ],
      ),
    );
  }

  final _pageCountKey = GlobalKey<FormState>();
  final TextEditingController _pageCountController = TextEditingController();
  bool pageCountValidate = true;
  Widget pageForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/page.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTextFormField(
                label: "Sayfa Sayısı",
                hint:  "Giriniz",
                controller: _pageCountController,
                key: _pageCountKey
            ).getTextFormFieldForPage(),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",pageCountValidate),
        ],
      ),
    );
  }

  final _dateKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  bool dateValidate = true;
  Widget dateForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/calendar.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurDateTimePicker(
                controller: _dateController,
                formKey: _dateKey
            ),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",dateValidate),

        ],
      ),
    );
  }

  final _clockKey = GlobalKey<FormState>();
  final TextEditingController _clockController = TextEditingController();
  bool clockValidate = true;
  Widget clockForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/clock.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTimePicker(
                controller: _clockController,
                formKey: _clockKey
            ),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",clockValidate),

        ],
      ),
    );
  }

  final _timeKey = GlobalKey<FormState>();
  final TextEditingController _timeController = TextEditingController();
  bool timeValidate = true;
  Widget timeForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/time.png"),
          SizedBox(width: 8,),
          Expanded(
            child: OkuurTextFormField(
                label: "Okuma Süresi",
                hint:  "Giriniz",
                controller: _timeController,
                key: _timeKey
            ).getTextFormFieldForPage(),
          ),
          SizedBox(width: 8,),
          errorIcon("assets/icons/error.png",timeValidate),

        ],
      ),
    );
  }

  Text title(String text,Color color,double size, String family){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),
    );
  }

  Container formIcon(String path) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
          color: colors.green,
          shape: BoxShape.circle
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path),
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