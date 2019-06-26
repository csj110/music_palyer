import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'songs.dart';
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
        elevation:0.0,
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
          child: Column(
            children: <Widget>[
              AudioPlaylistComponent(
                playlistBuilder:
                    (BuildContext context, Playlist playlist, Widget child) {
                  final title =
                      demoPlaylist.songs[playlist.activeIndex].songTitle;
                  final name =
                      demoPlaylist.songs[playlist.activeIndex].artist;
                  return RichText(
                    text: TextSpan(text: '', children: [
                      TextSpan(
                          text: '${title.toUpperCase()}\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4.0,
                            height: 1.5,
                          )),
                      TextSpan(
                          text: name,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            height: 1.5,
                          ))
                    ]),
                    textAlign:TextAlign.center,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayerState,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        IconData icon = Icons.music_note;
        Function onPressed=player.play;
        Color buttonColor = lightAccentColor;
        if (player.state == AudioPlayerState.playing) {
          icon = Icons.pause;
          onPressed = player.pause;
          buttonColor = Colors.white;
        } else if (player.state == AudioPlayerState.paused ||
            player.state == AudioPlayerState.completed) {
          icon = Icons.play_arrow;
          onPressed = player.play;
          buttonColor = Colors.white;
        }
        return RawMaterialButton(
          shape: CircleBorder(),
          fillColor: buttonColor,
          splashColor: lightAccentColor,
          highlightColor: lightAccentColor.withOpacity(0.5),
          elevation: 10.0,
          highlightElevation: 5.0,
          onPressed: onPressed,
          child: Icon(
            icon,
            color: darkAccentColor,
            size: 50.0,
          ),
        );
      },
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
        return IconButton(
          splashColor: lightAccentColor,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 50.0,
          ),
          onPressed: playlist.previous,
        );
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
    return AudioPlaylistComponent(
      playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
        return IconButton(
          splashColor: lightAccentColor,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 50.0,
          ),
          onPressed: playlist.next,
        );
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
