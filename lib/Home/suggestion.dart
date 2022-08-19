import 'package:flutter/services.dart';
import 'package:wheeloffate/Home/l10n/common.dart';
import 'package:wheeloffate/Home/staticData/staticData.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({Key? key}) : super(key: key);

  @override
  _Suggestion createState() => _Suggestion();
}

class _Suggestion extends State<Suggestion> {
  String? oneriBaslik;
  List<String>? oneriler;
  int? onerilerListCount;
  Oneri oneriC = Oneri();

  void listeOlustur() {
    if (oneriBaslik == AppLocalizations.of(context)!.film) {
      oneriler = oneriC.OneriFilm(context);
      onerilerListCount = oneriler!.length;
    } else if (oneriBaslik == AppLocalizations.of(context)!.yemek) {
      oneriler = oneriC.OneriYemek(context);
      onerilerListCount = oneriler!.length;
    } else if (oneriBaslik == AppLocalizations.of(context)!.aktivite) {
      oneriler = oneriC.OneriAktivite(context);
      onerilerListCount = oneriler!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var screenInfo = MediaQuery.of(context);
    final double screenWidth = screenInfo.size.width;
    final double screenHeight = screenInfo.size.height;

    Future openDialog(oneriBaslik) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("$oneriBaslik"),
            content: Container(
              width: screenWidth / 1.3,
              height: screenHeight / 2,
              child: ListView.builder(
                itemCount: onerilerListCount,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(oneriler![index]),
                  );
                },
              ),
            ),
            actions: const [
              //Text("OK"),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.oneriler),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: screenWidth / 1.5,
                height: screenHeight / 16,
                child: ElevatedButton(
                    onPressed: () {
                      oneriBaslik = AppLocalizations.of(context)!.film;
                      listeOlustur();
                      openDialog(oneriBaslik);
                    },
                    child: Text(AppLocalizations.of(context)!.film))),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 50),
              child: SizedBox(
                  width: screenWidth / 1.5,
                  height: screenHeight / 16,
                  child: ElevatedButton(
                      onPressed: () {
                        oneriBaslik = AppLocalizations.of(context)!.yemek;
                        listeOlustur();
                        openDialog(oneriBaslik);
                      },
                      child: Text(AppLocalizations.of(context)!.yemek))),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 50),
              child: SizedBox(
                  width: screenWidth / 1.5,
                  height: screenHeight / 16,
                  child: ElevatedButton(
                      onPressed: () {
                        oneriBaslik = AppLocalizations.of(context)!.aktivite;
                        listeOlustur();
                        openDialog(oneriBaslik);
                      },
                      child: Text(AppLocalizations.of(context)!.aktivite))),
            ),
          ],
        ),
      ),
    );
  }
}
