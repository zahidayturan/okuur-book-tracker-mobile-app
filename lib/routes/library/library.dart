import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/library_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addBook/add_book.dart';
import 'package:okuur/routes/library/components/book_list.dart';
import 'package:okuur/ui/components/action_button.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/search_bar.dart';
import 'package:okuur/ui/components/switch_button.dart';
import 'package:okuur/ui/utils/device_utils.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  AppColors colors = AppColors();

  LibraryController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchBooks();
  }

  void handleButtonChange(int newButton) {
    setState(() {
      controller.setPageCurrentMode(newButton);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: SizedBox(
          height: OkuurDeviceUtils.getScreenHeight(),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        PageHeaderTitle(
                            title: "Kitaplığın",
                            pathName: "library",
                            subtitle: "Kitaplarınızı görüntüleyin, düzenleyin\nve yenilerini ekleyin"
                        ).getTitle(context),
                        const SizedBox(height: 16),
                        Obx(() => OkuurSwitchButton(
                          buttonCount: 2,
                          buttonNames: const ["Okuduklarınız", "Okuyacaklarınız"],
                          onChanged: handleButtonChange,
                          initValue: controller.pageCurrentMode.value,
                        ),),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Visibility(
                              visible: controller.pageCurrentMode.value == 0
                                  ? controller.currentBooks.isNotEmpty
                                  : controller.futureBooks.isNotEmpty,
                              child: Row(
                                children: [
                                  OkuurActionButton(path: "sort", color: Theme.of(context).colorScheme.onPrimaryContainer, onChanged: (value) {}),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            )),
                            Expanded(
                              child: OkuurSearchBar(
                                hintText: "Kitap veya yazar arayın",
                                onChanged: (value) {},
                                readOnly: controller.pageCurrentMode.value == 0
                                    ? controller.currentBooks.isEmpty
                                    : controller.futureBooks.isEmpty,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return CircularProgressIndicator(color: colors.orange,);
                          } else {
                            return BookListLibrary(
                              buttonIndex: controller.pageCurrentMode.value,
                              bookList: controller.pageCurrentMode.value == 0
                                  ? controller.currentBooks
                                  : controller.futureBooks,
                            );
                          }
                        }),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                addButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton(){
    return Positioned(
      right: 0,
      bottom: 12,
      child: InkWell(
        onTap: () {
          Navigator.push(
            Get.context!,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, animation, nextanim) => const AddBookPage(),
              reverseTransitionDuration: const Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        highlightColor: colors.orange,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: colors.orange,
            shape: BoxShape.circle
          ),
          child: Icon(Icons.add_rounded,color: colors.grey,size: 28),
        ),
      ),
    );
  }
}