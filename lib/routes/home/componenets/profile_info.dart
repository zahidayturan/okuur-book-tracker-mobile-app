import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class HomeProfileInfo extends StatefulWidget {
  const HomeProfileInfo({super.key});

  @override
  State<HomeProfileInfo> createState() => _HomeProfileInfoState();
}

class _HomeProfileInfoState extends State<HomeProfileInfo> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Merhaba user_name"),
              Text("Bu ay 345 sayfa okudun")
            ],
          ),
          Container(
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.greenDark,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/social.png"),
            ),

          )
        ],
      ),
    );
  }
}