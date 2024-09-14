import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurSwitchButton extends StatefulWidget {
  final int buttonCount;
  final List<String> buttonNames;
  final ValueChanged<int> onChanged;
  final int initValue;

  OkuurSwitchButton({
    super.key,
    required this.buttonCount,
    required this.buttonNames,
    required this.onChanged,
    this.initValue = 0
  });

  @override
  State<OkuurSwitchButton> createState() => _OkuurSwitchButtonState();
}

class _OkuurSwitchButtonState extends State<OkuurSwitchButton> {
  AppColors colors = AppColors();
  int currentButton = 0;

  @override
  void initState() {
    super.initState();
    currentButton = widget.initValue;
  }

  Widget button(String name, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentButton = index;
            widget.onChanged(currentButton); // currentButton değiştiğinde callback'i çağır
          });
        },
        child: AnimatedContainer(
          height: 36,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: currentButton == index ? colors.blue : colors.blueLight,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: colors.blueLight,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        Row(
          children: List.generate(widget.buttonCount, (index) {
            return button(widget.buttonNames[index], index);
          }),
        ),
      ],
    );
  }
}
