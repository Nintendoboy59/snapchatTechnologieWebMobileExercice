import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text('Se connecter', style: TextStyle(fontSize: 24.0)),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      top: 10.0,
                      bottom: 5.0,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Email ou Pseudo",
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
                          labelText: "Mots de passe",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {});
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
