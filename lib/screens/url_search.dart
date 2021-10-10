import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/providers/url_search_provider.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';
import 'package:utility_manager_flutter/widgets/single_url_bottomsheet.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchText = TextEditingController();
  bool _searching = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Consumer(
        builder: (context, watch, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.back,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("Add URL"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _searchText,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          hintText: 'Hint about URL ...',
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      RoundedButtonWidget(
                        buttonText: 'Search',
                        width: MediaQuery.of(context).size.width * 0.90,
                        onpressed: () {
                          setState(() {
                            _searching = true;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CancelRoundedButtonWidget(
                        buttonText: "Cancel",
                        width: MediaQuery.of(context).size.width * 0.90,
                        onpressed: () {
                          setState(() {
                            _searchText.text = "";
                            _searching = false;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: _searching
                            ? watch(urlSearchProvider(_searchText.text)).map(
                                data: (res) {
                                  return res.value.data.length == 0
                                      ? Lottie.asset('assets/no_data.json')
                                      : ListView(
                                          shrinkWrap: true,
                                          children: [
                                            for (var i = 0;
                                                i < res.value.data.length;
                                                i++)
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        onTap: () {
                                                          HapticFeedback
                                                              .lightImpact();
                                                          singleURLBottomSheet(
                                                              context,
                                                              res.value.data[i]
                                                                  ['url'],
                                                              res.value.data[i]
                                                                  ['id']);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Column(
                                                              children: [
                                                                Image.network(res
                                                                        .value
                                                                        .data[i]
                                                                    [
                                                                    'photoURL']),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  res.value.data[
                                                                          i]
                                                                      ['title'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  res.value.data[
                                                                          i][
                                                                      'description'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  res.value.data[
                                                                          i]
                                                                      ['type'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        );
                                },
                                loading: (_) => SizedBox(
                                  width: 300.0,
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                error: (_) => Text(
                                  _.error.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Lottie.asset('assets/empty.json'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
