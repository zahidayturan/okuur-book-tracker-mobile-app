import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import '../../../ui/components/rich_text.dart';

class LogNameInfo extends StatefulWidget {
  const LogNameInfo({Key? key,}) : super(key: key);

  @override
  State<LogNameInfo> createState() => _LogNameInfoState();
}

class _LogNameInfoState extends State<LogNameInfo> {
  AppColors colors = AppColors();

  final AddLogController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        formContent(),
      ],
    );
  }

  Widget formContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            texts: const ["Kayıt Ekleyeceğiniz ","Kitabı Seçiniz"],
            colors: [Theme.of(context).colorScheme.secondary],
            fontFamilies: const ["FontMedium","FontBold"],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              italicText("Okumakta olduğunuz kitaplardan seçim yapabilirsiniz."),
            ],
          ),
          const SizedBox(height: 12,),
          tempData.isNotEmpty ?
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: bookList())
              :
          notFoundBook()
        ],
      ),
    );
  }

  List<Map<String,String>> tempData = [
    {
      "id": "1",
      "name" : "Kralın Dönüşü",
      "image" : "https://picsum.photos/250?image=8"
    },
    {
      "id": "2",
      "name" : "Bir İdam Mahkumunun Son Günü",
      "image" : "https://picsum.photos/250?image=7"
    }
  ];

  int? selectedBookIndex;


  Widget bookList(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(tempData.length, (index) {
        return bookOption(tempData[index],index);
      }),
    );
  }

  Widget bookOption(Map<String,String> data,int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBookIndex = index;
        });
        controller.setLogBook(int.parse(data["id"].toString()));
      },
      child: Container(
        width: 90,
        margin: EdgeInsets.only(left: index != 0 ? 24 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  height: 126,
                  width: 90,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: selectedBookIndex == index ? Theme.of(context).colorScheme.inversePrimary : colors.grey,width: 2)
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    child: selectedBookIndex == index || selectedBookIndex == null
                        ? Image.network(
                      data["image"].toString(),
                      fit: BoxFit.cover,
                    )
                        : ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: Image.network(
                        data["image"].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  width: 28,
                  height: selectedBookIndex == index ? 28 : 0,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  child: selectedBookIndex == index ? Icon(Icons.check_rounded,color: colors.grey,) : null,
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Text(data["name"].toString(),style: TextStyle(fontSize: 12,color: selectedBookIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.secondary),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }

  Widget italicText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.secondary
      ),
    );
  }

  Widget notFoundBook(){
    return Container(
      padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Theme.of(context).primaryColor,
        ),
        child: Text("Bir kitabı okumuyorsunuz. Yeni kitap ekleyin veya eklediklerinizden birini okumaya başlayın",textAlign: TextAlign.center,style: TextStyle(color: colors.blue),));
  }
}