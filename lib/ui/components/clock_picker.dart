import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/ui/components/text_form_field.dart';

class OkuurTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final Key formKey;

  const OkuurTimePicker({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<OkuurTimePicker> createState() => _OkuurTimePickerState();
}

class _OkuurTimePickerState extends State<OkuurTimePicker> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = DateFormat('HH:mm').format(DateTime.now());
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {
        widget.controller.text = DateFormat('HH:mm').format(pickedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OkuurTextFormField(
      label: "Bitirme Saati",
      hint: "Seçiniz",
      controller: widget.controller,
      key: widget.formKey,
      readOnly: true,
      onTap: _selectTime,
    ).getTextFormFieldForPage(context);
  }
}
