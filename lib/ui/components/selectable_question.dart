import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class OkuurSelectableQuestion extends StatefulWidget {
  final int optionCount;
  final List<String> options;
  final ValueChanged<int> onChanged;

  const OkuurSelectableQuestion({
    super.key,
    required this.optionCount,
    required this.options,
    required this.onChanged,
  });

  @override
  State<OkuurSelectableQuestion> createState() => _OkuurSelectableQuestionState();
}

class _OkuurSelectableQuestionState extends State<OkuurSelectableQuestion> {
  AppColors colors = AppColors();
  int currentOption = 0;

  @override
  void initState() {
    super.initState();
    currentOption = 0;
  }

  Widget option(String name, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 32,
        child: Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                currentOption = index;
                widget.onChanged(currentOption);
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: currentOption == index ? colors.blue : colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentOption == index ? colors.blue : colors.grey
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: currentOption == index ? colors.blue : colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: SizedBox(
        height: widget.optionCount*40,
        child: Column(
          children: List.generate(widget.optionCount, (index) {
            return option(widget.options[index], index);
          }),
        ),
      ),
    );
  }
}
