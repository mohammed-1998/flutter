import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:rippledemo/circle_painter.dart';
import 'package:rippledemo/curve_wave.dart';
import 'package:rippledemo/splash_screen.dart';


class RipplesAnimation extends StatefulWidget {
  const RipplesAnimation({Key key, this.size = 80.0, this.color = Colors.blue,
    this.onPressed, @required this.child,}) : super(key: key);
  final double size;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();

}

class _RipplesAnimationState extends State<RipplesAnimation> with TickerProviderStateMixin {

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    startTime();
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller.dispose();
    super.dispose();
  }
  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                Color.lerp(widget.color, Colors.white, .05)
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child:Container(
                width: 200,
                child:Text("الحل الأول للبرمجيات",style: TextStyle(fontSize: 25,fontFamily:  "Amiri"),textAlign: TextAlign.center,)
                ,
              )
          ),
        ),
      ),
    );
  }
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("المبيعات",style: TextStyle(fontFamily: "Amiri",fontSize: 25),),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(
            _controller,
            color: widget.color,
          ),
          child: SizedBox(
            width: widget.size * 4.125,
            height: widget.size * 4.125,
            child: _button(),
          ),
        ),
      ),
    );
  }
}

