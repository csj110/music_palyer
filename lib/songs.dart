import 'package:meta/meta.dart';

final demoPlaylist = new DemoPlaylist(
  songs: [
    new DemoSong(
      audioUrl: 'https://webfs.yun.kugou.com/201906161130/3719f65982bf3c76514e93349d1ab348/G155/M0B/1B/03/O4cBAFz4BsKAfaJ5ADkw4GXG_M0783.mp3',
      albumArtUrl: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560595449880&di=58926220d0d67ba22ea35f01bdeda4a8&imgtype=0&src=http%3A%2F%2Fimg1.kuwo.cn%2Fstar%2Falbumcover%2F240%2F2%2F92%2F4034638411.jpg',
      songTitle: 'Perfect Saxophone',
      artist: 'Simon More',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/402538329/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/avatars-000344712337-f6po4d-t120x120.jpg',
      songTitle: 'Simply',
      artist: 'Kumbor',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/266891990/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Electro Monotony',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/260578593/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Debut Trance',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/258735531/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Debut',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/9540352/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/avatars-000215855222-tic5d8-t120x120.jpg',
      songTitle: 'Assn1-tribal-beat',
      artist: 'Matt',
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