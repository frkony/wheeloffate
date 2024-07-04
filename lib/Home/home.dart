import 'package:flutter/services.dart';
import 'package:wheeloffate/Home/fate.dart';
import 'package:wheeloffate/Home/suggestion.dart';
import 'l10n/common.dart';

enum Menu { itemOne, itemTwo }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var screenInfo = MediaQuery.of(context);
    final double screenWidth = screenInfo.size.width;
    final double screenHeight = screenInfo.size.height;

    _decisionButtonOnPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Fate()),
      );
    }

    _suggestionsButtonOnPressed() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Suggestion()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 8),
              child: SizedBox(
                width: screenWidth / 1.2,
                child: Image.asset(
                  "src/img/AppLogo/logo.png",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 12),
              child: SizedBox(
                width: screenWidth / 1.8,
                height: screenHeight / 16,
                child: ElevatedButton(
                  onPressed: () {
                    _decisionButtonOnPressed();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.karariniSenVer,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 20),
              child: SizedBox(
                width: screenWidth / 2.8,
                height: screenHeight / 18,
                child: ElevatedButton(
                    onPressed: () {
                      _suggestionsButtonOnPressed();
                    },
                    child: Text(AppLocalizations.of(context)!.oneriler,
                        style: const TextStyle(
                          fontSize: 16,
                        ))),
              ),
            ),
            const Spacer(flex: 100),
            Image.asset(
              "src/img/EofLogo/eof.png",
              width: 75,
              height: 75,
            ),
          ],
        ),
      ),
    );
  }
}
