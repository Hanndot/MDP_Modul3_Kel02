import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mod3_kel02/screens/detail2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<NowAiring>> airing;
  late Future<List<Top>> top;

  @override
  void initState() {
    super.initState();
    airing = fetchAiring();
    top = fetchTop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Weeb App'),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Now Airing',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 180.0,
                child: FutureBuilder<List<NowAiring>>(
                    future: airing,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail2Page(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0,
                              child: Container(
                                height: 150,
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 150,
                                        child: Image.network(
                                            snapshot.data![index].image)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3),
                                      child: Text(
                                        snapshot.data![index].title,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong :('));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 20),
              child: Text(
                'Top Anime',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                child: FutureBuilder<List<Top>>(
                    future: top,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.black45,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      snapshot.data![index].imageUrl),
                                ),
                                title: Text(snapshot.data![index].title),
                                subtitle: Text(
                                    'Score: ${snapshot.data![index].score}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail2Page(
                                          item: snapshot.data![index].malId,
                                          title: snapshot.data![index].title),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong :('));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NowAiring {
  final int malId;
  final String title;
  final num rating;
  final String image;

  NowAiring({
    required this.rating,
    required this.title,
    required this.image,
    required this.malId,
  });

  factory NowAiring.fromJson(Map<String, dynamic> json) {
    return NowAiring(
      malId: json['mal_id'],
      title: json['title'],
      rating: json["score"],
      image: json['image_url'],
    );
  }
}

Future<List<NowAiring>> fetchAiring() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1/airing';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var airingJson = jsonDecode(response.body)['top'] as List;

    return airingJson.map((airing) => NowAiring.fromJson(airing)).toList();
  } else {
    throw Exception('Failed to load airing');
  }
}

class Top {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;

  Top({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Top.fromJson(Map<String, dynamic> json) {
    return Top(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Top>> fetchTop() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;

    return topShowsJson.map((top) => Top.fromJson(top)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
