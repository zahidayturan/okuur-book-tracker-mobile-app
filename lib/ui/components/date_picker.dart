import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okuur/ui/components/text_form_field.dart';

class OkuurDateTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? endController;
  final Key formKey;
  final Key? formEndKey;
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRangePicker;

  const OkuurDateTimePicker({
    super.key,
    required this.formKey,
    required this.controller,
    this.endController,
    this.formEndKey,
    this.label = "Tarih",
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.isRangePicker = false,
  });

  @override
  State<OkuurDateTimePicker> createState() => _OkuurDateTimePickerState();
}

class _OkuurDateTimePickerState extends State<OkuurDateTimePicker> {
  @override
  void initState() {
    super.initState();

    widget.controller.text = DateFormat('dd.MM.yyyy').format(widget.initialDate ?? DateTime.now());


    if (widget.isRangePicker && widget.endController != null) {
      widget.endController!.text = DateFormat('dd.MM.yyyy').format(widget.lastDate ?? DateTime.now());
    }
  }

  Future<void> _selectDate() async {
    if (!widget.isRangePicker) {

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.initialDate ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(2000),
        lastDate: widget.lastDate ?? DateTime(2101),
      );

      if (pickedDate != null) {
        setState(() {
          widget.controller.text = DateFormat('dd.MM.yyyy').format(pickedDate);
        });
      }
    } else {

      DateTimeRange? pickedDateRange = await showDateRangePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.input,
        initialDateRange: DateTimeRange(
          start: widget.initialDate ?? DateTime.now().subtract(Duration(days: 7)),
          end: widget.lastDate ?? DateTime.now(),
        ),
        firstDate: widget.firstDate ?? DateTime(2000),
        lastDate: widget.lastDate ?? DateTime(2101),
      );

      if (pickedDateRange != null) {
        setState(() {
          widget.controller.text = DateFormat('dd.MM.yyyy').format(pickedDateRange.start);
          if (widget.endController != null) {
            widget.endController!.text = DateFormat('dd.MM.yyyy').format(pickedDateRange.end);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 44,
          width: 120,
          child: OkuurTextFormField(
            label: widget.label,
            hint: "Seçiniz",
            controller: widget.controller,
            key: widget.formKey,
            readOnly: true,
            onTap: _selectDate,
          ).getTextFormFieldForPage(context),
        ),
        if (widget.isRangePicker && widget.endController != null)
          SizedBox(
            height: 44,
            width: 120,
            child: OkuurTextFormField(
              label: "Bitiş",
              hint: "Seçiniz",
              controller: widget.endController!,
              key: widget.formEndKey!,
              readOnly: true,
              onTap: _selectDate,
            ).getTextFormFieldForPage(context),
          ),
      ],
    );
  }
}
