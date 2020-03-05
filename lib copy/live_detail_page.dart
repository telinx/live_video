import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model.dart';

class LiveVideoDetailPage extends StatefulWidget{

  LiveVideoDetailPage({
    Key key,
    @required this.liveRoom,
    @required this.offsetX,
    this.screenWidth,
    this.screenHeight
   
  }): super(key: key);

  final LiveRoom liveRoom;

  final double offsetX;

  final double screenWidth;

  final double screenHeight;

  @override
  _LiveVideoDetailPageState createState() => _LiveVideoDetailPageState();
  
}

class _LiveVideoDetailPageState extends State<LiveVideoDetailPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  List<String> tabList = ["All", "Private", "Host"];

  int currentIndex = 0;

  bool absorbingTabView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.addListener(changeIndex);

  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void changeIndex(){
    if(this._tabController.index == 0){
      setState(() {
        this.currentIndex = 0;
      });
    }else{
      this.currentIndex = this._tabController.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if(widget.liveRoom == null){
      page = Container(
        alignment: Alignment.center,
        child: Text('no'),
      );
    }else{
      page = Container(
        height: widget.screenHeight,
        width: widget.screenWidth,
        color: Colors.white,
        child: this.buildContent(context),
      );
    }
    return Transform.translate(
      offset: Offset(max(0, widget.offsetX + widget.screenWidth), 0),
      child: page 
    );

  }

  Widget buildContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[

            AspectRatio(
              aspectRatio: 16/9,
               child:  CachedNetworkImage(
                  imageUrl: widget.liveRoom.imageUrl, 
                  fit: BoxFit.cover,
                ),
            ),

            TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: this._tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(text: item,);
              }).toList(),
            ),

            Expanded(
              child: Listener(
                onPointerMove: (PointerMoveEvent pointerMoveEvent){
                  if(this.currentIndex == 0){
                    print('PointerMoveEvent----->>>${pointerMoveEvent.delta.dx}');
                    if(pointerMoveEvent.delta.dx > 0){
                      setState(() {
                        this.absorbingTabView = true;
                      });
                    }else{
                       setState(() {
                        this.absorbingTabView = false;
                      });
                    }
                  }
                },
                child: AbsorbPointer(
                  absorbing: absorbingTabView,
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.start,
                    controller: this._tabController,
                    children: tabList.map((item) {
                      return Stack(children: <Widget>[
                        Align(alignment:Alignment.topCenter,child: Text(item),),
                      ],);
                    }).toList(),
                  ),
                ),
                ),
            ),

          ],
        ),
        
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: this.buildInputWidget(context)
        )
      ],
    );
  }

  Widget buildInputWidget(BuildContext context){
    return Offstage(
      offstage: this.currentIndex != 0,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.black38
        ),
        child: Text('聊天'),
      ),
    );
  }

}