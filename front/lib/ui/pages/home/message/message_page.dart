import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snapchat_technologie_web_mobile_exercice/ui/content/Loding.dart';
import 'dart:convert' as convert;
import '../../../../data/data.dart';
import '../chat/chat_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<CharResponse?> _getChar() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      Map<String, dynamic> parseObject =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      return CharResponse.fromJson(parseObject);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
          future: _getChar(),
          builder: (BuildContext context,
              AsyncSnapshot<CharResponse?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              List<Results> characters = snapshot.data!.results!;
              return ListView.builder(
                primary: true,
                shrinkWrap: true,
                itemCount: characters.length,
                itemBuilder: (BuildContext context, int index) {
                  return CharacterCard(image:characters[index].image,name:characters[index].name,);
                },
              );
            } else {
              return const LodingCustom();
            }
          },
        ));
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.image,
    required this.name,
  });

  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return ChatPage(
                image: image,
                name: name,);
            }));
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundImage:
                NetworkImage(image!),
                radius: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name!,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 12)),
                  const SizedBox(height: 10),
                  const Text(
                    "Nouveau Snap",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


