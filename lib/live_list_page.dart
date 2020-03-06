
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_video/live_detail_page.dart';
import 'package:live_video/route_transitions.dart';
import 'package:live_video/test_gesture.dart';
import 'package:live_video/test_page.dart';

import 'model.dart';

typedef void OnChangeIndex(int index);

class LiveListPage extends StatelessWidget{

  const LiveListPage({
    Key key, 
    @required this.liveRoomList, 
    @required this.offsetX,
    @required this.onChangeIndex,
    @required this.screenWidth,
    @required this.screenHeight
  }): super(key: key);


  final List<LiveRoom> liveRoomList;

  final double offsetX;

  final OnChangeIndex onChangeIndex;

  final double screenWidth;

  final double screenHeight;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: this.buildContent(context),
    );
  }

  

  Widget buildContent(BuildContext context) {
    double spacing = 10.0;
    double width = (this.screenWidth - 3*spacing)/2;

    List<Widget> widgetList;
    if(null != this.liveRoomList){
      widgetList = <Widget>[];
      for(int i = 0; i < this.liveRoomList.length; i++){
        widgetList.add(
          GestureDetector(
            onTap: (){
              print("sadasdasdsdd====>screenHeight: ${this.screenHeight}====screenWidth: ${this.screenWidth}");
              // this.onChangeIndex(i);
              // Navigator.of(context).push(CupertinoPageRoute(builder: (context){
              //   return LiveVideoDetailPage(liveRoom: this.liveRoomList[i], screenWidth: this.screenWidth,);
              // }));

              // this.onChangeIndex(i);
              Navigator.of(context).push(PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context){
                  return LiveVideoDetailPage(liveRoom: this.liveRoomList[i],  screenWidth: this.screenWidth,screenHeight : this.screenHeight);
                  // return LiveVideoDetailPage(liveRoom: this.liveRoomList[i], offsetX: 0.0, screenWidth: this.screenWidth,);
                }
              ));

              // this.onChangeIndex(i);
              // Navigator.of(context).push(
              //   PageRouteTransition(
              //     animationType: AnimationType.slide_up,
              //     builder: (context){
              //       // return TestPage();
              //       // return MyStatefulWidget();
              //       return DemoApp();
              //     // return LiveVideoDetailPage(liveRoom: this.liveRoomList[i], offsetX: 0.0, screenWidth: this.screenWidth,);
              //     }
              //   )
              // );
            },
            child: LiveVideoListItemWidget(liveRoom: this.liveRoomList[i], width: width,),
          )
        );
      }
    }

    return Container(
        padding: EdgeInsets.only(right: spacing, left: spacing, top: 15.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: spacing,
            alignment: WrapAlignment.center,
            children: widgetList,
          ),
        ),
    );
  }

}




class LiveVideoListItemWidget extends StatelessWidget{

  LiveVideoListItemWidget({
    Key key, 
    @required this.liveRoom,
    this.width,
  }): super(key: key);

  final LiveRoom liveRoom;

  final double width;
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: buildWidget(context),
    );
  }

  Widget buildWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(bottom: 4.0),
      width: this.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16/9,
                child:  CachedNetworkImage(
                  imageUrl: this.liveRoom.imageUrl, 
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                bottom: 4.0,
                left: 4.0,
                right: 4.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${this.liveRoom.host}', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Icon(Icons.hot_tub, size: 14.0, color: Colors.white,),
                         Text(
                          '${this.liveRoom.viewCount}', 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0
                          ),
                        ),
                      ],
                    )
                  ],
                ) 
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 5.0),
            child: Text(
              '${this.liveRoom.title}', 
              style: TextStyle(
                fontSize: 13.0
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 1.0, bottom: 1.0),
                child: Text(
                  '${this.liveRoom.label}',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 10.0
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          

        ],
      ),
    );
  }

}


