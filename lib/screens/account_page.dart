import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/providers/fetch_user_details_provider.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    }
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Consumer(builder: (context, watch, child) {
        final userDetails = watch(getSingleUserDetailsProvider);
        return Center(
          child: Container(
            child: userDetails.map(
              data: (res) => Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(res.value.data["avatar_url"].toString()),
                      backgroundColor: Theme.of(context).accentColor,
                      minRadius: 50,
                      maxRadius: 75,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      res.data?.value.data['username'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RoundedButtonWidget(
                      buttonText: "Logout",
                      width: MediaQuery.of(context).size.width * 0.80,
                      onpressed: _signOut,
                    ),
                  ],
                ),
              ),
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
      }),
    );
  }
}
