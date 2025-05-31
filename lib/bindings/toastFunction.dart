import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productapp/bindings/String.dart';

void toastFunction(String messege) {
  Fluttertoast.showToast(
      msg: messege,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade700,
      textColor: Colors.white,
      fontSize: 16.0);
}

void networkAlertDialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Server Error')),
          content: Text(
              'Your Network Connection is too weak. Please try again after sometime..!!!'),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Theme.of(context).primaryColor,),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      });
}

void offlineDialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('$offlineIndicator'),
          //content: Text('Your Network Connection is too weak. Please try again after sometime..!!!'),
          actions: <Widget>[

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Theme.of(context).primaryColor,
                    shape:
                    const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                25)))),
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      });
}
