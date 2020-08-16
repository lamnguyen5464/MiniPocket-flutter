import 'package:MiniPocket_flutter/constat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FragmentStatus extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FragmentStatusState();
  }
}

class _FragmentStatusState extends State<FragmentStatus> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: GRAY,
        appBar: buildAppBar(),
        body: Align(
          alignment: Alignment.center,
          child: FlatButton(
            onPressed: () async{
              print("clicked");
//              http.Response res = await http.get("http://localhost:3000");
////              print(res.body);
////
              Map<String, String> headers = {"Content-type": "application/json"};
              String json = '{"name": "Lam Nguyen", "body": "body text", "userId": 1}';
              Response response = await post("http://localhost:3000/post", headers: headers,  body: json);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
            },
            child: Container(
              width: screenSize.height * 0.3,
              height: screenSize.height * 0.3,
              decoration: BoxDecoration(
                  color: YELLOW,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: YELLOW_DARK,
                        offset: Offset(0, 5),
                        blurRadius: 0
                    )
                  ]
              ),
            ),
          ),
        )
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
          "Current status",
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
