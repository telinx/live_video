// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'model.dart';

// class LiveVideoDetailPage extends StatefulWidget{

//   LiveVideoDetailPage({
//     Key key,
//     @required this.liveRoom,
//     // @required this.offsetX,
//     this.screenWidth,
//     this.screenHeight
   
//   }): super(key: key);

//   final LiveRoom liveRoom;

//   // final double offsetX;

//   final double screenWidth;

//   final double screenHeight;

//   @override
//   _LiveVideoDetailPageState createState() => _LiveVideoDetailPageState();
  
// }

// class _LiveVideoDetailPageState extends State<LiveVideoDetailPage> with TickerProviderStateMixin{

//   TabController _tabController;

//   List<String> tabList = ["All", "Private", "Host"];

//   int currentIndex = 0;

//   bool absorbingTabView = false;

//   AnimationController animationControllerX;

//   Animation animationX;

//   double offsetX = 0.0;

//   HorizontalDragGestureRecognizer _recognizer;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
//     _tabController.addListener(changeIndex);

//     _recognizer = HorizontalDragGestureRecognizer(debugOwner: this)
//       ..onStart = _handleDragStart
//       ..onUpdate = _handleDragUpdate
//       ..onEnd = _handleDragEnd
//       ..onCancel = _handleDragCancel;

//   }
  

//    void _handleDragStart(DragStartDetails details) {
//     // _backGestureController = widget.onStartPopGesture();
//     print("_handleDragStart======>>>>");
//     animationControllerX?.stop();
//   }

//   void _handleDragUpdate(DragUpdateDetails details) {
//     // assert(mounted);
//     // assert(_backGestureController != null);
//     // _backGestureController.dragUpdate(_convertToLogical(details.primaryDelta / context.size.width));
//     // print("_handleDragUpdate======>>>>${details.globalPosition}===>Start");
    
//     if(this.currentIndex != 0 && details.globalPosition.dy > (widget.screenWidth * 9 / 16)){
//       print("_handleDragUpdate======>>>>${details.globalPosition}===>stop");
//     }else{
//       if (offsetX + details.delta.dx >= widget.screenWidth) {
//       setState(() {
//         offsetX = widget.screenWidth;
//       });
//     } else if (offsetX + details.delta.dx <= -widget.screenWidth) {
//       setState(() {
//         // offsetX = -widget.screenWidth;
//           offsetX = 0.0;
//       });
//     } else {
//       setState(() {
//         offsetX += details.delta.dx;
//       });
//     }
//     }
    

    
//   }

//   void _handleDragEnd(DragEndDetails details) {
//     // assert(mounted);
//     // assert(_backGestureController != null);
//     // _backGestureController.dragEnd(_convertToLogical(details.velocity.pixelsPerSecond.dx / context.size.width));
//     // _backGestureController = null;
//     // print("_handleDragStart======>>>>");
//       // 当滑动停止的时候 根据 offsetX 的偏移量进行动画
//     // 为了方便这里取 screenWidth / 2为临界条件
//     // print('onHorizontalDragEnd===>>>');
//     if (offsetX.abs() < widget.screenWidth / 2) {
//       animateToMiddle();
//     } else if (offsetX.abs() > widget.screenWidth / 2) {
//       animateToLeft(context, widget.screenWidth);
//     } else {
//       // animateToRight(widget.screenWidth);
//     }
//   }

