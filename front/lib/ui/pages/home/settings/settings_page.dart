import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snapchat_technologie_web_mobile_exercice/ui/content/Loding.dart';
import 'dart:convert' as convert;
import '../../../../data/data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Future<CharResponse?> getChar() async {
      var url = Uri.parse('https://rickandmortyapi.com/api/character');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> parseObject =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return CharResponse.fromJson(parseObject);
      } else {
        return null;
      }
    }

    return FutureBuilder(
      future: getChar(),
      builder: (BuildContext context, AsyncSnapshot<CharResponse?> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.connectionState == ConnectionState.done) {
          List<Results> characters = snapshot.data!.results!;
          Results character = characters[0];
          return ListView(
            children: [
              Container(
                color: Colors.black12,
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                  child: Text(
                    'Mon compte',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const CustomContainer(text1: 'Nom', text2: 'Jenny'),
              CustomContainer(text1: 'Prénom', text2: '${character.name}'),
              const CustomContainer(text1: 'Pseudo', text2: 'jenny98.12'),
              CustomContainer(text1: 'id', text2: '${character.id}'),
              CustomContainer(text1: 'Genre', text2: '${character.gender}'),
              CustomContainer(text1: 'Espèce', text2: '${character.species}'),
              CustomContainer(
                  text1: 'Création du compte', text2: '${character.created}'),
            ],
          );
        } else {
          return const LodingCustom();
        }
      },
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.text1, required this.text2})
      : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            child: Text(text1,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 12)),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            child: Text(
              text2,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                  fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
