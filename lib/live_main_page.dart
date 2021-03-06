import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_video/live_detail_page.dart';
import 'package:live_video/model.dart';

import 'live_list_page.dart';

class LiveVideoMainPage extends StatefulWidget{

  LiveVideoMainPage({Key key, this.screenWidth, this.screenHeight}): super(key: key);

  final double screenWidth;

  final double screenHeight;

  @override
  _LiveVideoMainPageState createState() => _LiveVideoMainPageState();

}

class _LiveVideoMainPageState extends State<LiveVideoMainPage> with TickerProviderStateMixin{

  List<LiveRoom> liveRoomList;

  int currentIndex;

  bool inMiddle = true;

  AnimationController animationControllerX;

  Animation animationX;

  double offsetX = 0.0;


  @override
  void initState() {
    super.initState();
    liveRoomList = List.generate(20, (index){
      return LiveRoom(
        roomId: '$index',
        title: '托管于华东教育网骨干节点$index',
        liveUrl: 'http://cctvalih5ca.v.myalicdn.com/live/cctv1_2/index.m3u8',
        imageUrl: 'http://n.sinaimg.cn/sports/2_img/upload/30af16f8/290/w1080h810/20200303/56bd-iqfqmat6847554.jpg',
        label: '户外美女天团教母',
        host: 'Sarah',
        viewCount: '100M',
      );
    });
  
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onChangeIndex(int index){
    setState(() => this.currentIndex = index);
    animationControllerX = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    final curve = CurvedAnimation(parent: animationControllerX, curve: Curves.easeOutCubic);
    animationX = Tween(begin: 0.0, end: -1 * widget.screenWidth ).animate(curve)
      ..addListener(() {
        setState(() {
          offsetX = animationX.value;
        });
      });
    inMiddle = false;
    animationControllerX.forward();
  }

  @override
  Widget build(BuildContext context) {
    
    print('main page =====>${this.liveRoomList.length}');

    LiveRoom detailLiveRoom;
    if(this.currentIndex != null){
      detailLiveRoom = this.liveRoomList[this.currentIndex];
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiveListPage(liveRoomList: this.liveRoomList, offsetX: this.offsetX, onChangeIndex: onChangeIndex, screenWidth: widget.screenWidth, screenHeight: widget.screenHeight,),
          GestureDetector(
            // 水平方向滑动结束
          onHorizontalDragEnd: (details) {
            // 当滑动停止的时候 根据 offsetX 的偏移量进行动画
            // 为了方便这里取 screenWidth / 2为临界条件
            print('onHorizontalDragEnd===>>>');
            if (offsetX.abs() < widget.screenWidth / 2) {
              animateToMiddle();
            } else if (offsetX > 0) {
              // animateToLeft(screenWidth);
            } else {
              animateToRight(widget.screenWidth);
            }
          },
          // 水平方向滑动开始
          onHorizontalDragStart: (_) {
            animationControllerX?.stop();
          },
          // 水平方向滑动中
          onHorizontalDragUpdate: (details) {
            // 控制 offsetX 的值在 -screenWidth 到 screenWidth 之间
            if (offsetX + details.delta.dx >= widget.screenWidth) {
              setState(() {
                offsetX = widget.screenWidth;
              });
            } else if (offsetX + details.delta.dx <= -widget.screenWidth) {
              setState(() {
                offsetX = -widget.screenWidth;
              });
            } else {
              setState(() {
                offsetX += details.delta.dx;
              });
            }
          },
            child: LiveVideoDetailPage(
              liveRoom: detailLiveRoom, 
              // offsetX: this.offsetX,
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
            ),
          ),
        ],
      ),
    );
  }

  /// [offsetX] to 0.0
  void animateToMiddle() {
    animationControllerX = AnimationController(duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500), vsync: this);
    final curve = CurvedAnimation(parent: animationControllerX, curve: Curves.easeOutCubic);
    animationX = Tween(begin: offsetX, end: 0.0).animate(curve)
      ..addListener(() {
        setState(() {
          offsetX = animationX.value;
        });
      });
    inMiddle = true;
    animationControllerX.forward();
  }

  /// 滑动到右边
  ///
  /// [offsetX] to -[screenWidth]
  void animateToRight(double screenWidth) {
    animationControllerX =
        AnimationController(duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500), vsync: this);
    final curve = CurvedAnimation(parent: animationControllerX, curve: Curves.easeOutCubic);
    animationX = Tween(begin: offsetX, end: -screenWidth).animate(curve)
      ..addListener(() {
        setState(() {
          offsetX = animationX.value;
        });
      });
    inMiddle = false;
    animationControllerX.forward();
  }

}