//   void _handleDragCancel() {
//     // assert(mounted);
//     // // This can be called even if start is not called, paired with the "down" event
//     // // that we don't consider here.
//     // _backGestureController?.dragEnd(0.0);
//     // _backGestureController = null;
//     // print("_handleDragStart======>>>>");
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   void changeIndex(){
//     if(this._tabController.index == 0){
//       setState(() {
//         this.currentIndex = 0;
//         this.absorbingTabView = false;
//       });
//     }else{
//       setState(() {
//         this.currentIndex = this._tabController.index;
//         this.absorbingTabView = true;
//       });
//     }
//     print('changeIndex====>>>>currentIndex: ${this.currentIndex}====${this.absorbingTabView}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget page;
//     if(widget.liveRoom == null){
//       page = Container(
//         alignment: Alignment.center,
//         child: Text('no'),
//       );
//     }else{
//       page = Scaffold(
//         body: Container(
//           // height: widget.screenHeight,
//           // width: widget.screenWidth,
//           color: Colors.white,
//           child: this.buildContent(context),
//         ),
//       );
//     }
//     // return Scaffold(
//     //   body: page,
//     // );

//     // page = GestureDetector(
//     //   // 水平方向滑动结束
//     //   onHorizontalDragEnd: (details) {
//     //     // 当滑动停止的时候 根据 offsetX 的偏移量进行动画
//     //     // 为了方便这里取 screenWidth / 2为临界条件
//     //     // print('onHorizontalDragEnd===>>>');
//     //     if (offsetX.abs() < widget.screenWidth / 2) {
//     //       animateToMiddle();
//     //     } else if (offsetX.abs() > widget.screenWidth / 2) {
//     //       animateToLeft(context, widget.screenWidth);
//     //     } else {
//     //       // animateToRight(widget.screenWidth);
//     //     }
//     //   },
//     //   // 水平方向滑动开始
//     //   onHorizontalDragStart: (_) {
//     //     animationControllerX?.stop();
//     //   },
//     //   // 水平方向滑动中
//     //   onHorizontalDragUpdate: (details) {
//     //     // 控制 offsetX 的值在 -screenWidth 到 0.0 之间
//     //     // print("onHorizontalDragUpdate======>>>>>>>>delta: ${details.delta.dx}");
//     //     if (offsetX + details.delta.dx >= widget.screenWidth) {
//     //       setState(() {
//     //         offsetX = widget.screenWidth;
//     //       });
//     //     } else if (offsetX + details.delta.dx <= -widget.screenWidth) {
//     //       setState(() {
//     //         // offsetX = -widget.screenWidth;
//     //          offsetX = 0.0;
//     //       });
//     //     } else {
//     //       setState(() {
//     //         offsetX += details.delta.dx;
//     //       });
//     //     }
//     //     // print("onHorizontalDragUpdate======>>>>>>>>$offsetX");
//     //   },
//     //   child: page,
//     // );

//     page = Stack(
//       children: <Widget>[
//         // GestureDetector(
//         //   onTap: (){
//         //     print("GestureDetector===>tap");
//         //   },
//         //   child: page,
//         // ),
//         PositionedDirectional(
//           start: 0.0,
//           width: widget.screenWidth ,
//           top: 0.0,
//           bottom: 0.0,
//           child: Listener(
//               onPointerDown: _handlePointerDown,
//               behavior: HitTestBehavior.opaque,
//               child: page,
//             ),
//         )
//       ],
//     );
    

//     // return page;

//     return Transform.translate(
//       offset: Offset(max(0, this.offsetX), 0),
//       child: page 
//     );

//   }

//   void _handlePointerDown(PointerDownEvent event) {
//       _recognizer.addPointer(event);
//   }

//   /// 滑动到左边
//   ///
//   /// [offsetX] to [screenWidth]
//   void animateToLeft(BuildContext context, double screenWidth) {
//     Navigator.of(context).pop();
//     // animationControllerX =
//     //     AnimationController(duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500), vsync: this);
//     // final curve = CurvedAnimation(parent: animationControllerX, curve: Curves.easeOutCubic);
//     // animationX = Tween(begin: offsetX, end: screenWidth).animate(curve)
//     //   ..addListener(() {
//     //     setState(() {
//     //       offsetX = animationX.value;
//     //     });
//     //   });
//     // animationControllerX.forward();
//   }


//     /// [offsetX] to 0.0
//   void animateToMiddle() {
//     animationControllerX = AnimationController(duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500), vsync: this);
//     final curve = CurvedAnimation(parent: animationControllerX, curve: Curves.easeOutCubic);
//     animationX = Tween(begin: offsetX, end: 0.0).animate(curve)
//       ..addListener(() {
//         setState(() {
//           offsetX = animationX.value;
//         });
//       });
//     animationControllerX.forward();
//   }

//   Widget buildContent(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Column(
//           children: <Widget>[

//             AspectRatio(
//               aspectRatio: 16/9,
//                child:  CachedNetworkImage(
//                   imageUrl: widget.liveRoom.imageUrl, 
//                   fit: BoxFit.cover,
//                 ),
//             ),

//             TabBar(
//               isScrollable: true,
//               //是否可以滚动
//               controller: this._tabController,
//               labelColor: Colors.red,
//               unselectedLabelColor: Color(0xff666666),
//               labelStyle: TextStyle(fontSize: 16.0),
//               tabs: tabList.map((item) {
//                 return Tab(text: item,);
//               }).toList(),
//             ),

//             Expanded(
//               child: Listener(
//                 onPointerMove: (PointerMoveEvent pointerMoveEvent){
//                   if(this.currentIndex == 0){
//                     // print('PointerMoveEvent----->>>${pointerMoveEvent.delta.dx}');
//                     // if(pointerMoveEvent.delta.dx > 0){
//                     //   setState(() {
//                     //     this.absorbingTabView = true;
//                     //   });
//                     // }else{
//                     //    setState(() {
//                     //     this.absorbingTabView = false;
//                     //   });
//                     // }
//                   }
//                 },
//                 child: TabBarView(
//                     physics: BouncingScrollPhysics(),
//                     dragStartBehavior: DragStartBehavior.start,
//                     controller: this._tabController,
//                     children: tabList.map((item) {
//                       // return Stack(children: <Widget>[
//                       //   Align(alignment:Alignment.topCenter,child: Text(item),),
//                       // ],);
//                       return Container(
//                         color: Colors.red.withOpacity(0.3),
//                         width: widget.screenWidth,
//                         child:  SingleChildScrollView(
//                           child: Column(
//                             children: List.generate(
//                               100, 
//                               (index) =>Container(
//                                   alignment: Alignment.center,
//                                   width: widget.screenWidth,
//                                   color: Colors.green,
//                                   height: 50.0,
//                                   padding: EdgeInsets.only(bottom: 10.0),
//                                   child: Text('$item'),
//                                 )
//                             ),
//                           ),
//                         )
//                         );
//                     }).toList(),
//                   ),
//                 ),
//             ),

//           ],
//         ),
        
//         Positioned(
//           left: 0.0,
//           right: 0.0,
//           bottom: 0.0,
//           child: this.buildInputWidget(context)
//         )
//       ],
//     );
//   }

//   Widget buildInputWidget(BuildContext context){
//     return Offstage(
//       offstage: this.currentIndex != 0,
//       child: Container(
//         height: 50.0,
//         decoration: BoxDecoration(
//           color: Colors.black38
//         ),
//         child: Text('聊天'),
//       ),
//     );
//   }

// }