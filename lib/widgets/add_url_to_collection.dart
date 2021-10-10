import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/providers/meta_info_provider.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/create_new_collection.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

addURLToCollection(
    BuildContext context,
    TextEditingController _controller,
    String photoURL,
    String title,
    String type,
    description,
    MetaInfoProvider url) async {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, watch, child) {
          // final userMetaCollection = watch(metaCollectionOfUser);
          return Column(
            children: [
              SizedBox(
                height: 25,
              ),
              RoundedButtonWidget(
                buttonText: "Create new collection",
                width: MediaQuery.of(context).size.width * 0.8,
                onpressed: () {
                  createNewCollection(context, _controller);
                },
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: StreamBuilder(
                  stream: supabase
                      .from(
                          'UserURLCollection:email=eq.${supabase.auth.currentUser?.email}')
                      .stream()
                      .execute(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if ((snapshot.connectionState == ConnectionState.waiting) ||
                        (!snapshot.hasData))
                      return SizedBox(
                        width: 300.0,
                        child: LinearProgressIndicator(
                          backgroundColor: Theme.of(context).accentColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    if (snapshot.data.length < 1)
                      return Lottie.asset('assets/empty.json');
                    return Container(
                      child: Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                WhiteButton(
                                  buttonText: snapshot.data[index]
                                      ['collection_name'],
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  onpressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                          title: Text(
                                            "Save to ${snapshot.data[index]['collection_name']}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                            "Are you sure!?",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          buttonPadding: EdgeInsets.all(
                                            10,
                                          ),
                                          actions: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Theme.of(context)
                                                          .errorColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 15,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await supabase
                                                          .from("URLCollection")
                                                          .insert([
                                                        {
                                                          'created_by': supabase
                                                              .auth
                                                              .currentUser
                                                              ?.email,
                                                          'photoURL': photoURL
                                                              .toString(),
                                                          'title':
                                                              title.toString(),
                                                          'type':
                                                              type.toString(),
                                                          'url': url.url,
                                                          'collection_name':
                                                              snapshot.data[
                                                                      index][
                                                                  'collection_name'],
                                                          'description':
                                                              description,
                                                        }
                                                      ]).execute();
                                                      Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.isFirst,
                                                      );
                                                      // showSnackBar(context,
                                                      //     "Added to ${fetchedURLCollection['names'][i]['name']} collection!");
                                                    },
                                                    child: Text("OK"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Theme.of(context)
                                                          .primaryColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 35,
                                                        vertical: 15,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      );
    },
  );
}
