import 'package:MiniPocket_flutter/main/constat.dart';
import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/NonRepeatedDetail.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../CurrentUser.dart';

class WeeklyDetail extends TransactionData {
  DateType startDate, endDate;
  String statusDayOfWeek;

  WeeklyDetail() : super() {
    this.startDate = new DateType.fromDetail(
        DateTime.now().day, DateTime.now().month, DateTime.now().year);
    this.endDate = new DateType.fromDetail(
        DateTime.now().day, DateTime.now().month, DateTime.now().year);
    endDate.clear();
    statusDayOfWeek = "00000000";
  }

  @override
  bool haveSelected(DayOfWeek day) {
    return statusDayOfWeek[DateType.getNumDateOfWeek(day)] == '1';
  }

  @override
  void swichSelectionOn(DayOfWeek day) {
    int place = DateType.getNumDateOfWeek(day);
    this.statusDayOfWeek = this.statusDayOfWeek.substring(0, place) +
        ((this.statusDayOfWeek[place] == '1') ? '0' : '1') +
        this.statusDayOfWeek.substring(place + 1);
  }

  bool isEmpty() {
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
  DateType getFromDate() {
    return this.startDate;
  }

  @override
  DateType getToDate() {
    return this.endDate;
  }

  @override
  String getWeekCode() {
    return this.statusDayOfWeek;
  }

  void setWeekCode(String code) {
    this.statusDayOfWeek = code;
  }

  @override
  bool isInvalid() {
    return (this.value == 0 ||
        this.note == "" ||
        this.statusDayOfWeek == "00000000");
  }

  @override
  void postToFirebase() async {
    DateType upToDate = new DateType();
    upToDate.setFromDateCode(this.getFromDate().getDateCode());
    await this.generateTransactions(upToDate, new DateType());

    await Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_TRANSACTION)
        .collection(WEEKLY_TAG)
        .add({
      'value': this.value,
      'note': this.note,
      'startDate': getFromDate().getDateCode(),
      'endDate': endDate.getDateCode(),
      'upToDate': upToDate.getDateCode(),
      'dayOfWeekCode': this.getWeekCode()
    });
  }

  Future<bool> generateTransactions(DateType fromDate, DateType today) async {
    while (fromDate.getDateCode() <= today.getDateCode()) {
      if (this.getToDate().getDateCode() < fromDate.getDateCode()) {
        //delete
        return true;
      } else {
        if (this.getFromDate().getDateCode() <= fromDate.getDateCode() &&
            this.statusDayOfWeek[fromDate.getDayOfWeek()] == '1') {
          //the transaction happens on fromDate
          NonRepeatedDetail detail = new NonRepeatedDetail();
          detail.set(this.getValue(), this.getNote());
          detail.getNonRepeatingDate().setFromDateCode(fromDate.getDateCode());
          await detail.postToFirebase();
        }
      }
      fromDate.goToTheNextDay();
    }
    return false;
  }

  static void updateTransactionFromFirebase() async {
    WeeklyDetail detail = new WeeklyDetail();
    DateType upToDate = new DateType();
    List<String> listOfDeleting = new List();
    bool mustDelete;
    Firestore.instance
        .collection(CurrentUser.uid)
        .document(DETAIL_TRANSACTION)
        .collection(WEEKLY_TAG)
        .getDocuments()
        .then((value) async => {
              for (DocumentSnapshot doc in value.documents)
                {
                  detail.setFromSnapshot(doc),
                  upToDate.setFromDateCode(doc["upToDate"]),
                  mustDelete = await detail.generateTransactions(upToDate, new DateType()),
                  if (mustDelete)
                    {listOfDeleting.add(doc.documentID)}
                  else
                    {
                      await Firestore.instance
                          .collection(CurrentUser.uid)
                          .document(DETAIL_TRANSACTION)
                          .collection(WEEKLY_TAG)
                          .document(doc.documentID)
                          .updateData({'upToDate': upToDate.getDateCode()})
                    },
                },
              //delete
              for (String s in listOfDeleting)
                {
                  await Firestore.instance
                      .collection(CurrentUser.uid)
                      .document(DETAIL_TRANSACTION)
                      .collection(WEEKLY_TAG)
                      .document(s)
                      .delete()
                }
            });
  }

  void setFromSnapshot(DocumentSnapshot document) {
    this.value = document["value"];
    this.note = document["note"];
    this.getFromDate().setFromDateCode(document["startDate"]);
    this.getToDate().setFromDateCode(document["endDate"]);
    this.setWeekCode(document["dayOfWeekCode"]);
  }
}
