import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/providers/meta_info_provider.dart';
import 'package:utility_manager_flutter/screens/webview_url.dart';
import 'package:utility_manager_flutter/services/meta_info_service.dart';
import 'package:utility_manager_flutter/widgets/add_url_to_collection.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

// ignore: non_constant_identifier_names
FutureBuilder<dynamic> MetaInfoDisplay(
    MetaInfoProvider url, GlobalKey<FormState> _key) {
  late String photoURL, title, description, type;
  TextEditingController _controller = TextEditingController();

  return FutureBuilder(
    future: MetaInfoService().getMetaInformation(url.url),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData)
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: LinearProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      if (snapshot.hasData) {
        photoURL = snapshot.data['meta']['image'] == null
            ? snapshot.data['meta']['site']['favicon']
            : snapshot.data['meta']['image'];
        title = snapshot.data['meta']['title'] == null ||
                snapshot.data['meta']['title'] == ""
            ? snapshot.data['meta']['site']['name']
            : snapshot.data['meta']['title'];
        description = snapshot.data['meta']['description'] == null
            ? snapshot.data['meta']['site']['canonical']
            : snapshot.data['meta']['description'];
        type = snapshot.data['meta']["type"] == "profile" ? '🙍🏼‍♂️' : '📖';
      }
      return Consumer(
        builder: (context, watch, child) {
          // final addURLToCollection = watch(addUserURLToCollection);
          return Container(
            child: snapshot.data['result']['status'] == "OK"
                ? Padding(
                    padding: const EdgeInsets.all(.5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                50,
                              ),
                              child: Image.network(
                                photoURL,
                                scale: 0.1,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RoundedButtonWidget(
                              buttonText: "Open URL",
                              width: MediaQuery.of(context).size.width * 0.8,
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewURL(
                                      url: url.url,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AcceptRoundedButtonWidget(
                              buttonText: "Save URL",
                              width: MediaQuery.of(context).size.width * 0.8,
                              onpressed: () {
                                addURLToCollection(context, _controller,
                                    photoURL, title, type, description, url);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text(
                    "Data not found",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        },
      );
    },
  );
}
