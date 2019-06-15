import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_show/songs.dart';
import 'button_controls.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              color: Color(0xffddddddd),
              onPressed: () => {},
            ),
            title: Text(''),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                color: Color(0xffddddddd),
                onPressed: () => {},
              ),
            ]),
        body: Column(
          children: <Widget>[
            //seek bar
            Expanded(
                child: Center(
                    child: Container(
              width: 125.0,
              height: 125.0,
              child: RadialSeekBar(
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Image.network(
                    demoPlaylist.songs[0].albumArtUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ))),
            // visualizer
            Container(
              width: double.infinity,
              height: 125.0,
            ),
            // title  artist name and controls
            new ButtonControls()
          ],
        ));
  }
}

class RadialSeekBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final double progressPercent;
  final Color progressColor;
  final double thumbWidth;
  final Color thumbColor;
  final double thumbPosition;
  final Widget child;

  RadialSeekBar({
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.thumbColor = Colors.black,
    this.thumbWidth = 10.0,
    this.thumbPosition = 0.0,
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.child,
  });

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadiusSeekBarPainter(
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressColor: widget.progressColor,
          progressWidth: widget.progressWidth,
          progressPercent: widget.progressPercent,
          thumbColor: widget.thumbColor,
          thumbWidth: widget.thumbWidth,
          thumbPosition: widget.thumbPosition
          ),
      child: widget.child,
    );
  }
}

class RadiusSeekBarPainter extends CustomPainter {
  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final double progressPercent;
  final Paint progressPaint;
  final double thumbWidth;
  final double thumbPosition;
  final Paint thumbPaint;
  RadiusSeekBarPainter({
    @required this.progressWidth,
    @required progressColor,
    @required this.progressPercent,
    @required thumbColor,
    @required this.thumbWidth,
    @required this.thumbPosition,
    @required this.trackWidth,
    @required trackColor,
  })  : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    // final center = Offset(size.width / 2, size.height / 2);
    // final radius = min(size.height, size.width) / 2;
    // track
    // canvas.drawCircle(
    //   center,
    //   radius,
    //   trackPaint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
