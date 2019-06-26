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
      title: 'Player',
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
    return AudioPlaylist(
      playlist: demoPlaylist.songs.map((DemoSong song) {
        return song.audioUrl;
      }).toList(growable: false),
      playbackState: PlaybackState.playing,
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
                child: AudioPlaylistComponent(
                  playlistBuilder:
                      (BuildContext context, Playlist playlist, Widget child) {
                    final String albumArtUrl =
                        demoPlaylist.songs[playlist.activeIndex].albumArtUrl;
                    return AudioRadialSeekBar(
                      albumArtUrl: albumArtUrl,
                    );
                  },
                ),
              ),
              // visualizer
              Container(
                width: double.infinity,
                height: 125.0,
                child: Visualizer(
                  builder: (BuildContext context, List<int> fft) {
                    return CustomPaint(
                      painter: VisuallizerPainter(
                        fft: fft,
                        height: 125.0,
                        color: accentColor,
                      ),
                      child: Container(),
                    );
                  },
                ),
              ),
              // title  artist name and controls
              new ButtonControls()
            ],
          )),
    );
  }
}

class VisuallizerPainter extends CustomPainter {
  final List<int> fft;
  final double height;
  final Color color;
  final Paint wavePaint;
  VisuallizerPainter({this.fft, this.color, this.height})
      : wavePaint = Paint()
          ..color = color.withOpacity(0.8)
          ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    _renderWaves(canvas, size);
  }

  void _renderWaves(Canvas canvas, Size size) {
    final histogramLow =
        _createHistogram(fft, 8, 2, ((fft.length) / 4).floor());
    final histogramHigh = _createHistogram(
        fft, 5, ((fft.length) / 4).ceil(), ((fft.length) / 2).floor());
    _renderHistogram(canvas, size, histogramLow);
    _renderHistogram(canvas, size, histogramHigh);
  }

  void _renderHistogram(Canvas canvas, Size size, List<int> histogram,) {
    if (histogram.length == 0) {
      return;
    }

    final pointsToGraph = histogram.length;
    final widthPerSample = (size.width / (pointsToGraph - 1)).round();
    final points = new List<double>.filled(pointsToGraph * 4, 0.0);
    for (int i = 0; i < histogram.length - 1; ++i) {
      points[i * 4] = (i * widthPerSample).toDouble();
      points[i * 4 + 1] = size.height - histogram[i].toDouble() - 10.0;
      points[i * 4 + 2] = ((i + 1) * widthPerSample).toDouble();
      points[i * 4 + 3] = size.height - histogram[i + 1].toDouble() - 10.0;
    }
    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(points[0], points[1]);
    for (int i = 2; i < points.length - 2; i += 4) {
      path.cubicTo(
        points[i - 2] + widthPerSample * 0.4,
        points[i - 1],
        points[i] - widthPerSample * 0.4,
        points[i + 1],
        points[i],
        points[i + 1],
      );
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);

  }

  List<int> _createHistogram(List<int> samples, int bucketCount,
      [int start, int end]) {
    if (start == end) {
      return [];
    }
    start = start ?? 0;
    end = end ?? samples.length - 1;

    final samplesCount = end - start + 1;

    final samplesPerBucket = (samplesCount / bucketCount).floor();
    if (samplesPerBucket == 0) {
      return [];
    }
    final actualCount = samplesPerBucket * bucketCount;
    List<int> histogram = new List<int>.filled(bucketCount, 0);

    for (int i = start; i < start + actualCount; ++i) {
      // ignore thte imaginary part
      if ((i - start) % 2 == 1) {
        continue;
      }

      int bucketIndex = ((i - start) / samplesPerBucket).floor();
      histogram[bucketIndex] += samples[i];
    }

    for (var i = 0; i < histogram.length; ++i) {
      histogram[i] = (histogram[i]*1.2 / samplesPerBucket).abs().floor();
    }

    return histogram;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AudioRadialSeekBar extends StatefulWidget {
  final String albumArtUrl;
  AudioRadialSeekBar({
    this.albumArtUrl,
  });
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
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        double playbackProgress = 0.0;
        if (player.audioLength != null && player.position != null) {
          playbackProgress = player.position.inMilliseconds /
              player.audioLength.inMilliseconds;
        }
        _seekPercent = player.isSeeking ? _seekPercent : null;
        return RadialBar(
            progress: playbackProgress,
            seekPercent: _seekPercent,
            onSeekRequest: (double seekPercent) {
              setState(() => _seekPercent = seekPercent);
              final seekMillis =
                  (player.audioLength.inMilliseconds * seekPercent).round();
              player.seek(Duration(milliseconds: seekMillis));
            },
            child: Container(
              color: accentColor,
              child: Image.network(
                widget.albumArtUrl,
                fit: BoxFit.cover,
              ),
            ));
      },
    );
  }
}

class RadialBar extends StatefulWidget {
  final double progress;
  final seekPercent;
  final Function(double) onSeekRequest;
  final Widget child;
  RadialBar(
      {this.seekPercent = 0.2, this.progress, this.onSeekRequest, this.child});
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
          width: 220.0,
          height: 220.0,
          child: RadialSeekBar(
            progressPercent: _progress,
            thumbPosition: thumbPosition,
            innerPadding: EdgeInsets.all(8.0),
            progressColor: accentColor,
            thumbColor: lightAccentColor,
            trackColor: Color(0xffdddddd),
            child: ClipOval(
              clipper: CircleClipper(),
              child: widget.child,
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
