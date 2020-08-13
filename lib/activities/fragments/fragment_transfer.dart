import 'package:MiniPocket_flutter/components/listcell_transaction.dart';
import 'package:MiniPocket_flutter/constat.dart';
import 'package:MiniPocket_flutter/models/NonRepeatedDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FragmentTransfer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FragmentTransferState();
  }
}

class _FragmentTransferState extends State<FragmentTransfer> {

  NonRepeatedDetail getFromSnap(DocumentSnapshot document){
    NonRepeatedDetail tmp = new NonRepeatedDetail();
    tmp.value = (document["value"] is double) ? document["value"] : document["value"].toDouble();
    tmp.note = document["note"];
    tmp.date.setFromDateCode(document["dateCode"]);
    print(tmp.value.toString() + " " + tmp.note + " " + tmp.date.getDateCode().toString());
    return tmp;
  }

  StreamBuilder<QuerySnapshot> getTransactionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(COLLECTION_TAG).orderBy("dateCode", descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color> (BLUE),
                )
            );
          default:
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ListCellTransaction(getFromSnap(snapshot.data.documents[index]));
              },
            );
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GRAY,
      appBar: buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: getTransactionList(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: GREEN,
          child: Icon(
            Icons.add,
            color: BLACK,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/new_tranfer_activity');
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: GRAY,
      elevation: 5,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          "Transactions",
          style: TextStyle(
            fontFamily: 'math_tapping',
            color: YELLOW,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

}
