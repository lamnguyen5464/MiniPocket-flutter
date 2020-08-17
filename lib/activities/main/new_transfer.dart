import 'package:MiniPocket_flutter/activities/viewmodels/NewTrasferViewModel.dart';
import 'package:MiniPocket_flutter/components/custom_text_field.dart';
import 'package:MiniPocket_flutter/components/toggle_button.dart';
import 'package:MiniPocket_flutter/components/toggle_button_week_day.dart';
import 'package:MiniPocket_flutter/constat.dart';
import 'package:MiniPocket_flutter/models/DateType.dart';
import 'package:MiniPocket_flutter/models/transferdetails/NonRepeatedDetail.dart';
import 'package:MiniPocket_flutter/models/transferdetails/TransactionData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../styles.dart';

class NewTransferActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTranferState();
  }
}
class _NewTranferState extends State<NewTransferActivity> {
  Size screenSize;
  NewTransferViewModel viewModel = new NewTransferViewModel();

  void postTrasaction() async {
//    await Firestore.instance.collection(COLLECTION_TAG).add({
//      'value':
//          viewModel.isEarningMode ? nonRepeatedDetail.value : -nonRepeatedDetail.value,
//      'note': nonRepeatedDetail.note,
//      'dateCode': nonRepeatedDetail.date.getDateCode(),
//    });
  }

