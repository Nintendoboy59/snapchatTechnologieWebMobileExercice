import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.index,
    required this.image,
    required this.name,
  });

  final int? index;
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<MyMessageItem> items = List<MyMessageItem>.generate(
        50,
        (i) => i % 6 == 0
            ? MyMessageItem(
                date: now, sender: true, body: 'Je t\'envoie un message ')
            : MyMessageItem(date: now, sender: false, body: 'Je te repond'));

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        automaticallyImplyLeading: true,
        leading: Row(
          children: const [
            Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://rickandmortyapi.com/api/character/avatar/1.jpeg'),
                )),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      onPressed: (null),
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ))),
          ],
        ),
        title: const Text("Chat",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900,
                fontSize: 25)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    onPressed: (null),
                    icon: Icon(
                      Icons.person_add,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  )))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                (Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image!),
                      radius: 25,
                    ))),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(name!,
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            DateChip(
              date: now,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index] ;
              },
            ),
            SizedBox(
              height: 95,
            )
          ],
        ),
      ),
      floatingActionButton: MessageBar(
        onSend: (_) => print(_),
        messageBarColor: Colors.white,
        replyCloseColor: Colors.grey,
        replyWidgetColor: Colors.blue,
        replying: false,
        replyingTo: 'Coucou',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyMessageItem extends StatelessWidget {
  const MyMessageItem(
      {super.key,
      required this.date,
      required this.sender,
      required this.body});

  final DateTime date;
  final bool sender;
  final String body;

  @override
  Widget build(BuildContext context) => BubbleSpecialTwo(
        text: body,
        isSender: sender,
        color: sender ? Color(0xFFE8E8EE) : Color(0xFF1B97F3),
        sent: sender,
      );
}
