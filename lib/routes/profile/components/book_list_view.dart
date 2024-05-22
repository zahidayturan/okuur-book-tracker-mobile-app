import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/settings/settings.dart';

class BookListWidget extends StatefulWidget {

  //final OkuurUserInfo userData;

  const BookListWidget({
    Key? key,
    //required this.userData
  }) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {

  AppColors colors = AppColors();


  List<Map<String, String>> tempBookList = [
    {
      'id': '1',
      'name': 'Books 1',
      'author': 'Author 1',
      'page': '248',
      'currentPage': '120',
      'image': 'https://picsum.photos/250?image=9',
      'type': 'Type 1',
      'startDate': '15.05.2024',
      'endDate': '15.05.2024',
      'readTime': '254',
      'readingLogs': '4',
      'readStatus': '0',
    },
    {
      'id': '2',
      'name': 'Books 2',
      'author': 'Author 2',
      'page': '124',
      'currentPage': '124',
      'image': 'https://picsum.photos/250?image=8',
      'type': 'Type 2',
      'startDate': '14.05.2024',
      'endDate': '14.05.2024',
      'readTime': '155',
      'readingLogs': '5',
      'readStatus': '1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

      ],
    );
  }

  Container bookContainer(String url){
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
          color: colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(28))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(url),
      ),
    );
  }


  Container iconContainer(double width,double height,Color color,String path){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path),
      ),
    );
  }


  Text text(String text,Color color,double size, String family,int maxLines){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),overflow: TextOverflow.ellipsis,maxLines: maxLines,
    );
  }

}