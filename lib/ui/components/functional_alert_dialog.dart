import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/regular_text.dart';

AppColors colors = AppColors();
class OkuurAlertDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String contentText,
    required List<AlertButton> buttons,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: RegularText(
          texts: contentText,
          align: TextAlign.center,
          size: "xl",
          maxLines: 5,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons.length != 2 ? [
              _buildButton(context, buttons[0])
            ] : [
              _buildButton(context, buttons[0]),
              const SizedBox(width: 8),
              _buildButton(context, buttons[1])
            ]
          ),
        ],
      ),
    );
  }

  static Widget _buildButton(BuildContext context, AlertButton button) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.of(context).pop(button.returnValue),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: button.fill ? button.fillColor ?? colors.blue : null,
            border: button.fill
                ? null
                : Border.all(color: colors.blue, width: 1),
          ),
          child: Center(
            child: Text(
              button.text,
              style: TextStyle(
                color: button.fill ? button.textColor ?? colors.grey : button.borderColor ?? colors.blue,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class AlertButton {
  final String text;
  final bool fill;
  final bool returnValue;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;

  AlertButton({
    required this.text,
    required this.fill,
    required this.returnValue,
    this.fillColor ,
    this.borderColor,
    this.textColor,
  });
}
