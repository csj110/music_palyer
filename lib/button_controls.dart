import 'package:flutter/material.dart';
import 'theme.dart';
import 'dart:math';
class ButtonControls extends StatelessWidget {
  const ButtonControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        shadowColor: Color(0x44000000),
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(text: '', children: [
                  TextSpan(
                      text: 'Song Title\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        height: 1.5,
                      )),
                  TextSpan(
                      text: 'artist name',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                        height: 1.5,
                      ))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    new PrevButton(),
                    Expanded(child: Container()),
                    new PlayPauseButton(),
                    Expanded(child: Container()),
                    new NextButton(),
                    Expanded(child: Container()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5.0,
      onPressed: () {
        //TODO:
      },
      child: Icon(
        Icons.play_arrow,
        color: darkAccentColor,
        size: 30.0,
      ),
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: () {
        // TODO:
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: () {
        // TODO:
      },
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
