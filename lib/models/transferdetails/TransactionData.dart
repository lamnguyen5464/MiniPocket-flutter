
import 'package:MiniPocket_flutter/models/transferdetails/EveryNDaysDetail.dart';
import 'package:MiniPocket_flutter/models/transferdetails/MonthlyDetail.dart';
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
      case TransactionType.monthly: return MonthlyDetail();
      case TransactionType.everyNDay: return EveryNDaysDetail();
    }
    return null;
  }
  void set(double value, String note);
  double getValue();
  String getNote();
  bool haveSelected(DayOfWeek day);
  void swichSelectionOn(DayOfWeek day);
  void updateNumOfDate(int date);
  int getNumOfDate();
  DateType getNonRepeatingDate();


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
  void updateNumOfDate(int date){
    return;
  }
  int getNumOfDate(){
    return -1;
  }
  DateType getNonRepeatingDate(){
    return new DateType();
  }
}