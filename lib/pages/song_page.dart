import 'package:flutter/material.dart';
import 'package:music/components/neu_box.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key, required this.songModel});
  final SongModel songModel;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, top: 30.0, right: 25, bottom: 25),
          child: Column(
            children: [
              // app bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),

                  // title
                  const Text("P L A Y L I S T"),
                  // menu button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
              // album artwork
              NeuBox(
                child: QueryArtworkWidget(
                  id: widget.songModel.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Icon(
                    Icons.music_note,
                    size: 60,
                  ),
                ),
              ),
              // song duration progress

              // playback controls
            ],
          ),
        ),
      ),
    );
  }
}
