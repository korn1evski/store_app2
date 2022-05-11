import 'package:flutter/material.dart';
import 'package:store_app/core/colors.dart';

class MyCheckBox extends StatefulWidget {
  MyCheckBox({Key? key, required this.hoverColor, required this.checkColor, required this.fillColor, required this.isChecked, required this.foo}) : super(key: key);
  final Color hoverColor;
  final Color fillColor;
  final Color checkColor;
  bool isChecked;
  void Function(bool?)? foo;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states){
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused
      };
      if(states.any(interactiveStates.contains)){
        return widget.hoverColor;
      } else {
        return widget.fillColor;
      }
    }
    return Checkbox(
        checkColor: widget.checkColor,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: widget.isChecked,
        onChanged: widget.foo
    );
  }
}
