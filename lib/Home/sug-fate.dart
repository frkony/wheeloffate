import 'package:flutter/services.dart';
import 'dart:math';
import 'package:wheeloffate/Home/l10n/common.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SugFate extends StatefulWidget {
  final String s1;
  final String s2;
  final String s3;
  final String s4;
  final String s5;
  final String s6;
  const SugFate(this.s1, this.s2, this.s3, this.s4, this.s5, this.s6,
      {Key? key})
      : super(
          key: key,
        );

  @override
  State<SugFate> createState() => _SugFateState();
}

class _SugFateState extends State<SugFate> with SingleTickerProviderStateMixin {
  // Seçenek Girişleri
  String? sonuc;
  //--------------
  late AnimationController controller;
  late Animation<double> animation;
  // Google mobile ad Reklam Tanımlaması
  InterstitialAd? _interstitialAd;
  late bool _isAdLoaded = false;
  //----------------------
  // Çark Dönerken Karar butonunu iptal et
  bool? _isButtonEnable = true;
  bool? _isBackButton = true;
  bool? _isAbsorting = false;
  //----------------------------
  @override
  void initState() {
    super.initState();
    // Google Ads Mob Başla
    _initAd();
    // ------------------
    // Çark Rotation Başla
    var rastgeleSayi = Random().nextInt(360);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    //--------------------------
    setRotation(rastgeleSayi + 1440);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        debugPrint("girdi");
        print(rastgeleSayi);
        await Future.delayed(const Duration(milliseconds: 700));
        if (rastgeleSayi > 0 && rastgeleSayi < 60) {
          sonuc = widget.s1;
        } else if (rastgeleSayi > 60 && rastgeleSayi < 120) {
          sonuc = widget.s2;
        } else if (rastgeleSayi > 120 && rastgeleSayi < 180) {
          sonuc = widget.s3;
        } else if (rastgeleSayi > 180 && rastgeleSayi < 240) {
          sonuc = widget.s4;
        } else if (rastgeleSayi > 240 && rastgeleSayi < 300) {
          sonuc = widget.s5;
        } else if (rastgeleSayi > 300 && rastgeleSayi < 360) {
          sonuc = widget.s6;
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
                "${text != null ? text! : "Hay Aksi! Önerilerde bir problem var. Lütfen Bildirin."}"),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s1),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s2),
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
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s3),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.secenekGir,
                            counterText: "",
                            filled: true,
                            fillColor: Colors.blue,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s4),
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
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s5),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: widget.s6),
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
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight / 80, top: screenHeight / 80),
                  child: Image.asset(
                    'src/img/Picture/kararUcgeni.png',
                    width: screenWidth / 15,
                  ),
                ),
                AnimatedBuilder(
                  animation: animation,
                  child: AbsorbPointer(
                    absorbing: _isAbsorting!,
                    child: InkWell(
                      onTapDown: (details) {
                        controller.forward(from: 0);
                        setState(() {
                          _isButtonEnable = false;
                          _isBackButton = false;
                          _isAbsorting = true;
                        });
                      },
                      child: Image.asset(
                        'src/img/Picture/wheelSix.png',
                        width: screenWidth / 1.25,
                      ),
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
