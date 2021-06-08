import 'package:flutter/material.dart';

class PassengerPanel extends StatefulWidget {
  const PassengerPanel({Key? key}) : super(key: key);

  @override
  _PassengerPanelState createState() => _PassengerPanelState();
}

class _PassengerPanelState extends State<PassengerPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel passageiro"),
      ),
      body: Container(),
    );
  }
}
