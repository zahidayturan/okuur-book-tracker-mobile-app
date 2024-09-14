import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/services/operations/book_operations.dart';
import 'package:okuur/routes/library/components/book_container.dart';
import 'package:okuur/ui/components/rich_text.dart';

class BookListLibrary extends StatefulWidget {

  final int buttonIndex;

  const BookListLibrary({
    Key? key,
    required this.buttonIndex
  }) : super(key: key);

  @override
  State<BookListLibrary> createState() => _BookListLibraryState();
}

class _BookListLibraryState extends State<BookListLibrary> {

  AppColors colors = AppColors();
  final BookOperations bookOperations = BookOperations();


  List<OkuurBookInfo> currentBooks = [];
  List<OkuurBookInfo> futureBooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    List<OkuurBookInfo> books = await bookOperations.getBookInfo();
    List<OkuurBookInfo> current = [];
    List<OkuurBookInfo> future = [];
    List<OkuurBookInfo> past = [];

    for (var book in books) {
      int readStatus = book.status;
      if(readStatus == 0){
        future.add(book);
      }else if(readStatus %2 == 1) {
        current.add(book);
      } else {
        past.add(book);
      }
    }

    setState(() {
      currentBooks = {...current, ...past}.toList();
      futureBooks = future;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(widget.buttonIndex == 0 && currentBooks.isEmpty){
      return infoBox("Henüz bir kitap okumaya başlamadınız.\nDaha önce eklediğiniz kitaplardan bir tanesini okumaya başlayın veya bir ","kitap ekleyin",false);
    }
    if(widget.buttonIndex == 1 && futureBooks.isEmpty){
      return infoBox("Okumayı planladığınız bir kitap yok.\nOkumaya başlamak için bir ","kitap ekleyin.",true);
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.buttonIndex == 0 ? currentBooks.length : futureBooks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: bookContainerLibrary(
            widget.buttonIndex == 0 ? currentBooks[index] : futureBooks[index],
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