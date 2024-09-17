import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<int> onChanged;
  final bool readOnly;

  const OkuurSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.readOnly = false
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
        color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      child: TextField(
        onTap: () {},
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.secondary
        ),
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintMaxLines: 1,
            isDense: true,
          hintStyle: TextStyle(
            fontSize: 14,
            color: widget.readOnly ? colors.blueLight : Theme.of(context).colorScheme.primaryContainer
          ),
            border: InputBorder.none,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset("assets/icons/search.png",height: 26,color: widget.readOnly ? colors.blueLight : Theme.of(context).colorScheme.primaryContainer),
            onPressed: () {
              widget.onChanged;
            },
          )
        ),
      ),
    );
  }
}