import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Casino extends StatefulWidget {
  const Casino({super.key, required this.title});

  final String title;

  @override
  State<Casino> createState() => _CasinoState();
}

class _CasinoState extends State<Casino> with TickerProviderStateMixin {
  final List<String> imageList = [
    'images/bar.png',
    'images/cerise.png',
    'images/cloche.png',
    'images/diamant.png',
    'images/fer-a-cheval.png',
    'images/pasteque.png',
    'images/sept.png',
  ];

  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Timer _timer;
  String randomImage1 = 'images/bar.png';
  String randomImage2 = 'images/cerise.png';
  String randomImage3 = 'images/cloche.png';

  String resultMessage = '';

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _controller1.addListener(() {
      setState(() {
        randomImage1 = getRandomImage();
      });
    });

    _controller2.addListener(() {
      setState(() {
        randomImage2 = getRandomImage();
      });
    });

    _controller3.addListener(() {
      setState(() {
        randomImage3 = getRandomImage();
      });
    });
  }

  String getRandomImage() {
    final random = Random();
    return imageList[random.nextInt(imageList.length)];
  }

  void checkResult() {
    setState(() {
      if (randomImage1 == randomImage2 && randomImage2 == randomImage3) {
        if (randomImage1 == 'images/sept.png' &&
            randomImage2 == 'images/sept.png' &&
            randomImage3 == 'images/sept.png') {
          resultMessage = "T'as fait que des 7 ! Joue au loto";
        } else {
          resultMessage = "Jackpot!";
        }
      } else {
        resultMessage = "You lost, try again!";
      }
    });
  }

  void startSlotMachine() {
    resultMessage = '';
    _controller1.repeat();
    _controller2.repeat();
    _controller3.repeat();

    _timer = Timer(const Duration(seconds: 1), () {
      _controller1.stop();
    });

    _timer = Timer(const Duration(seconds: 2), () {
      _controller2.stop();
    });

    _timer = Timer(const Duration(seconds: 3), () {
      _controller3.stop();
      checkResult();
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    randomImage1,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    randomImage2,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    randomImage3,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: startSlotMachine,
        tooltip: 'Relancer',
        child: const Text('+', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
