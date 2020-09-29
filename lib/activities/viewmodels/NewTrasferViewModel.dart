import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constat.dart';

class NewTransferViewModel {
  TransactionType type;
  bool isEarningMode;
  FactoryTransaction details;
  bool haveEndDate;
  BuildContext context; //for showing Dialog

  void bindContext(BuildContext context){
    this.context = context;
  }

  void showError() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Oh no :(',
            style: TextStyle(color: WHITE, fontFamily: 'chalkboard', fontSize: 25),
          ),
          backgroundColor: GRAY,
          content: Text(
            'Please fill in enough information!',
            style: TextStyle(color: WHITE, fontFamily: 'chalkboard'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Oh okay',
                style: TextStyle(color: WHITE, fontFamily: 'chalkboard'),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void postNonRepeating() {
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
                    'my_money': (isEarningMode
                        ? details.getValue()
                        : -details.getValue())
                  })
                }
              else
                {
                  Firestore.instance
                      .collection(CurrentUser.uid)
                      .document(DETAIL_USER)
                      .updateData({
                    'my_money': value['my_money'] +
                        (isEarningMode
                            ? details.getValue()
                            : -details.getValue())
                  })
                }
            });

    Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_TRANSACTION)
        .collection(NONREPEATED_TAG)
        .add({
      'value': isEarningMode ? details.getValue() : -details.getValue(),
      'note': details.getNote(),
      'dateCode': details.getNonRepeatingDate().getDateCode(),
    });
  }

  void postWeekly() {
    Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_TRANSACTION)
        .collection(WEEKLY_TAG)
        .add({
      'value': isEarningMode ? details.getValue() : -details.getValue(),
      'note': details.getNote(),
      'fromDate': details.getFromDate().getDateCode(),
      'toDate': haveEndDate ? details.getToDate().getDateCode() : 0,
    });
  }

  bool postTrasaction() {
    if (this.details.isInvalid()){
      showError();
      return false;
    }

    switch (this.type) {
      case TransactionType.non_repeating:
        postNonRepeating();
        break;
      case TransactionType.weekly:
        postWeekly();
        break;
    }
    return true;
  }

  NewTransferViewModel() {
    this.changeType(TransactionType.non_repeating);
    this.isEarningMode = true;
    this.haveEndDate = false;
  }

  bool isRepeating() {
    return this.type != TransactionType.non_repeating;
  }

  void changeType(TransactionType type) {
    this.type = type;
    String tmpNote = (details != null) ? details.getNote() : "";
    double tmpValue = (details != null) ? details.getValue() : 0;
    this.details = FactoryTransaction(type);
    details.set(tmpValue, tmpNote);
  }
}
