import 'package:flutter/services.dart';
import 'dart:math';
import 'package:wheeloffate/Home/l10n/common.dart';

class Fate extends StatefulWidget {
  const Fate({Key? key}) : super(key: key);

  final String username = 'faruk';
  @override
  State<Fate> createState() => _Fate();
}

class _Fate extends State<Fate> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  String? sonuc;
  String? choiceOne;
  String? choiceTwo;
  String? choiceThree;
  String? choiceFour;
  String? choiceFive;
  String? choiceSix;
  bool? _isButtonEnable = true;

  @override
  void initState() {
    super.initState();
    var rastgeleSayi = Random().nextInt(360);
    //debugPrint('rastgele sayi : $rastgeleSayi');
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 700));
        if (rastgeleSayi > 0 && rastgeleSayi < 60) {
          sonuc = choiceOne;
        } else if (rastgeleSayi > 60 && rastgeleSayi < 120) {
          sonuc = choiceTwo;
        } else if (rastgeleSayi > 120 && rastgeleSayi < 180) {
          sonuc = choiceThree;
        } else if (rastgeleSayi > 180 && rastgeleSayi < 240) {
          sonuc = choiceFour;
        } else if (rastgeleSayi > 240 && rastgeleSayi < 300) {
          sonuc = choiceFive;
        } else if (rastgeleSayi > 300 && rastgeleSayi < 360) {
          sonuc = choiceSix;
        } else {
          sonuc = AppLocalizations.of(context)!.sansizlik;
        }
        openDialog(sonuc).whenComplete(() => controller.reset());
        rastgeleSayi = Random().nextInt(360);
        setRotation(rastgeleSayi + 1440);
        setState(() {
          _isButtonEnable = true;
        });
      }
    });
    setRotation(rastgeleSayi + 1440);
  }

  void setRotation(int degrees) {
    double angle = degrees * pi / 180;
    debugPrint("angle : $angle, degrees : $degrees");
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
  }

  Future openDialog(text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.kaderinTavsiyesi),
          content: Container(
            width: 100,
            height: 40,
            child: Text("$text"),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 20),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    var screenInfo = MediaQuery.of(context);
    final double screenWidth = screenInfo.size.width;
    final double screenHeight = screenInfo.size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.kararVer),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight / 38),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                // 1
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1-1
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        //obscureText: true,
                        maxLength: 30,
                        onChanged: (value) {
                          choiceOne = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.red,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  // 1-2
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        maxLength: 30,
                        onChanged: (value) {
                          choiceTwo = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.orange,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // 2
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2-1
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        maxLength: 30,
                        onChanged: (value) {
                          choiceThree = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.yellow,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  // 2-2
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        maxLength: 30,
                        onChanged: (value) {
                          choiceFour = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.green,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 3-1
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        maxLength: 30,
                        onChanged: (value) {
                          choiceFive = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.cyan,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  // 3-2
                  Padding(
                    padding: EdgeInsets.all(screenWidth / 150),
                    child: SizedBox(
                      width: screenWidth / 2.10,
                      child: TextField(
                        maxLength: 30,
                        onChanged: (value) {
                          choiceSix = value;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.secenekGir,
                          counterText: "",
                          filled: true,
                          fillColor: Colors.purple,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 40),
                child: Image.asset(
                  'src/img/Picture/kararUcgeni.png',
                  width: screenWidth / 15,
                ),
              ),
              AnimatedBuilder(
                animation: animation,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight / 100),
                  child: Image.asset(
                    'src/img/Picture/wheel.png',
                    width: screenWidth / 1.3,
                  ),
                ),
                builder: (context, child) => Transform.rotate(
                  angle: animation.value,
                  child: child,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth / 10),
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 18,
                  child: _isButtonEnable!
                      ? ElevatedButton(
                          onPressed: () {
                            controller.forward(from: 0);
                            setState(() {
                              _isButtonEnable = false;
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.kararVer))
                      : ElevatedButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.kararVer),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
