import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool? isPassWord;
  final Future<void> Function(BuildContext, String)? onSelectDate;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.isPassWord,
      this.onSelectDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryData.size.width * 0.05,
          right: mediaQueryData.size.width * 0.05),
      child: TextFormField(
        obscureText: isPassWord ?? false,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.black38,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.black38,
                ))),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintText';
          }
          return null;
        },
        maxLines: maxLines,
        onTap: () {
          if (hintText == "Dead Line") {
            onSelectDate!(context, "Dead");
          }
          if (hintText == "Expected time to complete task") {
            onSelectDate!(context, "except");
          }
        },
      ),
    );
  }
}
