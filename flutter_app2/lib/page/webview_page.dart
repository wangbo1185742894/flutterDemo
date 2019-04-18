import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class WebViewPage extends StatefulWidget{

  String url = "";
  String title = "";

  WebViewPage({this.title,@required this.url});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
        withJavascript: true,

      ),
    );
  }

}