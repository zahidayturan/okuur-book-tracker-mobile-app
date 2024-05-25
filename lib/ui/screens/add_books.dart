import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'dart:ui';

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
                  title("Yeni Kitap Ekle", colors.greenDark, 16, "FontBold"),
                  iconButton("assets/icons/close.png")
                ],
              ),
              SizedBox(height: 16,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bookForm(),
                        SizedBox(height: 16,),
                        selectedBookInfo()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        pageForm(),
                        SizedBox(height: 16,),
                        dateForm(),
                        SizedBox(height: 16,),
                        clockForm(),
                        SizedBox(height: 16,),
                        timeForm()
                      ],
                    ),
                  )
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

  Widget pageForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/page.png"),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title("Sayfa Sayısı", colors.blue, 14, "FontMedium"),
              title("40", colors.black, 15, "FontMedium")
            ],
          )

        ],
      ),
    );
  }

  Widget dateForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/calendar.png"),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title("Tarih", colors.blue, 14, "FontMedium"),
              title("8.05.2024", colors.black, 15, "FontMedium")
            ],
          )

        ],
      ),
    );
  }

  Widget clockForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/clock.png"),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title("Bitirme Saati", colors.blue, 14, "FontMedium"),
              title("18:55", colors.black, 15, "FontMedium")
            ],
          )

        ],
      ),
    );
  }

  Widget timeForm(){
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          formIcon("assets/icons/time.png"),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title("Okuma Süresi", colors.blue, 14, "FontMedium"),
              title("25 dk", colors.black, 15, "FontMedium")
            ],
          )

        ],
      ),
    );
  }

  Widget selectedBookInfo(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title("Kralın Dönüşü", colors.black, 14, "FontMedium"),
          title("J.R.R. Tolkien", colors.black, 12, "FontMedium"),
          title("Roman / 240 sayfa", colors.black, 12, "FontMedium"),
          SizedBox(height: 12,),
          Container(
            width: 16,
            height: 4,
            decoration: BoxDecoration(
                color: colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
          title("142.sayfada kalmıştınız", colors.black, 11, "FontMedium"),
          SizedBox(height: 12,),
          Container(
            width: 16,
            height: 4,
            decoration: BoxDecoration(
                color: colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
          title("Son okuduğunuz eser otomatik seçildi, değiştirmek için dokunun", colors.black, 11, "FontMedium"),
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

  Container iconButton(String path){
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          color: colors.greenDark,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path),
      ),
    );
  }
}