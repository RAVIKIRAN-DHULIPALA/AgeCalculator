import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:AgeCalculator/CustomShapeClipper.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class AgeUi extends StatefulWidget {
  @override
  _AgeUiState createState() => _AgeUiState();
}

class _AgeUiState extends State<AgeUi> with TickerProviderStateMixin {
  double month = 0.0;
  double y = 0.0;
  int years = 0;
  int weeks = 0;
  int days = 0;

  int no_of_days = 0;
  double total_hours = 0.0;
  double total_minutes = 0.0;
  double total_seconds = 0.0;

  Animation animation1, animation2, animation3;
  AnimationController animationController1,
      animationController2,
      animationController3;

  Animation animation11, animation22, animation33, animation44, animation55;
  AnimationController animationController11,
      animationController22,
      animationController33,
      animationController44,
      animationController55;

  var birthdate = new TextEditingController(text: "");
  var birthmonth = new TextEditingController(text: "");
  var birthyear = new TextEditingController(text: "");

  var currentdate =
      new TextEditingController(text: DateTime.now().day.toString());
  var currentmonth =
      new TextEditingController(text: DateTime.now().month.toString());
  var currentyear =
      new TextEditingController(text: DateTime.now().year.toString());

  var birth_year, birth_month, birth_day;
  var curdate, curmonth, curyear;

  FocusNode myFocusNode, myfocusnode1, myfocusnode2;
  FocusNode mf1, mf2, mf3;

