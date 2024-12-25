import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/bookDetail/components/book_detail_loading.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/image_shower.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/components/text_and_icon_button.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  AppColors colors = AppColors();

  BookDetailController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getBookDetail();
  }

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
            child: Center(
              child: Obx(() => controller.detailLoading.value
                  ? bookDetailLoadingBox(context)
                  : Column(
                  children: [
                    const SizedBox(height: 12),
                    bookMiniInfo(),
                    const SizedBox(height: 18),
                    totalRead(),
                    const SizedBox(height: 18,),
                    bookPageState(),
                    const SizedBox(height: 18,),
                    bookGoal(),
                    const SizedBox(height: 18,),
                    bookRecords(),
                    const SizedBox(height: 18,)
                  ],
                ),
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
                  size: "xl",
                  maxLines: 2,
                  weight: FontWeight.w700),
              const RegularText(
                  texts: "J.R.R. Tolkien",
                  size: "m",
                  style: FontStyle.italic),
              const RegularText(
                texts: "Roman - 360 sayfa",
                size: "m",
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
              RegularText(texts: "240. sayfadasın",size: "m")
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
                  RegularText(texts:"%${rate.toString()}", color: Theme.of(context).colorScheme.inversePrimary,size:"m"),
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
              RegularText(texts: "12 gün",size: "m")
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
              const RegularText(texts: "Başlangıç 22.11.2024",size: "s"),
              RegularText(texts: "Kalan 8 gün",size: "m",color: colors.orange,)
            ],
          ),
        ],
      ),
    );
  }
  int selectedItem = 0;
  List<String> lists = [
    "28.11\n2024", "27.11\n2024", "26.11\n2024",
    "25.11\n2024", "24.11\n2024", "23.11\n2024"
  ];

  Widget bookRecords() {
    return BaseContainer(
      radius: 12,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(texts: "Okumaların", style: FontStyle.italic),
              RegularText(texts: "8 kayıt", size: "m"),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: lists.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedItem == index
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(selectedItem == index ? 16 : 8),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    child: Center(
                      child: RegularText(
                        texts: lists[index],
                        align: TextAlign.center,
                        size: "m",
                        maxLines: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          BaseContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RegularText(texts: "Seçili Okuma Detayı",style: FontStyle.italic,size: "m",),
                    Icon(Icons.info_outline_rounded,size: 16,color: Theme.of(context).colorScheme.secondary)
                  ],
                ),
                const SizedBox(height: 4),
                RegularText(texts: lists[selectedItem]),
                const RegularText(texts: "48 sayfa / 40 dakika / 40 puan"),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    opButton(
                      "Düzenle",
                      Icons.edit_rounded,
                      Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    opButton(
                        "Okuma Kaydını Sil",
                        Icons.delete_outline_rounded,
                        colors.red)
                  ],
                )
              ],
            ),
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
          const RegularText(texts: "Toplam Okuma",style: FontStyle.italic),
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
            RegularText(texts:count, color: Theme.of(context).colorScheme.secondary, size: "m"),
            RegularText(texts:text, color: Theme.of(context).colorScheme.secondary, size: "xs"),
          ],
        )
      ],
    );
  }

  Widget opButton(String text,IconData icon,Color iconColor){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      child: Row(
        children: [
          Icon(icon,size: 16,color: iconColor),
          const SizedBox(width: 4),
          RegularText(texts: text,color: iconColor,size: "m")
        ],
      ),
    );
  }
}
