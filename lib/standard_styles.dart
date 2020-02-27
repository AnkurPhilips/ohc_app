import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget
{
  final String data;
  TextDefault({this.data});
  @override
  Widget build(BuildContext context) {
    return Text(data,);
  }

}