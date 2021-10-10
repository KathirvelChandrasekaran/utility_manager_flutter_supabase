import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/providers/meta_collection_provider.dart';
import 'package:utility_manager_flutter/widgets/single_url_bottomsheet.dart';

// ignore: must_be_immutable
class SingleCollectionView extends StatefulWidget {
  String? collectionName;
  SingleCollectionView({required this.collectionName});

  @override
  _SingleCollectionViewState createState() => _SingleCollectionViewState();
}

class _SingleCollectionViewState extends State<SingleCollectionView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final singleCollection = watch(
          userSingleMetaCollection(
            widget.collectionName.toString(),
          ),
        );
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                CupertinoIcons.back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              widget.collectionName.toString(),
            ),
          ),
          body: Center(
            child: singleCollection.map(
              data: (res) {
                return Container(
                  child: res.value.data.length < 1
                      ? Lottie.asset('assets/empty.json')
                      : ListView(
                          children: [
                            for (var i = 0; i < res.value.data.length; i++)
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          singleURLBottomSheet(
                                              context,
                                              res.value.data[i]['url'],
                                              res.value.data[i]['id']);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Image.network(res.value.data[i]
                                                    ['photoURL']),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  res.value.data[i]['title'],
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  res.value.data[i]
                                                      ['description'],
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  res.value.data[i]['type'],
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                  textAlign: TextAlign.center,
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
                        ),
                );
              },
              loading: (_) => SizedBox(
                width: 300.0,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).accentColor,
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
            ),
          ),
        );
      },
    );
  }
}
