import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animation_route.dart';
import 'live_main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: 
      // GestureDetector(
      //     onTap: (){
      //       // Navigator.of(context).push(
      //       //   // MaterialPageRoute(builder: (context){
      //       //   //   return LiveVideoMainPage(screenWidth: screenWidth, screenHeight: screenHeight,);
      //       //   // }),
      //       //   AnimationRoute(LiveVideoMainPage(screenWidth: screenWidth, screenHeight: screenHeight,))
      //       // );
      //     },
      //     // child: Container(
      //     //   height: 200.0,
      //     //   width: 200.0,
      //     //   alignment: Alignment.center,
      //     //   color: Colors.black12,
      //     //   child: Text('clicj'),
      //     // ),
      //     child: 
            Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  print("onTap=====>");
                },
                child: Container(
                  height: 200.0,
                  width: screenWidth,
                  alignment: Alignment.center,
                  color: Colors.black12,
                  child: Text('clicj'),
                ),
              ),
              PositionedDirectional(
                start: 0.0,
                width: 30.0,
                top: 0.0,
                bottom: 10.0,
                child: Listener(
                  onPointerDown: (PointerDownEvent event){

                  },
                  behavior: HitTestBehavior.translucent,
                  // child: Container(
                  //   height: 300,
                  //   color: Colors.red,
                  // ),
                  child: Listener(
                    onPointerDown: (PointerDownEvent event){
                      print("PointerDownEvent------<<<<");
                      
                    },
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
              ),
            ],
          // ),
        
      ),
    );
  }
}



