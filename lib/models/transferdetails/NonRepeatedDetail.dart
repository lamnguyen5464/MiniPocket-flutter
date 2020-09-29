
import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';

class NonRepeatedDetail extends TransactionData {
  DateType date;

  NonRepeatedDetail() : super(){
    this.date = new DateType.fromDetail(DateTime.now().day, DateTime.now().month, DateTime.now().year);
  }

  @override
  DateType getNonRepeatingDate(){
    return this.date;
  }

  bool isInvalid(){
    // ignore: null_aware_in_logical_operator
    return (this.value == 0 || this.note == "" );
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