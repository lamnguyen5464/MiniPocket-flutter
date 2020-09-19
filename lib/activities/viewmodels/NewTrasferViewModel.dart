import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constat.dart';

class NewTransferViewModel{

  TransactionType type;
  bool isEarningMode;
  FactoryTransaction details;
  bool haveEndDate;

  void postNonRepeating(){
    print(details.getNonRepeatingDate().getDateCode());
    FirebaseAuth.instance.currentUser().then((value) => {
       Firestore.instance.collection(value.uid).document(DATA_TAG).collection(NONREPEATED_TAG).add({
        'value': isEarningMode ? details.getValue() : -details.getValue(),
        'note': details.getNote(),
        'dateCode': details.getNonRepeatingDate().getDateCode(),
      })
    });
  }

  void postWeekly(){
    Firestore.instance.collection(CurrentUser.uid).document(DATA_TAG).collection(WEEKLY_TAG).add({
      'value': isEarningMode ? details.getValue() : -details.getValue(),
      'note': details.getNote(),
      'fromDate': details.getFromDate().getDateCode(),
      'toDate': haveEndDate ? details.getToDate().getDateCode() : 0,
    });
  }

  void postTrasaction() {
    switch(this.type){
      case TransactionType.non_repeating:
        postNonRepeating();
        break;
      case TransactionType.weekly:
        postWeekly();
        break;
      default:
        return;
    }

  }


  NewTransferViewModel(){
    this.changeType(TransactionType.non_repeating);
    this.isEarningMode = true;
    this.haveEndDate = false;
  }

  bool isRepeating(){
    return this.type != TransactionType.non_repeating;
  }

  void changeType(TransactionType type){
    this.type = type;
    String tmpNote = (details != null) ? details.getNote() : "";
    double tmpValue = (details != null) ? details.getValue() : 0;
    this.details = FactoryTransaction(type);
    details.set(tmpValue, tmpNote);
  }


}