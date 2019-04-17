import 'package:flutter/material.dart';

class article_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return article_page_state();
  }
}

class article_page_state extends State<article_page> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}