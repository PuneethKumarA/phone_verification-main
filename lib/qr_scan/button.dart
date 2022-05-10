import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
     this.text,        //removed required before this  -ed
     this.onClicked,  //removed required before this -ed
    Key key, // removed ? from Key? -ed
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => RaisedButton(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
    shape: StadiumBorder(),
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textColor: Colors.white,
    onPressed: onClicked,
  );
}















// import 'package:flutter/material.dart';
//
// class ButtonWidget extends StatelessWidget {
//   final String text;
//   final VoidCallback onClicked;
//   const ButtonWidget({
//      this.text,
//      this.onClicked,
//     Key key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) => RaisedButton(
//     child: Text(
//       text,
//       style: TextStyle(fontSize: 24),
//     ),
//     shape: StadiumBorder(),
//     color: Theme.of(context).primaryColor,
//     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     textColor: Colors.white,
//     onPressed: onClicked,
//   );
// }