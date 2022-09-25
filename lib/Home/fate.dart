import 'dart:ui';

import 'package:flutter/services.dart';
import 'dart:math';
import 'package:wheeloffate/Home/l10n/common.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Fate extends StatefulWidget {
  const Fate({Key? key}) : super(key: key);

  @override
  State<Fate> createState() => _Fate();
}

class _Fate extends State<Fate> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  // Google mobile ad Reklam Tanımlaması
  InterstitialAd? _interstitialAd;
  late bool _isAdLoaded = false;
  late bool ilkyukleme = true;
  List<Widget> textInputList = [];

  //----------------------
  // Seçenek Girişleri
  String? sonuc;
  String? choiceOne;
  String? choiceTwo;
  String? choiceThree;
  String? choiceFour;
  String? choiceFive;
  String? choiceSix;
  //--------------
  // Çark Dönerken Karar butonunu iptal et
  bool? _isButtonEnable = true;
  bool? _isBackButton = true;
  bool? _isAbsorting = false;
  //----------------------------
  // Text Field'ın index sayısı. bu duruma göre ekranda gösterilcek
  dynamic _textIndex = 1;
  //-----------------------
  var rastgeleSayi;

  @override
  void initState() {
    super.initState();
    // Google Ads Mob Başla
    _initAd();
    // ------------------
    // Çark Rotation Başla
    rastgeleSayi = Random().nextInt(360);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    //--------------------------
    setRotation(rastgeleSayi + 1440);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (_textIndex == 1) {
          await Future.delayed(const Duration(milliseconds: 700));
          if (rastgeleSayi > 0 && rastgeleSayi < 180) {
            sonuc = choiceOne;
          } else if (rastgeleSayi > 180 && rastgeleSayi < 360) {
            sonuc = choiceTwo;
          } else {
            sonuc = AppLocalizations.of(context)!.sansizlik;
          }
          _interstitialAd?.show();
          openDialog(sonuc).whenComplete(() => controller.reset());
          rastgeleSayi = Random().nextInt(360);
          setRotation(rastgeleSayi + 1440);
          setState(() {
            _isButtonEnable = true;
            _isBackButton = true;
            _isAbsorting = false;
          });
          setRotation(rastgeleSayi + 1440);
        } else if (_textIndex == 2) {
          await Future.delayed(const Duration(milliseconds: 700));
          if (rastgeleSayi > 0 && rastgeleSayi < 90) {
            sonuc = choiceOne;
          } else if (rastgeleSayi > 90 && rastgeleSayi < 180) {
            sonuc = choiceTwo;
          } else if (rastgeleSayi > 180 && rastgeleSayi < 270) {
            sonuc = choiceThree;
          } else if (rastgeleSayi > 270 && rastgeleSayi < 360) {
            sonuc = choiceFour;
          } else {
            sonuc = AppLocalizations.of(context)!.sansizlik;
          }
          _interstitialAd?.show();
          openDialog(sonuc).whenComplete(() => controller.reset());
          rastgeleSayi = Random().nextInt(360);
          setRotation(rastgeleSayi + 1440);
          setState(() {
            _isButtonEnable = true;
            _isBackButton = true;
            _isAbsorting = false;
          });
          setRotation(rastgeleSayi + 1440);
        } else {
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
          _interstitialAd?.show();
          openDialog(sonuc).whenComplete(() => controller.reset());
          rastgeleSayi = Random().nextInt(360);
          setState(() {
            _isButtonEnable = true;
            _isBackButton = true;
            _isAbsorting = false;
          });
          setRotation(rastgeleSayi + 1440);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (textInputList.isEmpty) {
      textInputList.add(_textFieldContainer(
          Colors.yellow, Colors.green, "choiceOne", "choiceTwo"));
    }
    setState(() {
      _textIndex = _textIndex;
    });
  }

  void _initAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: onLoaded,
          onAdFailedToLoad: (error) {},
        ));
  }

  void onLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        _interstitialAd?.dispose();
        _interstitialAd = null;
        _initAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _interstitialAd?.dispose();
      },
    );
  }

  void setRotation(int degrees) {
    double angle = degrees * pi / 180;
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
  }

  Future openDialog(text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.kaderinTavsiyesi),
          content: Container(
            child: Text(
                "${text != null ? text : "Çark Boş bıraktığınız seçenekte durdu."}"),
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

  void _addInputField(color, colors, choise, choises) {
    setState(() {
      textInputList.add(_textFieldContainer(color, colors, choise, choises));
    });
  }

  void _removeInputField() {
    setState(() {
      textInputList.removeLast();
    });
  }

  Widget _textFieldContainer(color, colors, choice, choices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextField(
              maxLength: 30,
              enabled: _isBackButton,
              onChanged: (value) {
                if (choice == "choiceOne") {
                  choiceOne = value;
                } else if (choice == "choiceThree") {
                  choiceThree = value;
                } else if (choice == "choiceFive") {
                  choiceFive = value;
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.secenekGir,
                counterText: "",
                filled: true,
                fillColor: color,
                hintStyle: const TextStyle(
                  fontFamily: "Righteous",
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextField(
              maxLength: 30,
              enabled: _isBackButton,
              onChanged: (value) {
                if (choices.toString() == "choiceTwo") {
                  choiceTwo = value;
                } else if (choices == "choiceFour") {
                  choiceFour = value;
                } else if (choices == "choiceSix") {
                  choiceSix = value;
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.secenekGir,
                counterText: "",
                filled: true,
                fillColor: colors,
                hintStyle: const TextStyle(fontFamily: "Righteous"),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    if (_isBackButton == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var screenInfo = MediaQuery.of(context);
    final double screenWidth = screenInfo.size.width;
    final double screenHeight = screenInfo.size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.kararVer,
            style: const TextStyle(fontFamily: "Righteous"),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight / 38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AbsorbPointer(
                  absorbing: _isAbsorting!,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      //return _textFieldContainer(index);
                      return textInputList.elementAt(index);
                    },
                    //itemCount: _textIndex,
                    itemCount: textInputList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                  ),
                ),
                AbsorbPointer(
                  absorbing: _isAbsorting!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (_textIndex == 1) {
                              _addInputField(Colors.blue, Colors.purple,
                                  "choiceThree", "choiceFour");
                              setState(() {
                                _textIndex = _textIndex! + 1;
                              });
                            } else if (_textIndex == 2) {
                              _addInputField(Colors.red, Colors.orange,
                                  "choiceFive", "choiceSix");
                              setState(() {
                                _textIndex = _textIndex! + 1;
                              });
                            }
                          },
                        ),
                      ),
                      const Text(
                        "Seçenek Arttır / Azalt",
                        style: TextStyle(fontFamily: "Righteous"),
                      ),
                      SizedBox(
                        width: 35,
                        child: IconButton(
                          icon:
                              const Icon(Icons.remove_circle_outline_outlined),
                          onPressed: () {
                            if (_textIndex != 1) {
                              setState(() {
                                _removeInputField();
                                _textIndex = _textIndex! - 1;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight / 80, top: screenHeight / 80),
                  child: Image.asset(
                    'src/img/Picture/kararUcgeni.png',
                    width: screenWidth / 15,
                  ),
                ),
                _textIndex == 1
                    ? AnimatedBuilder(
                        animation: animation,
                        child: AbsorbPointer(
                          absorbing: _isAbsorting!,
                          child: InkWell(
                            onTapDown: (details) {
                              controller.forward(from: 0);
                              setState(() {
                                _isBackButton = false;
                                _isButtonEnable = false;
                                _isAbsorting = true;
                              });
                            },
                            child: Image.asset(
                              'src/img/Picture/wheelTwo.png',
                              width: screenWidth / 1.25,
                            ),
                          ),
                        ),
                        builder: (context, child) => Transform.rotate(
                          angle: animation.value,
                          child: child,
                        ),
                      )
                    : _textIndex == 2
                        ? AnimatedBuilder(
                            animation: animation,
                            child: AbsorbPointer(
                              absorbing: _isAbsorting!,
                              child: InkWell(
                                onTapDown: (details) {
                                  controller.forward(from: 0);
                                  setState(() {
                                    _isBackButton = false;
                                    _isButtonEnable = false;
                                    _isAbsorting = true;
                                  });
                                },
                                child: Image.asset(
                                  'src/img/Picture/wheelFour.png',
                                  width: screenWidth / 1.3,
                                ),
                              ),
                            ),
                            builder: (context, child) => Transform.rotate(
                              angle: animation.value,
                              child: child,
                            ),
                          )
                        : AnimatedBuilder(
                            animation: animation,
                            child: AbsorbPointer(
                              absorbing: _isAbsorting!,
                              child: InkWell(
                                onTapDown: (details) {
                                  controller.forward(from: 0);
                                  setState(() {
                                    _isBackButton = false;
                                    _isButtonEnable = false;
                                    _isAbsorting = true;
                                  });
                                },
                                child: Image.asset(
                                  'src/img/Picture/wheelSix.png',
                                  width: screenWidth / 1.3,
                                ),
                              ),
                            ),
                            builder: (context, child) => Transform.rotate(
                              angle: animation.value,
                              child: child,
                            ),
                          ),
                Padding(
                  padding: EdgeInsets.only(top: screenWidth / 14),
                  child: SizedBox(
                    width: screenWidth / 2,
                    height: screenHeight / 18,
                    child: _isButtonEnable!
                        ? ElevatedButton(
                            onPressed: () {
                              controller.forward(from: 0);
                              setState(() {
                                _isButtonEnable = false;
                                _isBackButton = false;
                                _isAbsorting = true;
                              });
                            },
                            child: Text(AppLocalizations.of(context)!.kararVer))
                        : AbsorbPointer(
                            absorbing: _isAbsorting!,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                    AppLocalizations.of(context)!.kararVer),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey)),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
