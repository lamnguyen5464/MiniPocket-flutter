
import 'package:MiniPocket_flutter/models/transferdetails/NonRepeatedDetail.dart';
import 'package:MiniPocket_flutter/models/transferdetails/WeeklyDetail.dart';

import '../DateType.dart';

enum TransactionType{
  non_repeating,
  weekly,
  monthly,
  everyNDay,
}

abstract class FactoryTransaction{
  factory FactoryTransaction(TransactionType type){
    switch(type){
      case TransactionType.non_repeating: return NonRepeatedDetail();
      case TransactionType.weekly: return WeeklyDetail();
    }
    return null;
  }
  void set(double value, String note);
  double getValue();
  String getNote();
  bool haveSelected(DayOfWeek day);
  void swichSelectionOn(DayOfWeek day);

}

abstract class TransactionData implements FactoryTransaction{
  double value;
  String note;

  TransactionData(){
    this.value = 0;
    this.note = "";
  }


  //abstract functions
  bool haveSelected(DayOfWeek day){
    return true;
  }
  void swichSelectionOn(DayOfWeek day){
    return;
  }
}