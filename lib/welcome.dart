import 'package:flutter/material.dart';
import 'package:gdg_devfest_flutter/app_bottomnav.dart';
//Code From: https://github.com/CRivasGomez/flutter-ui-ux-designs/blob/master/authentication/animated_background/lib/src/onboarding_page.dart

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 15));
    _backgroundAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _controller.reset();
              _controller.forward();
            }
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/welcome.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: FractionalOffset(_backgroundAnimation.value, 0),
            colorBlendMode: BlendMode.dstATop,
          ),
          Center(
            child:
                Text('M Recipes', style: Theme.of(context).textTheme.display2),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 60,
                    padding: EdgeInsets.zero,
                    child: MaterialButton(
                      child: Text(
                        'Welcome',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.tealAccent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Colors.white12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => NetworkNav()));
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
