import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utility_manager_flutter/providers/meta_info_provider.dart';
import 'package:utility_manager_flutter/widgets/meta_info.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class AddURL extends StatefulWidget {
  const AddURL({Key? key}) : super(key: key);

  @override
  _AddURLState createState() => _AddURLState();
}

class _AddURLState extends State<AddURL> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _showMeta = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final url = watch(urlProvider);

      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Add URL"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _controller,
                          onChanged: (val) {
                            if (val.isEmpty) {
                              _showMeta = false;
                            }
                          },
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
                            suffixIcon: InkWell(
                              onTap: () async {
                                var data =
                                    await Clipboard.getData('text/plain');
                                _controller.text = data!.text.toString();
                              },
                              child: Icon(
                                Icons.paste,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            hintText: 'Enter the URL',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedButtonWidget(
                        buttonText: "Get Info",
                        width: MediaQuery.of(context).size.width * 0.90,
                        onpressed: () {
                          if (_key.currentState!.validate()) {
                            url.listenToURL(_controller.text);
                            setState(() {
                              _showMeta = true;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CancelRoundedButtonWidget(
                        buttonText: "Cancel",
                        width: MediaQuery.of(context).size.width * 0.90,
                        onpressed: () {
                          if (_key.currentState!.validate()) {
                            url.listenToURL("");
                            setState(() {
                              _controller.text = "";
                              _showMeta = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: _showMeta ? MetaInfoDisplay(url, _key) : Text(""),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
