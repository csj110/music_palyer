import 'package:meta/meta.dart';

final demoPlaylist = new DemoPlaylist(
  songs: [
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161130/3719f65982bf3c76514e93349d1ab348/G155/M0B/1B/03/O4cBAFz4BsKAfaJ5ADkw4GXG_M0783.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190607/20190607000818635693.jpg',
      songTitle: 'Ghosts of the Sea',
      artist: '米津玄師',
    ),
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161431/7460fdc866162ce9bed88cbda495e3fa/G153/M01/19/05/eZQEAFz8VBqAXuATADQwSzlupbU437.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190609/20190609082403306526.jpg',
      songTitle: 'バケノカワ',
      artist: 'Polkadot Stingray',
    ),
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161431/ed5cbe61048e8f9fd27370b37117eeab/G153/M01/07/13/2Q0DAFzuh9mAcyCJABanW_4nFRM912.mp3',
      albumArtUrl: 'http://imge.kugou.com/stdmusic/20190529/20190529211514714150.jpg',
      songTitle: 'Electro Monotony',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161431/a9cd63d5927917f3cac1f534a6ca9daf/G153/M06/02/17/eZQEAFz3F2uAWTX_AEf6ajt1jq4685.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190605/20190605084302994754.jpg',
      songTitle: 'Hello, Again ~昔からある場所~',
      artist: '花澤香菜',
    ),
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161436/c13bc93d01c30a8f165d92f1964957c3/G151/M09/06/00/N4cBAFz_v4KAGMgGACibRn0_XB4536.mp3',
      albumArtUrl: 'https://p3fx.kgimg.com/stdmusic/20190611/20190611194403314446.jpg',
      songTitle: 'WISH',
      artist: 'まじ娘',
    ),
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161437/81ea2ac814c5c81ac8a7db8a8d4b0f04/G154/M00/0B/03/OocBAF0ATDOAZZMUADv-qQ8NrOQ539.mp3',
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