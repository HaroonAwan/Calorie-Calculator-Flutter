import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GregTextField extends Padding {
  GregTextField(
      {
        String placeholder,
        Widget prefix,
        Widget suffix,
      String label,
      TextInputType keyboardType,
      BuildContext context,
      TextEditingController controller,
  bool onlyNumbers = false,
  Function(String) validator
      })
      : super(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoTextField(
              placeholder: placeholder,
              inputFormatters: onlyNumbers ? [WhitelistingTextInputFormatter.digitsOnly] : null,
              keyboardType: keyboardType,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.all(120),
              prefix: prefix,
              suffix: suffix,
              controller: controller,
          ),
        );
}

class GregTextFormField extends Padding {
  GregTextFormField(
      {
        Widget prefix,
        Widget suffix,
        String label,
        TextInputType keyboardType,
        BuildContext context,
        TextEditingController controller,
        bool onlyNumbers = false,
        Function(String) validator
      })
      : super(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      inputFormatters: onlyNumbers ? [WhitelistingTextInputFormatter.digitsOnly] : null,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      scrollPadding: EdgeInsets.all(120),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
      ),
      controller: controller,
      validator: validator,
    ),
  );
}
