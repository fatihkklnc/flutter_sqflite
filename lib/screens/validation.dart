import 'package:flutter/material.dart';

class ValidationMixin{


  String validateName(String value){
    if(value.length<2)
      return "İlaç ismi en az 2 karakter olmalıdır.";
  }
  String validateDescription(String value){
    if(value.length<2)
      return "İlaç açıklaması en az 2 karakter olmalıdır.";
  }
  String validateUnitPrace(String value){


    var adet=int.tryParse(value);
    print(adet);
    if((adet<0 || adet>1000))
      return "0 ile 10000 arası değer giriniz";
   


  }
}