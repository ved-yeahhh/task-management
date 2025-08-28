import 'package:flutter/material.dart';
import 'package:task_mgmt/common/hex_colors.dart';

class Textformfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? icon;
  final int maxLines;
  final bool isDate;

  const Textformfield({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.maxLines = 1,
    this.isDate = false,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.day}-${picked.month}-${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      onTap: () => isDate ? _selectDate(context) : null,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w100,
          fontSize: 15.0,
        ),
        alignLabelWithHint: true,
        filled: true,
        fillColor: HexColor(HexColors.offWhite),
        prefixIcon: icon,
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    );
  }
}
