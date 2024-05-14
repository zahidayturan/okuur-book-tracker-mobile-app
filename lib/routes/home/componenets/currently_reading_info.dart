import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import '../../../ui/components/rich_text.dart';

class CurrentlyReadingInfo extends StatefulWidget {


  final String bookName;
  final int currentPage;
  final int bookPage;

  const CurrentlyReadingInfo({
    Key? key,
    required this.bookName,
    required this.currentPage,
    required this.bookPage,
  }) : super(key: key);

  @override
  State<CurrentlyReadingInfo> createState() => _CurrentlyReadingInfoState();
}

class _CurrentlyReadingInfoState extends State<CurrentlyReadingInfo> {

  AppColors colors = AppColors();

  int rate = 0;


  @override
  Widget build(BuildContext context) {
    if(widget.bookPage > 0 && (widget.currentPage < widget.bookPage)){
        rate = ((widget.currentPage / widget.bookPage)*100).toInt();
    }else if(widget.currentPage > widget.bookPage){
      rate = 100;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            texts: ['Okunan ', '${widget.bookName}'],
            colors: [colors.black, colors.black],
            fontSize: 14,
            fontFamilies: ['FontBold', 'FontMedium'],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichTextWidget(
                texts: ["${widget.currentPage}/${widget.bookPage}"],
                colors: [colors.black],
                fontSize: 13,
                fontFamilies: ['FontMedium'],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double outerContainerWidth = constraints.maxWidth;
                      double innerContainerWidth = outerContainerWidth * (rate/100);

                      return Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: colors.greenDark,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 2,
                              width: innerContainerWidth,
                              decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              RichTextWidget(
                texts: ["%${rate}"],
                colors: [colors.black],
                fontSize: 13,
                fontFamilies: ['FontBold'],
              ),
            ],
          )

        ],
      ),
    );
  }
}