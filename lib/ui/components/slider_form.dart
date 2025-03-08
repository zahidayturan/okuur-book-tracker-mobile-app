import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okuur/core/constants/colors.dart';

class PageCountSelector extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double currentValue;
  final ValueChanged<int> onChanged;
  final TextEditingController textController;

  const PageCountSelector({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
    required this.textController,
  });

  @override
  _PageCountSelectorState createState() => _PageCountSelectorState();
}

class _PageCountSelectorState extends State<PageCountSelector> {
  double _currentPageCount = 1;


  @override
  void initState() {
    super.initState();
    _currentPageCount = widget.currentValue;
    widget.textController.text = _currentPageCount.toInt().toString();
  }

  void _updatePageCount(double value) {
    setState(() {
      _currentPageCount = value;
      widget.textController.text = value.toInt().toString();
    });
  }

  void _onTextChanged(String value) {
    final enteredValue = double.tryParse(value);
    if (enteredValue != null) {
      if (enteredValue < widget.minValue) {
        setState(() {
          _currentPageCount = widget.minValue;
          widget.textController.text = widget.minValue.toInt().toString();
        });
      } else if (enteredValue > widget.maxValue) {
        setState(() {
          _currentPageCount = widget.maxValue;
          widget.textController.text = widget.maxValue.toInt().toString();
        });
      } else {
        setState(() {
          _currentPageCount = enteredValue;
        });
      }
      widget.onChanged(_currentPageCount.toInt());
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
              value: _currentPageCount > widget.maxValue ? widget.maxValue : _currentPageCount,
              min: widget.minValue,
              max: widget.maxValue,
              divisions: (widget.maxValue - widget.minValue).toInt(),
              label: _currentPageCount.toInt().toString(),
              onChanged: _updatePageCount,
              activeColor: colors.blue,
              inactiveColor: Theme.of(context).colorScheme.inverseSurface,
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
            controller: widget.textController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            onChanged: _onTextChanged,
          ),
        ),
      ],
    );
  }
}
