import 'package:flutter/material.dart';
import 'package:flutter_app2/page/home_page.dart';
import 'project_page.dart';
import 'package:flutter_app2/page/article_page.dart';

class WBApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WBAppState();
  }
}

class WBAppState extends State<WBApp> with TickerProviderStateMixin{

  var _pageCtrl;
  int _tabIndex = 0;

  @override
  void initState() {
    _pageCtrl = PageController(initialPage: 0,keepPage: true);

  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageCtrl,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            home_page(),
            project_page(),
            article_page(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _tabIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.amberAccent,
            onTap: (index) => _tap(index),
            items:[
              BottomNavigationBarItem(title: Text("首页"),icon: Icon(Icons.home)),
              BottomNavigationBarItem(title: Text("项目"),icon:Icon(Icons.map)),
              BottomNavigationBarItem(title: Text("文章"),icon:Icon(Icons.mail)),
            ]

        ),
      ),
    );
  }
  _tap(int index){
    setState(() {
      _tabIndex = index;
      _pageCtrl.jumpToPage(index);
    });
  }
}