import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  static bool isLoadding = false;

  static void show(BuildContext context) {
    if (!isLoadding) {
      isLoadding = true;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingDialog();
          });
    }
  }

  static void dismiss(BuildContext context) {
    if (isLoadding) {
      isLoadding = false;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
