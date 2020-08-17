import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';

class EveryNDaysDetail extends TransactionData {
  DateType startDate, endDate;
  int numDate;

  EveryNDaysDetail() : super(){
    this.startDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
    this.endDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
    numDate = DateTime.now().day;
  }


  bool isEmpty(){
    return (this.value == 0 || this.note == "" || this.startDate.isEmptyDate());
  }

  @override
  void set(double value, String note) {
    this.value = value;
    this.note = note;
  }

  @override
  String getNote() {
    return this.note;
  }

  @override
  double getValue() {
    return this.value;
  }
  
  @override
  int getNumOfDate() {
    return this.numDate;
  }

  @override
  void updateNumOfDate(int date) {
    this.numDate = date;
  }

}