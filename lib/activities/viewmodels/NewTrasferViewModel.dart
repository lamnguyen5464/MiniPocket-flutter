import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';

class NewTransferViewModel{

  TransactionType type;
  bool isEarningMode;
  FactoryTransaction details;
  bool haveEndDate;

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