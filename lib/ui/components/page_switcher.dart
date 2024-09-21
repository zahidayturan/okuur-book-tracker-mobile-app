import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurPageSwitcher extends StatefulWidget {
  final int pageCount;
  final int currentPage;

  const OkuurPageSwitcher({
    super.key,
    required this.pageCount,
    required this.currentPage
  });

  @override
  State<OkuurPageSwitcher> createState() => _OkuurPageSwitcherState();
}

class _OkuurPageSwitcherState extends State<OkuurPageSwitcher> {
  AppColors colors = AppColors();

  Widget option(int index) {
    return Padding(
      padding: EdgeInsets.only(right: (index+1) != widget.pageCount ? 4 : 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: widget.currentPage == index ? 8 : 6,
        width: widget.currentPage == index ? 8 : 6,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: widget.currentPage == index ? Theme.of(context).colorScheme.inversePrimary : colors.blueLight,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
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
