import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/TransactionData.dart';

class WeeklyDetail extends TransactionData{
  DateType startDate, endDate;


  WeeklyDetail() : super(){
    this.startDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
    this.endDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
  }
  bool isEmpty(){
    // ignore: null_aware_in_logical_operator
    return (this.value == 0 || this.note == "" );
  }
}