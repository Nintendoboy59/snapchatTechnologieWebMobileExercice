import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../../data/data.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<CharResponse?> _getChar() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
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
      builder: (BuildContext context, AsyncSnapshot<CharResponse?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              List<Results> character = snapshot.data!.results!;
              return ListView.builder(
                primary: true,
                shrinkWrap: true,
                itemCount: character.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                        (Padding(
                            padding: EdgeInsets.all(5),
                            child : CircleAvatar(
                          backgroundImage:
                              NetworkImage(character[index].image!),
                          radius: 25,
                        ))),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(character[index].name!,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12)),
                                SizedBox(height: 10),
                                Text("Nouveau Snap",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12))
                              ],
                            ))
                      ]));
                },
              );
            } else {
              return Text('data null');
            }
          } else {
            return Text('data null');
          }
        } else {
          return Text('data null');
        }
      },
    ));
  }
}
