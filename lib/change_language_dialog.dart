import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import '../main.dart';
import 'account.dart';

class ChangeLanguageDialog extends StatefulWidget {
  @override
  _ChangeLanguageDialogState createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(end: 16, top: 16),
                      alignment: AlignmentDirectional.topEnd,
                      child: Image.asset("assets/images/close.png", width: 25, height: 25),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: RadioButtonGroup(
                        picked: account.language != null && account.language == "en"
                            ? "English"
                            : "العربية",
                        labels: <String>["العربية", "English"],
                        onSelected: (String checked) {

                          if (checked == "العربية") {
                            Navigator.of(context).pop();
                            account.language = "ar";
                            delegate.changeLocale(Locale("ar"));
                          } else {
                            Navigator.of(context).pop();
                            account.language = "en";
                            delegate.changeLocale(Locale("en"));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
