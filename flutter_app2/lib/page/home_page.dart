import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app2/tools/ApiManager.dart';
import 'package:flutter_app2/bean/home_banner_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app2/bean/home_article_bean.dart';
import 'webview_page.dart';

class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return home_page_state();
  }
}

class home_page_state extends State<home_page> with AutomaticKeepAliveClientMixin{

  List banners = List();
  List articles = List();
  int curPage =0;
  SwiperController _bannerController = SwiperController();
  SwiperController _banner1 = SwiperController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getBanner();
    getList(0);
    _bannerController.autoplay = true;
    _banner1.autoplay = true;


    _scrollController.addListener((){
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if(maxScroll == pixels){
        curPage++;
        getList(curPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget listView = ListView.builder(
      itemCount:  1 + articles.length,
      itemBuilder: (context, index) {
        if(index == 0){
          return createBanner1Item();
        } else{
          Article article = articles[index - 1];
              return GestureDetector(onTap: ()=>{
                Navigator.push(context, new MaterialPageRoute(builder: (ctx) => WebViewPage(title:article.title ,url: article.link)))
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(

                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        Icon(Icons.child_care,
                            color: Colors.blueAccent,
                            size: 18),
                        Text( article.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.blueAccent,fontSize: 16),)
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8),child:
                      Text(article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 13
                        ),
                      ),
                      ),
                    ),
                    Row(children: <Widget>[
                      Icon(Icons.access_time,size: 18,),
                      Text(article.niceDate)
                    ],)
                  ],
                ),
              )

          );
        }
      },
      controller: _scrollController,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("推荐文章"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: RefreshIndicator(child: listView, onRefresh: _pullToRefresh)
    );
  }

  Widget createBanner1Item(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: banners.length != 0?Swiper(itemCount: banners.length,
        autoplayDelay: 3500,
        controller: _banner1,
        pagination: pagination(),
//        viewportFraction: 0.8,
//        scale: 0.9,
        itemBuilder: (BuildContext context,int index){
          return new Image.network(banners[index].imagePath,fit: BoxFit.fill,);
        },
      )
          :SizedBox(
          width: 0,
          height: 0,
      )
    );
  }

  /// 创建banner条目
  Widget createBannerItem() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: banners.length != 0
          ? Swiper(
        autoplayDelay: 3500,
        controller: _banner1,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: 180,
        pagination: pagination(),
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            banners[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: banners.length,
        viewportFraction: 0.8,
        scale: 0.9,
      )
          : SizedBox(
        width: 0,
        height: 0,
      ),
    );
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    await getList(0);
    return null;
  }

  SwiperPagination pagination() => SwiperPagination(
      margin: EdgeInsets.all(0.0),
      builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
            return Container(
              color: Color.fromARGB(0, 255, 255, 255),
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
//                  Text(
//                    "${banners[config.activeIndex].title}",
//                    style: TextStyle(
//                        fontSize: 13, color: Colors.white),
//                  ),
                  Expanded(
                    flex: 1,
                    child: new Align(
                      alignment: Alignment.center,
                      child: new DotSwiperPaginationBuilder(
                          color: Colors.white70,
                          activeColor: Colors.green,
                          size: 6.0,
                          activeSize: 6.0)
                          .build(context, config),
                    ),
                  )
                ],
              ),
            );
          }));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /// 获取首页banner数据
  void getBanner() async {
    Response response = await ApiManager().getHomeBanner();
    var homeBannerBean = HomeBannerBean.fromJson(response.data);
    setState(() {
      banners.clear();
      banners.addAll(homeBannerBean.data);
    });
  }

  void getList(int page)async{
    Response response = await ApiManager().getHomeArticle(page);

    var articleList = HomeArticleBean.fromJson(response.data).data.datas;
    setState(() {
      if(page == 0){
       articles.clear();
      }
      articles.addAll(articleList);
    });
  }

}