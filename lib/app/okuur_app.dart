import 'package:flutter/material.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/library/library.dart';
import 'package:okuur/routes/social/social.dart';
import 'package:okuur/routes/statistics/statistics.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';


class OkuurApp extends StatefulWidget {

  final int pageIndex;

  const OkuurApp({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  @override
  State<OkuurApp> createState() => _OkuurAppState();
}


class _OkuurAppState extends  State<OkuurApp> {


  Future<void> loadData()  async {

  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    Widget setWidget(){
      if(widget.pageIndex == 0){
        return HomePage();
      }else if(widget.pageIndex == 1){
        return StatisticsPage();
      }else if(widget.pageIndex == 2){
        return SocialPage();
      }else if(widget.pageIndex == 3){
        return LibraryPage();
      }else if(widget.pageIndex == 4){
        return StatisticsPage();
      }else{
        return HomePage();
      }
    }
    return SafeArea(
      child: Scaffold(
        body : setWidget(),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: true == true ? BottomNavBar(pageIndex: widget.pageIndex,) : null,
      ),
    );
  }
}