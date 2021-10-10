import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class AddUserDetails extends StatefulWidget {
  const AddUserDetails({Key? key}) : super(key: key);

  @override
  _AddUserDetailsState createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  final TextEditingController _usernameController = TextEditingController();
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add details"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Lottie.asset('assets/create_user.json'),
          TextFormField(
            controller: _usernameController,
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
              hintText: 'User Name',
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            errorMessage,
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          SizedBox(height: 25),
          RoundedButtonWidget(
            buttonText: 'Add User name',
            width: MediaQuery.of(context).size.width * 0.80,
            onpressed: () async {
              final allUserData = await supabase
                  .from('profiles')
                  .select()
                  .eq("username", _usernameController.text)
                  .single()
                  .execute();
              if (allUserData.data != null)
                setState(() {
                  errorMessage = "* User name already exists";
                });
              else {
                final ByteData imageData = await NetworkAssetBundle(Uri.parse(
                        "https://robohash.org/${_usernameController.text}.png"))
                    .load("");
                final Uint8List bytes = imageData.buffer.asUint8List();
                final fileExt = "png";
                final fileName = '${_usernameController.text}.$fileExt';
                final filePath = fileName;
                final response = await supabase.storage
                    .from('avatars')
                    .uploadBinary(filePath, bytes);
                final error = response.error;
                if (error != null) {
                  context.showErrorSnackBar(message: error.message);
                  return;
                }
                final imageUrlResponse =
                    supabase.storage.from('avatars').getPublicUrl(filePath);

                final updates = {
                  'id': supabase.auth.currentUser?.id,
                  'username': _usernameController.text,
                  'website': "",
                  "avatar_url": imageUrlResponse.data,
                  "updated_at": DateTime.now().toIso8601String()
                };
                final res =
                    await supabase.from('profiles').insert(updates).execute();
                final err = res.error;
                if (err != null)
                  context.showErrorSnackBar(message: err.message);
                else
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home', (route) => false);
              }
            },
          )
        ],
      ),
    );
  }
}
