import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/providers/todo_list_provider.dart';

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
                      Container(
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
