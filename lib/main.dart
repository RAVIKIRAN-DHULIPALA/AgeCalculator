import 'package:flutter/material.dart';
import 'package:AgeCalculator/AgeUi.dart';
import 'package:flutter/services.dart';

Color mainBGColor = Color(0xFF652A78);
Color redColor = Color(0xFFDE3C10);
Color purpleColor = Color(0xFF8132AD);
Color cyan = Color(0xFF99D5E5);
Color orange = Color(0xFFE97A4D);

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.indigo, cursorColor: Colors.transparent),
    home: CustomPaintDemo(),
  ));
}

class CustomPaintDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.black,
        fontFamily: 'Google',
      ),
      home: Scaffold(
        body: CustomPaint(
          painter: MyCustomPainter(),
          child: Container(
            child: SplashScreen(),
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new AgeUi()
      },
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    Path mainBGPath = Path();
    mainBGPath.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    paint.color = mainBGColor;
    canvas.drawPath(mainBGPath, paint);

    Path purplePath = Path();
    purplePath.lineTo(size.width * .45, 0);
    purplePath.quadraticBezierTo(
        size.width * .25, size.height * .3, 0, size.height * 0.55);
    purplePath.close();
    paint.color = purpleColor;
    canvas.drawPath(purplePath, paint);

    Path redPath = Path();
    redPath.moveTo(size.width * 0.9, 0.0);
    redPath.quadraticBezierTo(
        size.width * .5, size.height * 0.1, 0, size.height * 0.85);
    redPath.lineTo(0, size.height);
    redPath.lineTo(size.width * 0.25, size.height);
    redPath.quadraticBezierTo(
        size.width * .5, size.height * 0.7, size.width, size.height * 0.6);
    redPath.lineTo(size.width, 0.0);
    redPath.close();
    paint.color = redColor;
    canvas.drawPath(redPath, paint);

    Path orangePath = Path();
    orangePath.moveTo(0, size.height * 0.75);
    orangePath.quadraticBezierTo(
        size.width * .25, size.height * 0.85, size.width * .40, size.height);
    orangePath.lineTo(0, size.height);
    orangePath.close();
    paint.color = orange;
    canvas.drawPath(orangePath, paint);

    Path trianglePath = Path();
    trianglePath.lineTo(size.width * .25, 0);
    trianglePath.lineTo(0, size.height * .25);
    trianglePath.close();
    paint.color = cyan;
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Center(
                          child: Image(
                            image:
                                new AssetImage("assets/icon/launcher_icon.png"),
                            width: 300.0,
                          ),
                        ),
                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 10.0),
//                      ),
                      Text(
                        "Age Calculator",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: "Google"),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.black,
                        onPressed: navigationPage,
                        child: new Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: "Google",
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
