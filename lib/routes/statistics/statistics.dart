import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';
import 'package:okuur/ui/components/page_header.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  AppColors colors = AppColors();

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
                      textColor: colors.greenDark,
                      miniTextColor: colors.black,
                      iconName: "statistics").getTitle()


                ],
              ),
            ),
          ),
        ),
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