import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<int> onChanged;

  const OkuurSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<OkuurSearchBar> createState() => _OkuurSearchBarState();
}

class _OkuurSearchBarState extends State<OkuurSearchBar> {
  AppColors colors = AppColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(54)),
        color: colors.white
      ),
      child: TextField(
        onTap: () {},
        style: TextStyle(
          fontSize: 14,
          color: colors.black
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintMaxLines: 1,
            isDense: true,
          hintStyle: TextStyle(
            fontSize: 14,
            color: colors.greenDark
          ),
            border: InputBorder.none,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset("assets/icons/search.png",height: 26),
            onPressed: () {
              widget.onChanged;
            },
          )
        ),
      ),
    );
  }
}