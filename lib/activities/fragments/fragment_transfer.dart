import 'package:MiniPocket_flutter/components/app_bar.dart';
import 'package:MiniPocket_flutter/components/listcell_transaction.dart';
import 'package:MiniPocket_flutter/constat.dart';
import 'package:MiniPocket_flutter/models/CurrentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FragmentTransfer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FragmentTransferState();
  }
}

class _FragmentTransferState extends State<FragmentTransfer> {


  StreamBuilder<QuerySnapshot> getTransactionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(CurrentUser.uid).document(DATA_TAG).collection(NONREPEATED_TAG).orderBy("dateCode", descending: true).snapshots(),
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
                return ListCellTransaction(snapshot.data.documents[index]);
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
      appBar: buildAppBar("Transactions"),
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

}
