import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';

class WeeklyDetail extends TransactionData {
  DateType startDate, endDate;
  String statusDayOfWeek;

  WeeklyDetail() : super(){
    this.startDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
    this.endDate = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
    statusDayOfWeek = "00000000";
  }

  @override
  bool haveSelected(DayOfWeek day){
    return statusDayOfWeek[DateType.getNumDateOfWeek(day)] == '1';
  }

  @override
  void swichSelectionOn(DayOfWeek day){
    int place = DateType.getNumDateOfWeek(day);
    this.statusDayOfWeek = this.statusDayOfWeek.substring(0, place)
        + ((this.statusDayOfWeek[place] == '1') ? '0' : '1')
        + this.statusDayOfWeek.substring(place+1);
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

}