import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:utility_manager_flutter/screens/webview_URL.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

Future<dynamic> singleURLBottomSheet(BuildContext context, String url, int id) {
  return showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Theme.of(context).accentColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButtonWidget(
              buttonText: "Open this link",
              width: MediaQuery.of(context).size.width * 0.90,
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewURL(
                      url: url,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 25),
            RoundedButtonWidget(
              buttonText: "Share this link",
              width: MediaQuery.of(context).size.width * 0.90,
              onpressed: () {
                Share.share('Check out the website $url');
              },
            ),
            SizedBox(height: 25),
            CancelRoundedButtonWidget(
              buttonText: "Delete this link",
              width: MediaQuery.of(context).size.width * 0.90,
              onpressed: () async {
                await supabase
                    .from('URLCollection')
                    .delete()
                    .match({'id': id}).execute();
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
