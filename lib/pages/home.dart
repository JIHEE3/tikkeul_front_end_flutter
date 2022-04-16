import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tikkeul'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Temp'),
          onPressed: () {
            // Named route를 사용하여 두 번째 화면으로 전환합니다.
            Navigator.pushNamed(context, '/signIn');
          },
        ),
      ),
    );
  }
}
