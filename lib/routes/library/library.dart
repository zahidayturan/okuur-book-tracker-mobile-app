import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/switch_button.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

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
                  PageHeaderTitle(
                      title: "Kitaplığın",
                      pathName: "library",
                      subtitle: "Kitaplarınızı görüntüleyin, düzenleyin\nve yenilerini ekleyin",
                      otherWidget: true).getTitle(),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: OkuurSwitchButton(buttonCount: 2,buttonNames: ["Okuduklarınız","Okuyacaklarınız"],onChanged:  handleButtonChange,),
                  ),
                  SizedBox(height: 16,),
                ],),
            ),
          ),
        ),
      ),
    );
  }
}