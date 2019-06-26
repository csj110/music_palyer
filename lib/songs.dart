import 'package:meta/meta.dart';
final demoPlaylist = new DemoPlaylist(
  songs: [
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/1.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190607/20190607000818635693.jpg',
      songTitle: 'Ghosts of the Sea',
      artist: '米津玄師',
    ),
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/2.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190609/20190609082403306526.jpg',
      songTitle: 'バケノカワ',
      artist: 'Polkadot Stingray',
    ),
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/3.mp3',
      albumArtUrl: 'http://imge.kugou.com/stdmusic/20190529/20190529211514714150.jpg',
      songTitle: 'Electro Monotony',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/4.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190605/20190605084302994754.jpg',
      songTitle: 'Hello, Again ~昔からある場所~',
      artist: '花澤香菜',
    ),
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/5.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190611/20190611194403314446.jpg',
      songTitle: 'WISH',
      artist: 'まじ娘',
    ),
    new DemoSong(
      audioUrl: 'https://gifted-meitner-520fa6.netlify.com/static/6.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190612/20190612083003938999.jpg',
      songTitle: 'Corner',
      artist: '三浦大知',
    ),
  ],
);

class DemoPlaylist {

  final List<DemoSong> songs;

  DemoPlaylist({
    @required this.songs,
  });

}

class DemoSong {

  final String audioUrl;
  final String albumArtUrl;
  final String songTitle;
  final String artist;

  DemoSong({
    @required this.audioUrl,
    @required this.albumArtUrl,
    @required this.songTitle,
    @required this.artist,
  });

}