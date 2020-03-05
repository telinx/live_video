import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


  

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Animation<double> controller;
  Animation<Offset> imageTranslation;

  Animation<double> navAnimation;
  Animation<Offset> textTranslation;
  Animation<double> imageOpacity;
  Animation<double> textOpacity;

  void _buildAniamtion(){
    if (navAnimation == null) {
      navAnimation = ModalRoute.of(context).animation;
      print("navAnimation===========+++>>>>$navAnimation");
      imageTranslation = Tween(
        begin: Offset(0.0, 2.0),
        end: Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: navAnimation,
          // curve: Interval(0.0, 0.67, curve: Curves.fastOutSlowIn),
          curve: Curves.easeInOut
        ),
      );
      imageOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: navAnimation,
          curve: Interval(0.0, 0.67, curve: Curves.easeIn),
        ),
      );
      textTranslation = Tween(
        begin: Offset(0.0, 1.0),
        end: Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: navAnimation,
          // curve: Interval(0.34, 0.84, curve: Curves.ease),
          curve: Curves.easeInOut
        ),
      );
      textOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: navAnimation,
          curve: Interval(0.34, 0.84, curve: Curves.linear),
        ),
      );
      print("navAnimation===========+++>>>>122");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _buildAniamtion();
      setState(() { });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies============++>>>>1");
    _buildAniamtion();  // 此处代码省略，见上面
    print("didChangeDependencies============++>>>>2");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: navAnimation,
        builder: (BuildContext context, Widget child) {
          print("build============++>>>>imageTranslation:${imageTranslation.value}====textTranslation:${textTranslation.value}");
          return Column(
            children: <Widget>[
              FractionalTranslation(
                translation: imageTranslation.value,
                child: HeaderImage(),
              ),
              Expanded(
                child: FractionalTranslation(
                  translation: textTranslation.value,
                  child: AppText(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 44.0),
      child: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non lorem non justo congue feugiat ut a enim. Ut et sem nec lacus aliquet gravida. Mauris viverra lectus nec vulputate placerat. Nullam sit amet blandit massa, volutpat blandit arcu. Vivamus eu tellus tincidunt, vestibulum neque eu, sagittis neque. Phasellus vitae rutrum magna, eu finibus mi. Suspendisse eget laoreet metus. In mattis dui vitae vestibulum molestie. Curabitur bibendum ut purus in faucibus.",
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: CachedNetworkImage(
        imageUrl: 'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/30/w1080h1350/20200305/c55e-iqmtvwu7415033.jpg',
        height: 300.0,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
