import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key key, this.btnName, this.onpress, this.colors, this.height, this.width}) : super(key: key);
  final String btnName;
  final Function onpress;
  final Color colors;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        
          onPressed:onpress,
          child: Center(
            child: Text(
              btnName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          color:colors,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
        ),
    );
  }
}


