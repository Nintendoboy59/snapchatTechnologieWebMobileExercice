import 'package:flutter/material.dart';
import '../home/home_page.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  int _pageIndex = 0;
  List<Widget> _page = [Center(
    child: Image.asset('assets/images/ChatSnapLogo.png'),
  ), const SignIn(), const SignUp()];
  List<String> _title = ["","Connexion","Inscription"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageIndex == 0 ? null : AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            setState(() {
              _pageIndex = 0;
            });
          },
        ),
        title: const Text(""),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body:_page[_pageIndex],
      floatingActionButton: _pageIndex == 0 ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                left: 0.0,
                right: 5.0,
                top: 10.0,
                bottom: 5.0,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
                child: Container(
                  height: 55,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 0.0,
                top: 10.0,
                bottom: 5.0,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _pageIndex = 2;
                  });
                },
                child: Container(
                  height: 55,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(50)),
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
              ))
        ],
      ) : GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
            return const MyHomePage();
          }));
        },
        child: Container(
          height: 55,
          width: 260,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              _title[_pageIndex],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
