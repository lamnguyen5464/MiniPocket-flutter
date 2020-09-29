
import 'package:MiniPocket_flutter/main/constat.dart';
import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../CurrentUser.dart';

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

  @override
  void postToFirebase() {
    Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_USER)
        .get()
        .then((value) => {
      if (value.data == null)
        {
          Firestore.instance
              .collection(CurrentUser.uid)
              .document(DETAIL_USER)
              .setData({
            'my_money': this.value
          })
        }
      else
        {
          Firestore.instance
              .collection(CurrentUser.uid)
              .document(DETAIL_USER)
              .updateData({
            'my_money': value['my_money'] + this.value
          })
        }
    });

    Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_TRANSACTION)
        .collection(NONREPEATED_TAG)
        .add({
      'value': this.value,
      'note': this.note,
      'dateCode': this.date.getDateCode(),
    });
  }

}