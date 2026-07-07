
// import 'package:flutter/material.dart';
int calcReadingTime(String content){

//we need how much time we need to read a blog aor we directly proporional to no of worlds and letter in that blog 


final wordCount=content.split(RegExp(r'\s+')).length;

//average readin speed=200-300 words mins;
double finalReadingTime=wordCount/200;
return finalReadingTime.ceil();



}