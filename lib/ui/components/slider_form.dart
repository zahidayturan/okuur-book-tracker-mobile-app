import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';

class PageCountSelector extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double currentValue;
  final ValueChanged<int> onChanged;

  const PageCountSelector({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  _PageCountSelectorState createState() => _PageCountSelectorState();
}

class _PageCountSelectorState extends State<PageCountSelector> {
  double _currentPageCount = 1;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentPageCount = widget.currentValue;
    _textController.text = _currentPageCount.toInt().toString();
  }

  void _updatePageCount(double value) {
    setState(() {
      _currentPageCount = value;
      _textController.text = value.toInt().toString();
    });
  }

  void _onTextChanged(String value) {
    final enteredValue = double.tryParse(value);
    if (enteredValue != null) {
      if (enteredValue < widget.minValue) {
        setState(() {
          _currentPageCount = widget.minValue;
          _textController.text = widget.minValue.toInt().toString();
        });
      } else if (enteredValue > widget.maxValue) {
        setState(() {
          _currentPageCount = widget.maxValue;
          _textController.text = widget.maxValue.toInt().toString();
        });
      } else {
        setState(() {
          _currentPageCount = enteredValue;
        });
      }
    }
  }

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Slider
        Expanded(
          child: SizedBox(
            height: 36,
            child: Slider(
              value: _currentPageCount,
              min: widget.minValue,
              max: widget.maxValue,
              divisions: (widget.maxValue - widget.minValue).toInt(),
              label: _currentPageCount.toInt().toString(),
              onChanged: _updatePageCount,
              activeColor: colors.blue,
              inactiveColor: colors.blueLight,
              onChangeEnd: (value) {
                widget.onChanged(_currentPageCount.toInt());
              },
            ),
          ),
        ),
        // TextFormField
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: _textController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: _onTextChanged,
            onEditingComplete: () {
              widget.onChanged(_currentPageCount.toInt());
            },
          ),
        ),
      ],
    );
  }
}
