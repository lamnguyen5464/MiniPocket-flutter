import 'package:MiniPocket_flutter/constat.dart';
import 'package:MiniPocket_flutter/models/NonRepeatedDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransferActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTranferState();
  }
}

class CustomTextField extends StatelessWidget {
  final Widget child;

  const CustomTextField({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: GRAY,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
          ]),
      child: child,
    );
  }
}

class _NewTranferState extends State<NewTransferActivity> {
  int currentSelection = 1;
  var isEarningMode = true;
  var tmpCheckBox = true;
  NonRepeatedDetail nonRepeatedDetail =
      new NonRepeatedDetail();

  void postTrasaction() async {
    await Firestore.instance.collection(COLLECTION_TAG)
        .add({
      'value' : isEarningMode ? nonRepeatedDetail.value : -nonRepeatedDetail.value,
      'note' : nonRepeatedDetail.note,
      'dateCode' : nonRepeatedDetail.date.getDateCode(),
    });
  }

  void onClickAddButton() {
//    print('New transaction: ');
//    print(nonRepeatedDetail.value);
//    print(nonRepeatedDetail.note);
//    print(nonRepeatedDetail.date);
    postTrasaction();
    Navigator.pop(context, true);
  }

  Widget getSubFragment(bool isRepeated) {
    if (isRepeated == true) {
      return Expanded(
//        padding: const EdgeInsets.all(20),
        child: Container(
          height: 100,
          decoration: decoratedBox(),
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                    fontSize: 16, color: WHITE, fontFamily: 'chalkboard'),
              ),
            ),
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (dateTime) {
//                  nonRepeatedDetail.date.set(dateTime.day, dateTime.month, dateTime.year);
                }),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: GRAY,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: GRAY,
          body: Column(
            children: [
              buildHeader(screenSize),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: CustomTextField(
                  child: TextFormField(
                    cursorColor: isEarningMode ? GREEN : RED,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(
                      color: WHITE,
                      fontFamily: 'chalkboard',
                      fontSize: 20,
                      decorationColor: GREEN,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: WHITE_DARK,
                        fontFamily: 'math_tapping',
                        fontSize: 20,
                      ),
                      icon: Icon(
                        Icons.attach_money,
                        color: isEarningMode ? GREEN : RED,
                      ),
                      hintText: '',
                      border: InputBorder.none,
                      labelText: "*How much",
                      labelStyle: TextStyle(
                        color: WHITE_DARK,
                        fontFamily: 'math_tapping',
                        fontSize: 20,
                      ),
                    ),
                    validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    onChanged: (text) {
                      nonRepeatedDetail.value = double.parse(text);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: CustomTextField(
                  child: TextFormField(
                    cursorColor: isEarningMode ? GREEN : RED,
                    style: TextStyle(
                      color: WHITE,
                      fontFamily: 'chalkboard',
                      fontSize: 20,
                      decorationColor: GREEN,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: WHITE_DARK,
                        fontFamily: 'math_tapping',
                        fontSize: 20,
                      ),
                      icon: Icon(
                        Icons.notes,
                        color: isEarningMode ? GREEN : RED,
                      ),
//                      hintText: '100.000',
                      labelText: "*Notes",
                      labelStyle: TextStyle(
                        color: WHITE_DARK,
                        fontFamily: 'math_tapping',
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    onChanged: (text) {
                      nonRepeatedDetail.note = text;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        value: tmpCheckBox,
                        activeColor: isEarningMode ? GREEN : RED,
                        onChanged: (value) {
                          setState(() {
                            tmpCheckBox = !tmpCheckBox;
                          });
                        },
                      ),
                      Text(
                        "Repeated",
                        style: TextStyle(
                          fontFamily: 'math_tapping',
                          color: isEarningMode ? GREEN : RED,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              getSubFragment(tmpCheckBox),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration decoratedBox() {
    return BoxDecoration(
        color: GRAY,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
        ]);
  }

  Align buildHeader(Size screenSize) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: ButtonTheme(
              height: screenSize.height * 0.06,
              child: RaisedButton(
                child: Text(
                  "BACK",
                  style: TextStyle(
                      fontFamily: 'chalkboard',
                      color: isEarningMode ? GREEN : RED),
                ),
                color: GRAY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: isEarningMode ? GREEN : RED),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ),
          Row(
            children: [
              Text(
                isEarningMode ? "Earn" : "Pay",
                style: TextStyle(
                    color: isEarningMode ? GREEN : RED,
                    fontFamily: 'chalkboard',
                    fontSize: 20),
              ),
              Switch(
                value: isEarningMode,
                onChanged: (value) {
                  setState(() {
                    isEarningMode = !isEarningMode;
                  });
                },
                activeTrackColor: GREEN,
                inactiveTrackColor: RED,
                activeColor: WHITE,
                inactiveThumbColor: WHITE_DARK,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: ButtonTheme(
              height: screenSize.height * 0.06,
              child: RaisedButton(
                child: Text(
                  "ADD",
                  style: TextStyle(fontFamily: 'chalkboard'),
                ),
                color: isEarningMode ? GREEN : RED,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  onClickAddButton();
                },
              ),
            ),
          ),
        ]),
        decoration: BoxDecoration(
            color: GRAY,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
            ]),
        height: screenSize.height * 0.1,
      ),
    );
  }
}
