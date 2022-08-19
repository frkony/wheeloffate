import 'package:wheeloffate/Home/Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wheeloffate/Home/l10n/l10n.dart';
import 'Home/l10n/common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Wheel Of Fate', // görev yöneticisi tarafında uygulama küçülünce görünücek olan Title.
      debugShowCheckedModeBanner: true,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: L10N.all,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const Home(),
    );
  }
}
