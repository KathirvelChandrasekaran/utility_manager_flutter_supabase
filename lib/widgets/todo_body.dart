import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:utility_manager_flutter/providers/todo_list_provider.dart';
import 'package:utility_manager_flutter/utils/constants.dart';

Consumer todoBody() {
  return Consumer(builder: (context, watch, child) {
    final todos = watch(todoListProvider);
    return Center(
        child: todos.map(
      data: (res) {
        return Container(
          child: res.value.data.length < 1
              ? Lottie.asset('assets/empty.json')
              : ListView(
                  children: [
                    for (var i = 0; i < res.value.data.length; i++)
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IconSlideAction(
                              caption: 'Delete',
                              color: Colors.blue,
                              icon: Icons.delete_forever_rounded,
                              onTap: () async {
                                await supabase.from('TodoList').delete().match(
                                    {'id': res.value.data[i]['id']}).execute();
                                context.showSnackBar(
                                    message: "Successfully deleted!");
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IconSlideAction(
                              caption: 'Share',
                              color: Colors.indigo,
                              icon: Icons.share,
                              onTap: () {
                                Share.share(
                                    'Check out the todo ${res.value.data[i]['task_name']}');
                              },
                            ),
                          ),
                        ],
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(
                                        int.parse(res.value.data[i]['color'])),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          res.value.data[i]['task_name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          res.value.data[i]['task_description'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          res.value.data[i]['date_time'],
                                          style: TextStyle(
                                            color: Colors.white,
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
                            ],
                          ),
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
    ));
  });
}
