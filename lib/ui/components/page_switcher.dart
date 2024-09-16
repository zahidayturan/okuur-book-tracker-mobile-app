import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurPageSwitcher extends StatefulWidget {
  final int pageCount;
  final ValueChanged<int> onChanged;

  const OkuurPageSwitcher({
    super.key,
    required this.pageCount,
    required this.onChanged,
  });

  @override
  State<OkuurPageSwitcher> createState() => _OkuurPageSwitcherState();
}

class _OkuurPageSwitcherState extends State<OkuurPageSwitcher> {
  AppColors colors = AppColors();
  int currentOption = 0;

  Widget option(int index) {
    return Padding(
      padding: EdgeInsets.only(right: (index+1) != widget.pageCount ? 4 : 0),
      child: InkWell(
        onTap: () {
          setState(() {
            currentOption = index;
            widget.onChanged(currentOption);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: currentOption == index ? 6 : 10,
          width: currentOption == index ? 28 : 10,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: currentOption == index ? Theme.of(context).colorScheme.inversePrimary : colors.blueLight,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.pageCount, (index) {
          return option(index);
        }),
      ),
    );
  }
}
