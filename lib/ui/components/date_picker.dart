import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/ui/components/text_form_field.dart';

class OkuurDateTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final Key formKey;

  const OkuurDateTimePicker({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<OkuurDateTimePicker> createState() => _OkuurDateTimePickerState();
}

class _OkuurDateTimePickerState extends State<OkuurDateTimePicker> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('dd.MM.yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OkuurTextFormField(
      label: "Tarih",
      hint: "Seçiniz",
      controller: widget.controller,
      key: widget.formKey,
      readOnly: true,
      onTap: _selectDate,
    ).getTextFormFieldForPage(context);
  }
}