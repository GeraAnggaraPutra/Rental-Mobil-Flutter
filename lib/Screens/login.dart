import 'package:flutter/material.dart';
import 'package:rental_mobil_flutter/Screens/Home.dart';
import 'package:rental_mobil_flutter/Screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../helpers/size_helper.dart';
import '../../network/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _isLoading = false;
  bool _isHiddenPassword = true;

  showHide() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  _login() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // _showAlertDialog(context);
      setState(() {
        _isLoading = true;
      });

      var data = {'email': email, 'password': password};
      var res = await Network().auth(data, '/login');
      var body = json.decode(res.body);
      _formKey.currentState!.save();

      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // _showMsg(msg) {
        //   final snackBar = SnackBar(
        //     content: Text(msg),
        //   );
        //   _scaffoldKey.currentState!.showSnackBar(snackBar);
        // }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.blueAccent,
      //   title: Text("Flutter IO"),
      // ),
      key: _scaffoldKey,
      body: Container(
        height: displayHeight(context) * 1,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 44, 10),
          Color.fromARGB(255, 1, 140, 20)
        ])),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: displayWidth(context) * 1,
                  child: Center(
                    child: Text(
                      'Rental Mobil',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextFormField(
                  // controller: emailController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (emailValue) {
                    if (emailValue!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailValue)) {
                      return 'Masukan Email!';
                    }
                    email = emailValue;
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Masukkan email',
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  // controller: passwordController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  obscureText: _isHiddenPassword,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (passwordValue) {
                    if (passwordValue!.isEmpty) {
                      return 'Masukkan Password!';
                    }
                    password = passwordValue;
                    return null;
                  },
                  decoration: InputDecoration(
                     focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 35,
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Masukkan Password',
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      color: Colors.white,
                      onPressed: showHide,
                      icon: Icon(_isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Container(
                    width: displayWidth(context) * 1,
                    height: 60,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Colors.black87, Colors.black87])),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Does'nt have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Register()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
