import 'package:MiniPocket_flutter/models/transferdetails/NonRepeatedDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constat.dart';

class ListCellTransaction extends StatelessWidget {
  NonRepeatedDetail detail;

  ListCellTransaction(this.detail);

  final formatter = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: GRAY_LIGHT,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: BLACK, offset: Offset(0, 1), blurRadius: 0)
            ]),
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
                        fontSize: 60, fontFamily: 'math_tapping', color: WHITE),
                  ),
                  Text(
                    "/" +
                        detail.date.month.toString() +
                        "/" +
                        detail.date.year.toString(),
                    style: TextStyle(
                        fontSize: 25, fontFamily: 'math_tapping', color: WHITE),
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
    );
  }
}
