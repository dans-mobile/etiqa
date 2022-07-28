import 'package:etiqa/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final int? strLenght;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final String? initialValue;
  final Function(String?)? onChanged;

  const CustomTextField({
    Key? key,
    this.strLenght,
    this.labelText,
    this.controller,
    this.validator,
    this.textInputType,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      maxLength: widget.strLenght,
      keyboardType: widget.textInputType ?? TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[.,]')),
      ],
      decoration: InputDecoration(
        // hintText: hintText,
        labelText: widget.labelText,
        labelStyle: GoogleFonts.montserrat(
          color: Colors.black,
        ),
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: kPrimary,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: kPrimary,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