  @override
  void initState() {
    animationController1 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation1 = animationController1;

    animationController2 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2500));
    animation2 = animationController2;

    animationController3 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3500));
    animation3 = animationController3;

    animationController11 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation11 = animationController11;

    animationController22 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2500));
    animation22 = animationController22;

    animationController33 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3500));
    animation33 = animationController33;

    animationController44 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3500));
    animation44 = animationController44;

    animationController55 = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3500));
    animation55 = animationController55;

    super.initState();

    myFocusNode = FocusNode();
    myfocusnode1 = FocusNode();
    myfocusnode2 = FocusNode();

    mf1 = FocusNode();
    mf2 = FocusNode();
    mf3 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();

    animationController11.dispose();
    animationController22.dispose();
    animationController33.dispose();
    animationController33.dispose();
    animationController44.dispose();
    animationController55.dispose();

    myFocusNode.dispose();
    myfocusnode1.dispose();
    myfocusnode2.dispose();

    mf1.dispose();
    mf2.dispose();
    mf3.dispose();

    super.dispose();
  }

  void _share() {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "Let me recommend you the Age Calculator Application link :" +
            "https://play.google.com/store/apps/details?id=com.ravi.agecalculator&hl=en",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void showpicker() {
//    print("hello " + birthyear.text.toString());
    showDatePicker(
            context: context,
            initialDate: birthdate.text != "" &&
                    birthmonth.text != "" &&
                    birthyear.text != ""
                ? new DateTime(int.parse(birthyear.text),
                    int.parse(birthmonth.text), int.parse(birthdate.text))
                : new DateTime.now(),
            firstDate: new DateTime(1900),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      setState(() {
        birthdate.text = dt.day.toString();
        birthmonth.text = dt.month.toString();
        birthyear.text = dt.year.toString();
      });
    });
  }

  void showPicker() {
    showDatePicker(
            context: context,
            initialDate: currentdate.text != "" &&
                    currentmonth.text != "" &&
                    currentyear.text != ""
                ? new DateTime(int.parse(currentyear.text),
                    int.parse(currentmonth.text), int.parse(currentdate.text))
                : new DateTime.now(),
            firstDate: new DateTime(1900),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      setState(() {
        currentdate.text = dt.day.toString();
        currentmonth.text = dt.month.toString();
        currentyear.text = dt.year.toString();
      });
    });
  }

  void calculateAge() {
    birth_day = int.parse(birthdate.text);
    birth_month = int.parse(birthmonth.text);
    birth_year = int.parse(birthyear.text);

    curdate = int.parse(currentdate.text);
    curmonth = int.parse(currentmonth.text);
    curyear = int.parse(currentyear.text);

    DateTime birthdates = DateTime(birth_year, birth_month, birth_day);
    DateTime now = DateTime(curyear, curmonth, curdate);
    no_of_days = now.difference(birthdates).inDays;

//    get years
    years = now.year - birthdates.year;

    // get months
    int currMonth = now.month + 1;
    int birthMonth = birthdates.month + 1;

    //Get difference between months
    month = (currMonth - birthMonth).toDouble();

    //if month difference is in negative then reduce years by one
    //and calculate the number of months.
    if (month < 0) {
      years--;
      month = (12 - birthMonth + currMonth).toDouble();
      if (now.day < birthdates.day) month--;
    } else if (month == 0 && now.day < birthdates.day) {
      years--;
      month = 11;
    }
//   get days
    if (now.day > birthdates.day)
      days = now.day - birthdates.day;
    else if (now.day < birthdates.day) {
      int today = now.day;
      now = new DateTime(now.year, now.month - 1, now.day);
      var beginningNextMonth = (now.month < 12)
          ? new DateTime(now.year, now.month + 1, 1)
          : new DateTime(now.year + 1, 1, 1);
      var lastDay = beginningNextMonth.subtract(new Duration(days: 1)).day;
      days = lastDay - birthdates.day + today;
    } else {
      days = 0;
      if (month == 12) {
        years++;
        month = 0;
      }
    }

    total_hours = (no_of_days * 24).toDouble();
    total_minutes = (no_of_days * 1440).toDouble();
    total_seconds = (no_of_days * 86400).toDouble();

    DateTime now1 = DateTime(curyear, curmonth, curdate);
    var next_bday = new DateTime(now1.year, birthdates.month, birthdates.day);
    int nxt_bday = 0;
    if (next_bday.isBefore(now1) || next_bday == now) {
      nxt_bday = new DateTime(now1.year + 1, birthdates.month, birthdates.day)
          .difference(now1)
          .inDays;
    } else if (next_bday.isAfter(now1)) {
      nxt_bday = next_bday.difference(now1).inDays;
    }

    animation1 =
        new Tween<double>(begin: animation1.value, end: years.toDouble())
            .animate(new CurvedAnimation(
                curve: Curves.fastOutSlowIn, parent: animationController1));

    animationController1.forward(from: 0.0);

    animation2 = new Tween<double>(begin: animation2.value, end: month).animate(
        new CurvedAnimation(
            curve: Curves.fastOutSlowIn, parent: animationController2));

    animationController2.forward(from: 0.0);

    animation3 =
        new Tween<double>(begin: animation3.value, end: days.toDouble())
            .animate(new CurvedAnimation(
                curve: Curves.fastOutSlowIn, parent: animationController3));

    animationController3.forward(from: 0.0);

    animation11 =
        new Tween<double>(begin: animation11.value, end: no_of_days.toDouble())
            .animate(new CurvedAnimation(
                curve: Curves.fastOutSlowIn, parent: animationController11));

    animationController11.forward(from: 0.0);

    animation22 =
        new Tween<double>(begin: animation22.value, end: total_hours.toDouble())
            .animate(new CurvedAnimation(
                curve: Curves.fastOutSlowIn, parent: animationController22));

    animationController22.forward(from: 0.0);

    animation33 = new Tween<double>(
            begin: animation33.value, end: total_minutes.toDouble())
        .animate(new CurvedAnimation(
            curve: Curves.fastOutSlowIn, parent: animationController33));

    animationController33.forward(from: 0.0);

    animation44 = new Tween<double>(
            begin: animation44.value, end: total_seconds.toDouble())
        .animate(new CurvedAnimation(
            curve: Curves.fastOutSlowIn, parent: animationController44));

    animationController44.forward(from: 0.0);

    animation55 =
        new Tween<double>(begin: animation55.value, end: nxt_bday.toDouble())
            .animate(new CurvedAnimation(
                curve: Curves.fastOutSlowIn, parent: animationController55));

    animationController55.forward(from: 0.0);
  }

//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 480.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF47D15), Colors.purple[400]],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
//              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: <Widget>[
                    new Text(
                      "Age Calculator",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: IconButton(
                        icon: new Icon(Icons.share, color: Colors.white),
                        onPressed: _share,
                      ),
                    ),
                  ],
                ),
              ),
