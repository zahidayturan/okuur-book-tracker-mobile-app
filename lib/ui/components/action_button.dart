import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';


class OkuurActionButton extends StatefulWidget {
  final String path;
  final Color color;
  final ValueChanged<int> onChanged;

  const OkuurActionButton({
    super.key,
    required this.path,
    required this.color,
    required this.onChanged,
  });

  @override
  State<OkuurActionButton> createState() => _OkuurActionButtonState();
}

class _OkuurActionButtonState extends State<OkuurActionButton> {
  AppColors colors = AppColors();
  bool turnController = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged;
        setState(() {
          turnController = !turnController;
        });
      },
      borderRadius: BorderRadius.all(Radius.circular(5)),
      highlightColor: widget.color,
      child: AnimatedRotation(
        turns: turnController == true ? 0 : 0.5,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/icons/${widget.path}.png"),
          ),
        ),
      ),
    );
  }
}