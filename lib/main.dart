import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:intl/intl.dart';

import 'account.dart';
import 'change_language_dialog.dart';

late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await account.getPreferences();

  final locale = account?.language ?? "ar";

  delegate = await LocalizationDelegate.create(
    fallbackLocale: locale,
    supportedLocales: ['ar', 'en'],
  );
  await delegate.changeLocale(Locale(locale));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) {
      setState(() {
        Intl.defaultLocale = value.languageCode;
      });
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedApp(delegate, LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            return MaterialApp(
              title: 'Seyana Tech',
              localizationsDelegates: [
                CountryLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                delegate,
              ],
              debugShowCheckedModeBanner: false,
              locale: delegate.currentLocale,
              supportedLocales: delegate.supportedLocales,
              theme: ThemeData(
                fontFamily: "Janna_LT_Bold",

                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MyHomePage(),
            );
          });
    }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localization"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              translate("welcome"),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return ChangeLanguageDialog();
                      });
                },
                child: Text(
                  translate("change_lang"),
                ))
          ],
        ),
      ),
    );
  }
}