//    SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Align(
                  child: Text(
                    "Birth Date",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 30.0,
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: birthdate,
                            focusNode: myFocusNode,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "DD",
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 2) {
                                FocusScope.of(context)
                                    .requestFocus(myfocusnode1);
                              }
                            },
                          ),
                          flex: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            "/",
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: birthmonth,
                            focusNode: myfocusnode1,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "MM",
                              alignLabelWithHint: true,
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 2) {
                                FocusScope.of(context)
                                    .requestFocus(myfocusnode2);
                              }
                              if (out.length == 0) {
                                FocusScope.of(context)
                                    .requestFocus(myFocusNode);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            "/",
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: birthyear,
                            focusNode: myfocusnode2,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "YYYY",
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 4) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              }
                              if (out.length == 0) {
                                FocusScope.of(context)
                                    .requestFocus(myfocusnode1);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: new IconButton(
                              icon: Icon(Icons.calendar_today),
                              iconSize: 35.0,
                              color: Colors.black,
                              onPressed: showpicker,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Align(
                  child: Text(
                    "Today's Date",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          width: 30.0,
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: currentdate,
                            focusNode: mf1,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "DD",
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 2) {
                                FocusScope.of(context).requestFocus(mf2);
                              }
                            },
                          ),
                          flex: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            "/",
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: currentmonth,
                            focusNode: mf2,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "MM",
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 2) {
                                FocusScope.of(context).requestFocus(mf3);
                              }
                              if (out.length == 0) {
                                FocusScope.of(context).requestFocus(mf1);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            "/",
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        new Flexible(
                          child: new TextField(
                            controller: currentyear,
                            focusNode: mf3,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Google",
                                fontSize: 18.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hasFloatingPlaceholder: false,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5.0, top: 5.0),
                              hintText: "YYYY",
                              counterText: "",
                            ),
                            onChanged: (String out) {
                              if (out.length == 4) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              }
                              if (out.length == 0) {
                                FocusScope.of(context).requestFocus(mf2);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: new IconButton(
                              icon: Icon(Icons.calendar_today),
                              iconSize: 35.0,
                              color: Colors.black,
                              onPressed: showPicker,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: calculateAge,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    elevation: 20.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        AnimatedBuilder(
                                          animation: animation1,
                                          builder: (context, child) => new Text(
                                                "${animation1.value.toStringAsFixed(0)}",
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: "Google",
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                        ),
                                        Text(
                                          'Years',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        new AnimatedBuilder(
                                          animation: animation2,
                                          builder: (context, child) => new Text(
                                                "${animation2.value.toStringAsFixed(0)}",
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: "Google",
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                        ),
                                        Text(
                                          'Months',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        AnimatedBuilder(
                                          animation: animation3,
                                          builder: (context, child) => new Text(
                                                "${animation3.value.toStringAsFixed(0)}",
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: "Google",
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                        ),
                                        Text(
                                          'Days',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Total Days:',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    AnimatedBuilder(
                                      animation: animation11,
                                      builder: (context, child) => new Text(
                                            "${animation11.value.toStringAsFixed(0)} Days",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "Google",
                                                fontStyle: FontStyle.normal),
                                          ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Total Hours:',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    AnimatedBuilder(
                                      animation: animation22,
                                      builder: (context, child) => new Text(
                                            "${animation22.value.toStringAsFixed(0)} Hours",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "Google",
                                                fontStyle: FontStyle.normal),
                                          ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Total Minutes:',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 23.0,
                                    ),
                                    AnimatedBuilder(
                                      animation: animation33,
                                      builder: (context, child) => new Text(
                                            "${animation33.value.toStringAsFixed(0)} Min",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "Google",
                                                fontStyle: FontStyle.normal),
                                          ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Total Seconds:',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    AnimatedBuilder(
                                      animation: animation44,
                                      builder: (context, child) => new Text(
                                            "${animation44.value.toStringAsFixed(0)} Sec",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "Google",
                                                fontStyle: FontStyle.normal),
                                          ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Next Birthday in:',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    AnimatedBuilder(
                                      animation: animation55,
                                      builder: (context, child) => new Text(
                                            "${animation55.value.toStringAsFixed(0)} Days",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "Google",
                                                fontStyle: FontStyle.normal),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
