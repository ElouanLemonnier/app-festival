import 'dart:convert';
import 'dart:io';

import 'package:app_festi/main.dart';
import 'package:app_festi/models/login_request_model.dart';
import 'package:app_festi/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import 'home.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  bool _isLoading = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController userControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: _isLoading ? const Center(child: CircularProgressIndicator()) : Container(
              padding: const EdgeInsets.all(45.0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/wppApp.png'),
                      fit: BoxFit.cover
                  )
              ),
              child:  Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children:   [
                    const Spacer(),

                    const Text("Se connecter", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),),
                    const Spacer(),
                    TextField(
                      controller: userControl,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0)
                        ),


                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    TextField(
                      controller: passControl,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0)
                        ),
                      ),
                      obscureText: _isObscure,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed:  (){
                            if(validateAndSave()){
                              setState(() {
                                bool isAPICallProcess = true;
                              });
                              LoginRequestModel model = LoginRequestModel(
                                  username: username!,
                                  password: password!,
                              );

                              APIService.login(model).then((value) => ((response) => {
                                if(response) {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
                                    ModalRoute.withName('/home'),)
                              }
                                else {
                                  FormHelper.showSimpleAlertDialog(context, Config.appName, "Invalid Username/Password !", "OK", (){
                                    Navigator.pop(context);
                                  })
                                }
                              }));
                            }

                          },
                          child: const Text("Login"),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 2, color: Colors.white),
                            primary: Colors.white,
                          ),
                        ),
                        OutlinedButton(
                          onPressed:  (){},
                          child: const Text("Register"),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 2, color: Colors.white),
                            primary: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        )

    );


  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
}