  TextStyle textColoredStyle() {
    return TextStyle(
      fontFamily: 'chalkboard',
      color: viewModel.isEarningMode ? GREEN : RED,
      fontSize: 15,
    );
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
    if (isRepeated == false) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 100,
          decoration: decorated3DBlack,
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
      return fragmentRepeating();
    }
  }

  Widget weeklyFragment(){
    var currentColor = viewModel.isEarningMode ? GREEN : RED;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: Text(
            "Day(s) of week:",
            style: textColoredStyle(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  viewModel.details.swichSelectionOn(DayOfWeek.mon);
                });
              },
              child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.mon), "Mo", currentColor),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.tue);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.tue), "Tu", currentColor)
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.wed);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.wed), "We", currentColor)
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.thu);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.thu), "Th", currentColor)
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.fri);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.fri), "Fr", currentColor)
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.sat);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.sat), "Sa", currentColor)
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.details.swichSelectionOn(DayOfWeek.sun);
                  });
                },
                child: CusTomToggleButtonWeekDay(viewModel.details.haveSelected(DayOfWeek.sun), "Su", currentColor)
            ),
          ],
        ),
      ],
    );
  }


  Widget monthlyFragment(){
    var currentColor = viewModel.isEarningMode ? GREEN : RED;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: Text(
            "Date of month:",
            style: textColoredStyle(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width*0.6),
          child: CustomTextField(
            child: TextFormField(
              cursorColor: currentColor,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2)
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
                hintText: '25',
                border: InputBorder.none,
              ),
              onChanged: (text) {
              },
            ),
          ),
        ),

      ],
    );
  }


  Widget everyNDaysFragment(){
    var currentColor = viewModel.isEarningMode ? GREEN : RED;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: Text(
            "Number of days: ",
            style: textColoredStyle(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width*0.6),
          child: CustomTextField(
            child: TextFormField(
              cursorColor: currentColor,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2)
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
                hintText: '25',
                border: InputBorder.none,
              ),
              onChanged: (text) {
              },
            ),
          ),
        ),

      ],
    );
  }

  Widget getRepeatingFragment(){
    switch(viewModel.type){
      case TransactionType.weekly: return weeklyFragment();

      case TransactionType.monthly: return monthlyFragment();

      case TransactionType.everyNDay: return everyNDaysFragment();

      default: return Container();
    }
  }

  Widget subFagmentRepeatingOf(int type) {
    var currentColor = viewModel.isEarningMode ? GREEN : RED;
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        decoration: decorated3DBlack,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getRepeatingFragment(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 20
                ),
                child: Text(
                  "From date: ",
                  style: textColoredStyle(),
                ),
              ),
              Container(
                height: 100,
                decoration: decorated3DBlack,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                          fontSize: 14, color: WHITE, fontFamily: 'chalkboard'),
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
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10,
                    top: 20
                ),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      viewModel.haveEndDate = !viewModel.haveEndDate;
                    });
                  },
                  child: Text(
                    "To date: ",
                    style: (viewModel.haveEndDate) ? textColoredStyle() : TextStyle(
                      color: WHITE_DARK,
                      fontSize: 15,
                      fontFamily: 'chalkboard',
                    ),
                  ),
                ),
              ),
              (viewModel.haveEndDate) ? Container(
                height: 100,
                decoration: decorated3DBlack,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                          fontSize: 14, color: WHITE, fontFamily: 'chalkboard'),
                    ),
                  ),
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (dateTime) {
//                  nonRepeatedDetail.date.set(dateTime.day, dateTime.month, dateTime.year);
                      }),
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fragmentRepeating() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        viewModel.changeType(TransactionType.weekly);
                      });
                    },
                    child: CusTomToggleButton(viewModel.type == TransactionType.weekly, "Weekly")),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        viewModel.changeType(TransactionType.monthly);
                      });
                    },
                    child:
                        CusTomToggleButton(viewModel.type == TransactionType.monthly, "Monthly")),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        viewModel.changeType(TransactionType.everyNDay);
                      });
                    },
                    child: CusTomToggleButton(
                        viewModel.type == TransactionType.everyNDay, "Every n day(s)")),
              ],
            ),
          ),
          subFagmentRepeatingOf(1),
        ],
      ),
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: CustomTextField(
              child: TextFormField(
                cursorColor: viewModel.isEarningMode ? GREEN : RED,
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
                    color: viewModel.isEarningMode ? GREEN : RED,
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
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
                onChanged: (text) {
                  viewModel.details.set(double.parse(text), viewModel.details.getNote());
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: CustomTextField(
              child: TextFormField(
                cursorColor: viewModel.isEarningMode ? GREEN : RED,
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
                    color: viewModel.isEarningMode ? GREEN : RED,
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
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
                onChanged: (text) {
                  viewModel.details.set(viewModel.details.getValue(), text);
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
                    value: viewModel.isRepeating(),
                    activeColor: viewModel.isEarningMode ? GREEN : RED,
                    onChanged: (value) {
                      setState(() {
                        viewModel.changeType((viewModel.type == TransactionType.non_repeating)
                            ? TransactionType.weekly
                            : TransactionType.non_repeating);
                      });
                    },
                  ),
                  Text(
                    "Repeating",
                    style: textColoredStyle(),
                  )
                ],
              ),
            ),
          ),
          getSubFragment(viewModel.isRepeating()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Container(
      color: GRAY,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: GRAY,
          body: Stack(
            children: [
              // 10% of height
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.1),
                child: Container(
                  height: screenSize.height * 1,
                  child: SingleChildScrollView(
                    child: body(),
                  ),
                ),
              ),

              buildHeader(screenSize),
//              body(),
            ],
          ),
        ),
      ),
    );
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
                      color: viewModel.isEarningMode ? GREEN : RED),
                ),
                color: GRAY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: viewModel.isEarningMode ? GREEN : RED),
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
                viewModel.isEarningMode ? "Earn" : "Pay",
                style: TextStyle(
                    color: viewModel.isEarningMode ? GREEN : RED,
                    fontFamily: 'chalkboard',
                    fontSize: 20),
              ),
              Switch(
                value: viewModel.isEarningMode,
                onChanged: (value) {
                  setState(() {
                    viewModel.isEarningMode = !viewModel.isEarningMode;
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
                color: viewModel.isEarningMode ? GREEN : RED,
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
        decoration: decorated3DBlack,
        height: screenSize.height * 0.1,
      ),
    );
  }
}
