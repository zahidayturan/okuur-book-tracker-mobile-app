import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/text_and_icon_button.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  bookMiniInfo(),
                  const SizedBox(height: 18),
                  bookPageState(),
                  const SizedBox(height: 18,),
                  bookGoal(),
                  const SizedBox(height: 18,),
                  bookRecords(),
                  const SizedBox(height: 18,),
                  totalRead(),
                  const SizedBox(height: 18,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bookMiniInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 164,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              popButton(context),
              const SizedBox(height: 8),
              const RegularText(
                  texts: "Kralın Dönüşü",
                  size: 16,
                  maxLines: 2,
                  weight: FontWeight.w700),
              const RegularText(
                  texts: "J.R.R. Tolkien",
                  size: 13,
                  style: FontStyle.italic,
                  maxLines: 1),
              const RegularText(
                texts: "Roman - 360 sayfa",
                size: 13,
                maxLines: 1,
              ),
              const Spacer(),
              Row(
                children: [
                  TextIconButton(
                    text: "Düzenle",
                    icon: Icons.edit_rounded,
                    backColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  TextIconButton(
                      text: "Sil",
                      icon: Icons.delete_outline_rounded,
                      iconColor: colors.red)
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
            width: 112,
            height: 164,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            child: imageShower("none")),
      ],
    );
  }

  Widget bookPageState(){
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Bu Kitabı Okuyorsun",style: FontStyle.italic),
              RegularText(texts: "240. sayfadasın",size: 13)
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              double outerContainerHeight = constraints.maxWidth;
              int rate = 50;
              double innerContainerWidth = outerContainerHeight * (rate/100);
              return Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 18,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: innerContainerWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RegularText(texts:"%${rate.toString()}", color: Theme.of(context).colorScheme.inversePrimary,size: 13),
                ],
              );
            },
          ),

        ],
      ),
    );
  }

  Widget bookGoal(){
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Bitirme Hedefin",style: FontStyle.italic),
              RegularText(texts: "12 gün",size: 13)
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              double outerContainerHeight = constraints.maxWidth;
              int rate = 33;
              double innerContainerWidth = outerContainerHeight * (rate/100);
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: innerContainerWidth,
                        decoration: BoxDecoration(
                          color: colors.orange,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(texts: "Başlangıç 22.11.2024",size: 12),
              RegularText(texts: "Kalan 8 gün",size: 13,color: colors.orange,)
            ],
          ),
        ],
      ),
    );
  }
  int selectedItem = 0;
  List<String> lists = ["23.11\n2024\nCuma", "24.11\n2024\nCtsi", "25.11\n2024\nPzar","23.11\n2024\nCuma", "24.11\n2024\nCtsi", "25.11\n2024\nPzar"];

  Widget bookRecords() {
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Okumaların", style: FontStyle.italic),
              RegularText(texts: "8 kayıt", size: 13),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 124,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: lists.length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 400),
                          height: 124,
                          width: selectedItem == index ? 12 : 0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedItem = index;
                            });
                          },
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            width: 58,
                            height: 72,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selectedItem == index ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).colorScheme.onPrimaryContainer,
                              borderRadius: BorderRadius.circular(selectedItem == index ? 16 : 8),
                              border: Border.all(width: 1,color: Theme.of(context).scaffoldBackgroundColor)
                            ),
                            child: Center(
                              child: RegularText(
                                texts: lists[index],
                                align: TextAlign.center,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              BaseContainer(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 32,
                  radius: 16,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RegularText(texts: "48 sayfa"),
                      RegularText(texts: "40 dakika"),
                      RegularText(texts: "40 puan")
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalRead(){
    return BaseContainer(
      radius: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegularText(texts: "Toplam Okuma",style: FontStyle.italic),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconAndText("assets/icons/page.png", "sayfa","240"),
              iconAndText("assets/icons/clock.png", "dakika","254"),
              iconAndText("assets/icons/point.png", "puan","360"),
            ],),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Row iconAndText(String path,String text,String count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor
          ),
          padding: const EdgeInsets.all(5),
          child: Image.asset(path,color: Theme.of(context).colorScheme.secondary,),
        ),
        const SizedBox(width: 4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(texts:count, color: Theme.of(context).colorScheme.secondary, size: 13),
            RegularText(texts:text, color: Theme.of(context).colorScheme.secondary, size: 11),
          ],
        )
      ],
    );
  }
}
