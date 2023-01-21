import 'package:flutter/material.dart';

extension AppUtil on Widget{

  Widget onTap(Function() click){
    return InkWell(
      onTap: click,
      child: this,
    );
  }

  Widget center(){
    return Center(
      child: this,
    );
  }

  Widget paddingAll({double padding = 8}){
    return Padding(padding: EdgeInsets.all(padding),

    );
  }
}

extension IntUtil on int{

  Widget spaceHeight(){
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget spaceWidth(){
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension DateUtil on DateTime{

  DateTime addYearDuration(int year){
    var time = DateTime.now();

    return time;
  }
}
