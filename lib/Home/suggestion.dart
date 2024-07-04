import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:wheeloffate/Home/l10n/common.dart';
import 'package:wheeloffate/Home/staticData/staticData.dart';
import 'package:wheeloffate/Home/sug-fate.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({Key? key}) : super(key: key);

  @override
  _Suggestion createState() => _Suggestion();
}

class _Suggestion extends State<Suggestion> {
  String? oneriBaslik;
  List<String>? oneriler;
  List<String>? onerilerFilm;
  List<String>? onerilerYemek;
  List<String>? onerilerAktivite;
  int? onerilerListCount;
  Oneri oneriC = Oneri();
  String? o1;
  String? o2;
  String? o3;
  String? o4;
  String? o5;
  String? o6;
  int randomSayi = 0;

  @override
  void initState() {
    super.initState();
  }

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

    int randomSayiUret() {
      int sayi;
      sayi = Random().nextInt(11);
      return sayi;
    }

    void rastgeleDoldurCark() {
      List<int> eskiRandomSayi = [];
      int i = 0;
      List<int> secilmisSecenekler = [];
      while (secilmisSecenekler.length < 6) { // 6.indeksi ekledikten sonra durucak
        randomSayi = randomSayiUret();
        if (eskiRandomSayi.isNotEmpty && eskiRandomSayi.contains(randomSayi)) {
          continue;
        } else {
          secilmisSecenekler.add(randomSayi);
          eskiRandomSayi.add(randomSayi);
        }
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SugFate(oneriler![secilmisSecenekler[0]], oneriler![secilmisSecenekler[1]],
                oneriler![secilmisSecenekler[2]], oneriler![secilmisSecenekler[3]], oneriler![secilmisSecenekler[4]],
                  oneriler![secilmisSecenekler[5]])));
    }

    Future openDialog(oneriBaslik) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "$oneriBaslik",
              style: const TextStyle(fontFamily: "Righteous"),
            ),
            content: Container(
              width: screenWidth / 1.3,
              height: screenHeight / 2,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: onerilerListCount!,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      oneriler![index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        //fontStyle: FontStyle.italic,
                        //shadows: Shadow(blurRadius: 2,color: Colors.black,offset: Offset.infinite)
                        fontFamily: "Righteous",
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        rastgeleDoldurCark();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.rastgeleDoldur,
                        style: const TextStyle(fontFamily: "Righteous"),
                      )),
                ],
              )
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.oneriler,
          style: const TextStyle(fontFamily: "Righteous"),
        ),
        //centerTitle: true,
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
                    child: Text(
                      AppLocalizations.of(context)!.film,
                      style: const TextStyle(fontFamily: "Righteous"),
                    ))),
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
                      child: Text(
                        AppLocalizations.of(context)!.yemek,
                        style: const TextStyle(fontFamily: "Righteous"),
                      ))),
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
                      child: Text(
                        AppLocalizations.of(context)!.aktivite,
                        style: const TextStyle(fontFamily: "Righteous"),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
