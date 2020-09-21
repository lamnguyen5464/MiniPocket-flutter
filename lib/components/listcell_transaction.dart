import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:MiniPocket_flutter/models/transferdetails/NonRepeatedDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../constat.dart';

class ListCellTransaction extends StatelessWidget {
  NonRepeatedDetail detail;
  DocumentSnapshot document;

  ListCellTransaction(DocumentSnapshot document) {
    this.document = document;
    this.detail = getFromSnap(document);
  }

  final formatter = new NumberFormat("#,##0", "en_US");

  NonRepeatedDetail getFromSnap(DocumentSnapshot document) {
    NonRepeatedDetail tmp = new NonRepeatedDetail();
    tmp.value = (document["value"] is double)
        ? document["value"]
        : document["value"].toDouble();
    tmp.note = document["note"];
    tmp.date.setFromDateCode(document["dateCode"]);
//    print(tmp.value.toString() + " " + tmp.note + " " + tmp.date.getDateCode().toString());
    return tmp;
  }

  void deleteItem() async {
    await Firestore.instance
        .collection(CurrentUser.uid)
        .document(DATA_TAG)
        .collection(NONREPEATED_TAG)
        .document(document.documentID)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.2,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: RED,
            icon: Icons.delete,
            foregroundColor: GRAY_LIGHT,
            onTap: () => {
              this.deleteItem()
            },
          ),
        ],
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
              color: GRAY_LIGHT,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
              ]),
          child: InkWell(
            onTap: () {
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Text(
                        detail.date.date.toString(),
                        style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'math_tapping',
                            color: WHITE),
                      ),
                      Text(
                        "/" +
                            detail.date.month.toString() +
                            "/" +
                            detail.date.year.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'math_tapping',
                            color: WHITE),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      formatter.format(detail.value),
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'math_tapping',
                        color: (detail.value >= 0) ? GREEN : RED,
                      ),
                    ),
                    Text(
                      detail.note,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'chalkboard',
                        color: (detail.value >= 0) ? GREEN : RED,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
