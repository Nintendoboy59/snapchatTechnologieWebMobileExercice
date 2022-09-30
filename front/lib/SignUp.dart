import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(""),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/ChatSnapLogo.png'),
                SizedBox(
                  height: 24,
                ),
                Text('S\'inscrire', style: TextStyle(fontSize: 24.0)),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 10.0,
                      bottom: 5.0,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Email",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      onChanged: (val) {
                        setState(() {});
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 10,
                      bottom: 5.0,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Pseudo",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {});
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 10,
                      bottom: 5.0,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Mots de passe",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {});
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 10.0,
                      bottom: 5.0,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Confirmer le mot de passe",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      onChanged: (val) {
                        setState(() {});
                      },
                    )),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          print('Connexion');
        },
        child: Container(
          height: 55,
          width: 260,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Text(
              'Inscription',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
