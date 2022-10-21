import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../../data/data.dart';
import 'package:truncate/truncate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  Future<CharResponse?> _getChar() async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character');

    var response = await http.get(url);
    if(response.statusCode==200){
      Map<String, dynamic> parseObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return CharResponse.fromJson(parseObject);
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:_getChar(),
        builder: (BuildContext context, AsyncSnapshot<CharResponse?>snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasData){
              if(snapshot.data != null){
                List<Results> character = snapshot.data!.results!;
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const[
                          Text('Données de l\'api', style:
                            TextStyle(color: Colors.blue,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 25))
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: const[
                            Text('Mon compte', style:
                              TextStyle(color: Colors.blue,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        child: Row(
                          children:   [
                            const Text('Prénom nom', style:
                            TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(left:240),
                              child: Text(character[0].name.toString(),style: const TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        child: Row(
                          children:   [
                            const Text('Id', style:
                            TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(left:370),
                              child: Text(character[0].id.toString(),style: const TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        child: Row(
                          children:   [
                            const Text('Genre', style:
                            TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(left:330),
                              child: Text(character[0].gender.toString(),style: const TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        child: Row(
                          children:   [
                            const Text('Forme de vie', style:
                            TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(left:275),
                              child: Text(character[0].species.toString(),style: const TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        child: Row(
                          children:   [
                            const Text('Création du compte', style:
                            TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.only(left:220),
                              child: Text(truncator(character[1].created.toString(), 10, CutStrategy()),style: const TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              else{
                return const Text('data null');
              }
            }
            else{
              return const Text('data null');
            }
          }
          else{
            return const Text('data null');
          }
        }
    );
  }
}

