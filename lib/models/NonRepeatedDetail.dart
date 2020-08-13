
import 'package:MiniPocket_flutter/models/DateType.dart';

class NonRepeatedDetail{
  double value;
  String note;
  DateType date;

  NonRepeatedDetail(){
    this.value = 0;
    this.note = "";
    this.date = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
  }
  bool isEmpty(){
    // ignore: null_aware_in_logical_operator
    return (this.value == 0 || this.note == "" );
  }
}