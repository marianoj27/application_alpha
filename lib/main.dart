import 'package:application_alpha/classes/imagesScreen.dart';
import 'package:application_alpha/menuScreen.dart';
import 'package:application_alpha/providers/model_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AphaTalk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: menuScreen(),
    );
  }
}

/*class _login extends StatefulWidget {

  @override
  State<_login> createState() => _loginState();
}

class _loginState extends State<_login> {
  TextEditingController userName = TextEditingController();
  //TextEditingController password = TextEditingController();
  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(15.0,15.0)
          )
          ],
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.only(left: 50,right: 50, bottom: 50, top: 50),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/brain_icon.png", height: 150,),
              SizedBox(height: 50,),
              TextField(
                controller: userName,
                onChanged: (value) {
                  _userModel.userName = value;
                  //print(_userModel.userName);
                },
                decoration: InputDecoration(
                    hintText: "Usuario"
                ),
              ),
              SizedBox(height: 20,), //Hack caja
              /*TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Contraseña"
                ),
              ),*/
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 200, 
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  child: Text("Acceder", style: TextStyle(color:Colors.white, fontSize: 20),),
                  onPressed: (){
                    _userModel.setUserName(_userModel.userName);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>menuScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}*/


