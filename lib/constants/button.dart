import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  void Function() onClick;
  String label;
  ButtonWidget(this.onClick,this.label);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(label,style: TextStyle(color: Colors.white),)),
          )
      ),
      onTap: this.onClick);
  }
}
