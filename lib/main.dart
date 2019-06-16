import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slide_show/songs.dart';
import 'button_controls.dart';
import 'theme.dart';
import 'package:fluttery/gestures.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

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
    return Audio(
      audioUrl: demoPlaylist.songs[0].audioUrl,
      playbackState: PlaybackState.paused,
      child: Scaffold(
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
                child: AudioRadialSeekBar(),
              ),
              // visualizer
              Container(
                width: double.infinity,
                height: 125.0,
              ),
              // title  artist name and controls
              new ButtonControls()
            ],
          )),
    );
  }
}

class AudioRadialSeekBar extends StatefulWidget {
  @override
  _AudioRadialSeekBarState createState() => _AudioRadialSeekBarState();
}

class _AudioRadialSeekBarState extends State<AudioRadialSeekBar> {
  double _seekPercent;
  @override
  Widget build(BuildContext context) {
    return AudioComponent(
                  updateMe: [
                    WatchableAudioProperties.audioPlayhead,
                    WatchableAudioProperties.audioSeeking,
                  ],
                  playerBuilder:
                      (BuildContext context, AudioPlayer player, Widget child) {
                    double playbackProgress = 0.0;
                    if (player.audioLength != null && player.position != null) {
                      playbackProgress = player.position.inMilliseconds /
                          player.audioLength.inMilliseconds;
                    }
                    _seekPercent=player.isSeeking ? _seekPercent: null;
                    return RadialBar(
                        progress: playbackProgress,
                        seekPercent: _seekPercent,
                        onSeekRequest: (double seekPercent) {
                          setState(() => _seekPercent = seekPercent);
                          final seekMillis =
                              (player.audioLength.inMilliseconds * seekPercent)
                                  .round();
                          player.seek(Duration(milliseconds: seekMillis));
                        });
                  },
                );
  }
}

class RadialBar extends StatefulWidget {
  final double progress;
  final seekPercent;
  final Function(double) onSeekRequest;
  RadialBar({this.seekPercent = 0.2, this.progress, this.onSeekRequest});
  @override
  _RadialBarState createState() => _RadialBarState();
}

class _RadialBarState extends State<RadialBar> {
  PolarCoord _strartDragCoord;
  double _startDragPercent;
  double _currentDragPercent;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(RadialBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _progress = widget.progress;
  }

  void _onDragStart(PolarCoord coord) {
    _strartDragCoord = coord;
    _startDragPercent = _progress;
  }

  void _onDragUpdate(PolarCoord coord) {
    final dragAngel = coord.angle - _strartDragCoord.angle;
    final dragPercent = dragAngel / (2 * pi);
    setState(
        () => _currentDragPercent = (_startDragPercent + dragPercent) % 1.0);
  }

  void _onDragEnd() {
    if (widget.onSeekRequest != null) {
      widget.onSeekRequest(_currentDragPercent);
    }
    setState(() {
      _currentDragPercent = null;
      _strartDragCoord = null;
      _startDragPercent = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = _progress;
    if (_currentDragPercent != null) {
      thumbPosition = _currentDragPercent;
    } else if (widget.seekPercent != null) {
      thumbPosition = widget.seekPercent;
    }
    return RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Center(
            child: Container(
          width: 140.0,
          height: 140.0,
          child: RadialSeekBar(
            progressPercent: _progress,
            thumbPosition: thumbPosition,
            innerPadding: EdgeInsets.all(8.0),
            progressColor: accentColor,
            thumbColor: lightAccentColor,
            trackColor: Color(0xffdddddd),
            child: ClipOval(
              clipper: CircleClipper(),
              child: Image.network(
                demoPlaylist.songs[0].albumArtUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
      ),
    );
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
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
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
    this.innerPadding = const EdgeInsets.all(0.0),
    this.outerPadding = const EdgeInsets.all(0.0),
    this.child,
  });

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  EdgeInsets _insetForPainters() {
    final outerThickness =
        max(widget.trackWidth, max(widget.progressWidth, widget.thumbWidth)) /
            2.0;
    return EdgeInsets.all(outerThickness);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: CustomPaint(
        foregroundPainter: RadiusSeekBarPainter(
            trackWidth: widget.trackWidth,
            trackColor: widget.trackColor,
            progressColor: widget.progressColor,
            progressWidth: widget.progressWidth,
            progressPercent: widget.progressPercent,
            thumbColor: widget.thumbColor,
            thumbWidth: widget.thumbWidth,
            thumbPosition: widget.thumbPosition),
        child: Padding(
          padding: _insetForPainters() + widget.innerPadding,
          child: widget.child,
        ),
      ),
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
    final outerThickness = max(trackWidth, max(progressWidth, thumbWidth));
    Size contrainedSize = Size(
      size.width - outerThickness,
      size.height - outerThickness,
    );
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(contrainedSize.height, contrainedSize.width) / 2;
    // track
    canvas.drawCircle(
      center,
      radius,
      trackPaint,
    );
    // paint progress
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      pi * 2 * progressPercent,
      false,
      progressPaint,
    );
    final thumAngel = 2 * pi * thumbPosition - (pi / 2);
    final thumCenter =
        Offset(cos(thumAngel) * radius, sin(thumAngel) * radius) + center;
    canvas.drawCircle(thumCenter, thumbWidth / 2.0, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
