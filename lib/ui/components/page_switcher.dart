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
          color: widget.currentPage == index ? Theme.of(context).colorScheme.secondary : colors.greyMid,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }

  Widget dots({int dotCount = 2}) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Row(
        children: List.generate(dotCount, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 2,
              height: 2,
              decoration: BoxDecoration(
                color: colors.greyMid,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }),
      ),
    );
  }


  Widget buildDotsAndOptions() {
    if (widget.pageCount <= 7) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.pageCount, (index) {
          return option(index);
        }),
      );
    } else {
      if (widget.currentPage <= 4) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(5, (index) => option(index)),
            dots(),
            ...List.generate(2, (index) => option(widget.pageCount - 2 + index)),
          ],
        );
      } else if (widget.currentPage > 3 && widget.currentPage < widget.pageCount - 3) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(2, (index) => option(index)),
            dots(),
            ...List.generate(3, (index) => option(widget.currentPage - 1 + index)),
            dots(),
            ...List.generate(2, (index) => option(widget.pageCount - 2 + index)),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(2, (index) => option(index)),
            dots(),
            ...List.generate(5, (index) => option(widget.pageCount - 5 + index)),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.pageCount > 1,
      child: SizedBox(
        height: 10,
        child: buildDotsAndOptions(),
      ),
    );
  }
}
