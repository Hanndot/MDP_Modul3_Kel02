import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class Detail2Page extends StatefulWidget {
  final int item;
  final String title;
  const Detail2Page({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _Detail2PageState createState() => _Detail2PageState();
}

class _Detail2PageState extends State<Detail2Page> {
  late Future<AnimeDetail> detail;

  @override
  void initState() {
    super.initState();
    detail = fetchDetails(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<AnimeDetail>(
          future: detail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(snapshot.data!.image),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.title,
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(color: Colors.black, letterSpacing: .5),
                    ),
                  ),
                  Text(snapshot.data!.score.toString()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      snapshot.data!.synopsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}

class AnimeDetail {
  final String image;
  final String title;
  final String synopsis;
  final num malId;
  final num score;
  final String startDate;

  AnimeDetail(
      {required this.image,
      required this.title,
      required this.synopsis,
      required this.malId,
      required this.score,
      required this.startDate});

  factory AnimeDetail.fromJson(json) {
    return AnimeDetail(
      image: json['image_url'],
      title: json['title'],
      synopsis: json['synopsis'],
      malId: json['mal_id'],
      score: json['score'],
      startDate: json['start_date'],
    );
  }
}

Future<AnimeDetail> fetchDetails(malId) async {
  final String api = 'https://api.jikan.moe/v3/anime/$malId';
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    return AnimeDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load anime details');
  }
}
