import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:flutter/material.dart';

Widget chooseWidget(IconData icon,String title){
  return  ListTile(
      leading: Icon(icon,size: 3.58147*SizeConfig.heightMultiplier,color: Colors.white,),
      title: Text(title,style: TextStyle(
        fontSize: 2.52809*SizeConfig.heightMultiplier,
        fontFamily: "CoreSansMed",
        color: Colors.white
      ),),
    );
}