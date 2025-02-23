import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/book_detail_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';
import 'package:okuur/routes/bookDetail/components/book_record_edit.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
import 'package:okuur/ui/components/regular_text.dart';
import 'package:okuur/ui/utils/date_formatter.dart';


class BookRecordsDetail extends StatefulWidget {

  const BookRecordsDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<BookRecordsDetail> createState() => _BookRecordsDetailState();
}

class _BookRecordsDetailState extends State<BookRecordsDetail> {

  BookDetailController controller = Get.find();
  int selectedItem = 0;
  AppColors colors = AppColors();

  String getParsedDate(String date){
    DateTime fDate = OkuurDateFormatter.stringToDateTime(date);
    return '${fDate.day}\n${fDate.month}';
  }

  bool logDeletionAvailability = true;


  Widget bookRecords(List<OkuurLogInfo> logs) {
    int selectedPage = logs.isNotEmpty ? logs[selectedItem].numberOfPages : 0;
    int selectedTime = logs.isNotEmpty ? logs[selectedItem].timeRead : 0;

    String points = ((2 * selectedTime * selectedPage) / (selectedTime + (selectedPage+1))).toStringAsFixed(0);

    DateTime bookStartingDate = OkuurDateFormatter.stringToDateTime(controller.okuurBookInfo!.startingDate);
    bool isReading = controller.okuurBookInfo!.status % 2 == 1;
    DateTime selectedLogDate = OkuurDateFormatter.stringToDateTime(logs[selectedItem].readingDate);
    logDeletionAvailability =  isReading && bookStartingDate.isBefore(selectedLogDate);
    return logs.isNotEmpty ? BaseContainer(
      radius: 12,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(texts: "Okumaların", style: FontStyle.italic),
              RegularText(texts: "${logs.length} kayıt", size: "m"),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: logs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                      DateTime selectedLogDate = OkuurDateFormatter.stringToDateTime(logs[selectedItem].readingDate);
                      logDeletionAvailability =  isReading && bookStartingDate.isBefore(selectedLogDate);
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    height: 60,
                    constraints: const BoxConstraints(minWidth: 40),
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
                        texts: getParsedDate(logs[index].readingDate),
                        align: TextAlign.center,
                        size: "m",
                        maxLines: 2,
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
                RegularText(texts: OkuurDateFormatter.convertDate(logs[selectedItem].readingDate)),
                RegularText(texts: "$selectedPage sayfa / $selectedTime dakika / $points puan"),
                Visibility(
                  visible: logDeletionAvailability,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            controller.editRecordInit(logs[selectedItem],controller.okuurBookInfo!);
                            showBookRecordEditDialog(context,logs[selectedItem],controller.okuurBookInfo!);
                          },
                          child: opButton(
                            "Düzenle",
                            Icons.edit_rounded,
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            bool shouldExit = await _showCustomDialog("Okuma kaydı silinecektir.\nOnaylıyor musunuz?");
                            if (shouldExit) {
                              controller.deleteLogInfo(logs[selectedItem]);
                              setState(() {
                                controller.isLogChanged.value = true;
                              });
                            }
                          },
                          child: opButton(
                              "Okuma Kaydını Sil",
                              Icons.delete_outline_rounded,
                              colors.red),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ) : const SizedBox();
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

  Future<bool> _showCustomDialog(String text) async {
    bool? result = await OkuurAlertDialog.show(
      context: context,
      contentText: text,
      buttons: [
        AlertButton(text: "Geri Dön", fill: false, returnValue: false),
        AlertButton(text: "Sil", fill: true, returnValue: true),
      ],
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return bookRecords(controller.logs);
  }
}