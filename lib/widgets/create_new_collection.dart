import 'package:flutter/material.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

Future<dynamic> createNewCollection(
    BuildContext context, TextEditingController _controller) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).dividerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Text(
          "Collection Name",
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 150,
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  hintText: 'Collection name',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RoundedButtonWidget(
                buttonText: "Create",
                width: MediaQuery.of(context).size.width,
                onpressed: () async {
                  await supabase.from('UserURLCollection').insert([
                    {
                      'collection_name': _controller.text,
                      'email': supabase.auth.currentUser?.email
                    }
                  ]).execute();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
