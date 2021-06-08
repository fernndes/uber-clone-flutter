import 'package:flutter/material.dart';
import 'package:uberclone/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  bool _isPassenger = false;
  String _errorMessage = "";

  _fieldValidation() {
    String name = _controllerName.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (name.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (password.isNotEmpty && password.length > 6) {
          Users user = Users();
          user.name = name;
          user.email = email;
          user.password = password;
          user.isPassenger = user.checkIsPassenger(_isPassenger);

          _signupUser(user);
        } else {
          setState(() {
            _errorMessage = "A senha deve conter mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Preencha com um e-mail válido";
        });
      }
    } else {
      setState(() {
        _errorMessage = "Preencha o nome";
      });
    }
  }

  _signupUser(Users user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) {
      db.collection("users").doc(value.user.uid).set(user.toMap());

      switch (user.isPassenger) {
        case "motorista":
          Navigator.pushNamedAndRemoveUntil(
              context, "/driver-panel", (_) => false);
          break;
        case "passageiro":
          Navigator.pushNamedAndRemoveUntil(
              context, "/passenger-panel", (_) => false);
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _controllerName,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Nome completo",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
              ),
              TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
              ),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text("Passageiro"),
                    Switch(
                        value: _isPassenger,
                        onChanged: (bool value) {
                          setState(() {
                            _isPassenger = value;
                          });
                        }),
                    Text("Motorista"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff1ebbd8)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(32, 16, 32, 16)),
                  ),
                  onPressed: () {
                    _fieldValidation();
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
