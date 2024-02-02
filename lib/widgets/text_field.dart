import 'package:flutter/material.dart';

class CustomValidatorTextfield extends StatelessWidget {
  CustomValidatorTextfield({this.hintText, this.onChanged,this.obsecuteText=false});
  String? hintText;
  bool? obsecuteText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    //to validate user input in textfield
    return TextFormField(
      obscureText: obsecuteText!,
      validator: (data) {
        //if user did not enter data
        if (data!.isEmpty) {
          return "field is required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
