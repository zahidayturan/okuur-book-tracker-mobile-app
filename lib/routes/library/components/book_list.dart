import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/routes/library/components/book_container.dart';
import 'package:okuur/ui/components/rich_text.dart';

class BookListLibrary extends StatefulWidget {

  final int buttonIndex;
  final List<OkuurBookInfo> bookList;

  const BookListLibrary({
    Key? key,
    required this.buttonIndex,
    required this.bookList,
  }) : super(key: key);

  @override
  State<BookListLibrary> createState() => _BookListLibraryState();
}

class _BookListLibraryState extends State<BookListLibrary> {

  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();


  @override
  Widget build(BuildContext context) {
    if(widget.buttonIndex == 0 && widget.bookList.isEmpty){
      return infoBox("Henüz bir kitap okumaya başlamadınız.\nDaha önce eklediğiniz kitaplardan bir tanesini okumaya başlayın veya bir ","kitap ekleyin",false);
    }
    if(widget.buttonIndex == 1 && widget.bookList.isEmpty){
      return infoBox("Okumayı planladığınız bir kitap yok.\nOkumaya başlamak için bir ","kitap ekleyin.",true);
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.bookList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: bookContainerLibrary(
            widget.bookList[index],
            "${index + 1}",
          ),
        );
      },
    );
  }
  
  Column infoBox(String text,String boldText,bool isRight){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: Stack(
            children: [
                  Positioned(
                      top: -8,
                      child: Icon(Icons.book_rounded,color: colors.grey,size: 64,)),
                  Center(
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                      child: RichTextWidget(
                      texts: [text,boldText],
                      colors: [colors.black,colors.green],
                      fontFamilies: ["FontMedium","FontBold"],
                      fontSize: 14,
                      align: TextAlign.center),
                    ),
                  ),
                ],
          )
        ),
      ],
    );
  }

}