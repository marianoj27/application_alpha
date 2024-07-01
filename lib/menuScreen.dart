import 'package:application_alpha/classes/imagesScreen.dart';
import 'package:application_alpha/classes/profileScreen.dart';
import 'package:application_alpha/classes/speechScreen.dart';
import 'package:application_alpha/imageRequest.dart';
import 'package:flutter/material.dart';
import 'classes/category.dart';
import 'sharedPreferencesHelper.dart';

class menuScreen extends StatefulWidget {

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  String _username = '';
  String _profileImg = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadProfileImg();
  }

  void _loadUsername() async {
    String username = await SharedPreferencesHelper.getUsername();
    setState(() {
      _username = username;
    });
  }

  void _loadProfileImg() async {
    String profileImg = await SharedPreferencesHelper.getProfileImage();
    setState(() {
      _profileImg = profileImg;
    });
  }

  void navigateToScreen(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bienvenido $_username',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                navigateToScreen('/profile');
              },
              child: Image.asset(
                'assets/$_profileImg',
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: Menu.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (Menu[index].photo == "images_icon.png") {
                          navigateToScreen('/image');
                        } else if (Menu[index].photo == "quotes_icon.png") {
                          navigateToScreen('/speech');
                        }
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (Menu[index].photo == "images_icon.png") {
                              navigateToScreen('/image');
                            } else if (Menu[index].photo == "quotes_icon.png") {
                              navigateToScreen('/speech');
                            }
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: 250,
                                child: Image.asset(
                                  "assets/" + Menu[index].photo,
                                  width: 200,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                Menu[index].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*class _menuScreenState extends State<menuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Principal, " + "Bienvenido!"), backgroundColor: Colors.white60,),
      backgroundColor: Colors.tealAccent,
      body: Container(
        child: GridView.builder(
          itemCount: Menu.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10)
              ),
              child: GestureDetector(
                onTap: (){
                  print("CLICK");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset("assets/"+Menu[index].photo, width: 200,),
                  Text(Menu[index].name)
                  ],
                ),
              )
            );
            }
        ),
      ),
    );
  }
}*/

