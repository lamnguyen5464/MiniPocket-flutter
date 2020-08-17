
enum TransactionType{
  non_repeating,
  weekly,
  monthly,
  everyNDay,
}
class NewTransferViewModel{

  var type = TransactionType.non_repeating;
  var isEarningMode = true;

  bool isRepeating(){
    return this.type != TransactionType.non_repeating;
  }
  void changeType(TransactionType type){
    this.type = type;
  }
}