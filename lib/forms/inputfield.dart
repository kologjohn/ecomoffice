import 'package:flutter/material.dart';

import '../global.dart';


class InputField extends StatelessWidget {
  final String hintText;
  final  TextEditingController controller;
  final TextInputType textInputType;
  final String lableText;
 final bool password;
  const InputField({super.key,required this.password, required this.hintText,required this.controller, required this.textInputType, required this.lableText});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: TextFormField(
          validator: (val){
            if(val!.isEmpty)
              {
                return "Field Required";
              }
          },
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            hintText: hintText,
            labelText: lableText
          ),
        ),
      ),
    );
  }
}
