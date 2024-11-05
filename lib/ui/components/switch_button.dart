import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurSwitchButton extends StatefulWidget {
  final int buttonCount;
  final List<String> buttonNames;
  final ValueChanged<int> onChanged;
  final int initValue;

  const OkuurSwitchButton({
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
            widget.onChanged(currentButton);
          });
        },
        child: AnimatedContainer(
          height: currentButton == index ? 28 : 36,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: currentButton == index ? const EdgeInsets.all(4) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: currentButton == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                color: currentButton == index ? colors.grey : Theme.of(context).colorScheme.secondary,
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
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
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
