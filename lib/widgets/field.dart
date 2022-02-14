import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  Field(this.valueKey, this.validator, this.fieldError, this.endValue,
      this.inputType, this.labelName, this.secure);

  final valueKey;
  var validator;
  final fieldError;
  TextEditingController endValue = TextEditingController();
  final inputType;
  final labelName;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(valueKey),
      validator: (value){
        if (value.isEmpty) {
          return (fieldError);
        }
        print("no error");
        return null;
      },
      controller: endValue,
      // onChanged: (value) {
      //   print("val = " + value);
      //   endValue = value;
      //   print("endValue = " + endValue);
      // },
      keyboardType: inputType,
      decoration: InputDecoration(labelText: labelName),
      obscureText: secure,
    );
  }
}
