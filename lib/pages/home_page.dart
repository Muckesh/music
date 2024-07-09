import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/components/my_drawer.dart';
import 'package:music/pages/song_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      print("Error Parsing Song");
    }
  }

  void goToSong(int index) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("P L A Y L I S T"),
          // backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (item.data!.isEmpty) {
                return const Center(child: Text("No Songs to Fetch"));
              }

              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  // leading: const Icon(Icons.music_note),
                  leading: QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.music_note),
                  ),
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text(item.data![index].artist.toString()),
                  // onTap: () {
                  //   playSong(item.data![index].uri);
                  // },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPage(
                          songModel: item.data![index],
                        ),
                      ),
                    );
                  },
                ),
                itemCount: item.data!.length,
              );
            }),
      ),
    );
  }
}
