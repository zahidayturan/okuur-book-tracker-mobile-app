import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';


class OkuurDropdownMenu extends StatefulWidget {

  final List<String> list;
  final TextEditingController controller;

  const OkuurDropdownMenu({
    super.key,
    required this.list,
    required this.controller,
  });

  @override
  State<OkuurDropdownMenu> createState() => _OkuurDropdownMenuState();
}

class _OkuurDropdownMenuState extends State<OkuurDropdownMenu> {

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.list.first;
  }
  @override
  Widget build(BuildContext context) {
    AppColors colors = AppColors();
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.controller.text,
        dropdownColor: colors.white,
        iconEnabledColor: colors.black,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,size: 22),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        menuMaxHeight: 180,
        items: widget.list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(fontSize: 15,fontFamily: "FontMedium",color: colors.black)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.controller.text = value!;
          });
        },
      ),
    );
  }
}

