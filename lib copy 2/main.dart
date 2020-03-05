import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animation_route.dart';
import 'live_list_page.dart';
import 'live_main_page.dart';
import 'model.dart';

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
    print("=====>screenWidth: $screenWidth====screenHeight: $screenHeight");
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
                  
                  print("onTap=====>$screenWidth====$screenHeight");
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context){
                      return LiveListPage(liveRoomList: List.generate(20, (index){
                        return LiveRoom(
                          roomId: '$index',
                          title: '托管于华东教育网骨干节点$index',
                          liveUrl: 'http://cctvalih5ca.v.myalicdn.com/live/cctv1_2/index.m3u8',
                          imageUrl: 'http://n.sinaimg.cn/sports/2_img/upload/30af16f8/290/w1080h810/20200303/56bd-iqfqmat6847554.jpg',
                          label: '户外美女天团教母',
                          host: 'Sarah',
                          viewCount: '100M',
                        );
                      }), offsetX: 0.0, onChangeIndex: null, screenWidth: screenWidth, screenHeight: screenHeight);
                      // return LiveVideoMainPage(screenWidth: screenWidth, screenHeight: screenHeight,);
                    }),
                  );
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



