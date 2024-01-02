import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_shop/model/focusModel.dart';
import 'package:jd_shop/model/productModel.dart';
import 'package:jd_shop/utils/request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<String> images = [
    "https://www.toopic.cn/public/uploads/small/1692244507434169224450743.jpg",
    "https://www.toopic.cn/public/uploads/small/1692244453380169224445334.jpg",
    "https://www.toopic.cn/public/uploads/small/1692244447627169224444722.jpg",
    "https://www.toopic.cn/public/uploads/small/169224464040816922446401.jpg",
    "https://www.toopic.cn/public/uploads/small/1692244527532169224452773.jpg",
    "https://www.toopic.cn/public/uploads/small/1692244429269169224442996.jpg",
  ];
  List<FocusItemModel> _focusData = [];
  List<ProductModelItem> _hotProductData = [];
  List<ProductModelItem> _bestProductData = [];
  Request request = Request();
  var width = (ScreenUtil().screenWidth - ScreenUtil().setWidth(30)) / 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  _getFocusData() async {
    final result = await request.get('/api/focus');
    setState(() {
      _focusData = FocusModel.fromJson(result.data).result;
    });
  }

  _getHotProductData() async {
    final result = await request.get("/api/plist?is_hot=1");
    setState(() {
      _hotProductData = ProductModel.fromJson(result.data).result;
    });
  }

  _getBestProductData() async {
    final result = await request.get("/api/plist?is_best=1");
    setState(() {
      _bestProductData = ProductModel.fromJson(result.data).result;
    });
  }

  Widget _swiperWidget() {
    return _focusData.isNotEmpty
        ? AspectRatio(
            aspectRatio: 2 / 1,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  Request.replaceUrl(_focusData[index].pic as String),
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: _focusData.length,
              pagination:
                  const SwiperPagination(alignment: Alignment.bottomRight),
            ),
          )
        : const Text("加载中");
  }

  Widget _titleSwiper(String title) {
    return Container(
      height: ScreenUtil().setHeight(34),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtil().setWidth(10)))),
      child: Text(
        title,
        style:
            TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }

  Widget _hotProductList() {
    return _hotProductData.isNotEmpty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(230),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(140),
                      height: ScreenUtil().setHeight(140),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      child: Image.network(
                        Request.replaceUrl(_hotProductData[index].pic),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                      child: Text(
                        _hotProductData[index].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                );
              },
              itemCount: 10,
            ),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(230),
            child: const Text("加载中"),
          );
  }

  Widget _bestProduct() {
    return Wrap(
      runSpacing: ScreenUtil().setHeight(10),
      spacing: ScreenUtil().setWidth(10),
      children: _bestProductData.map((e) {
        return _recProductItemWidget(e);
      }).toList(),
    );
  }

  Widget _recProductItemWidget(value) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black12, width: ScreenUtil().setWidth(1))),
      width: width,
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.network(
                Request.replaceUrl(value.pic),
                fit: BoxFit.cover,
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Text(
              value.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "￥${value.price}",
                      style: TextStyle(color: Colors.red),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "￥${value.oldPrice}",
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
            onPressed: null,
            icon: Icon(Icons.center_focus_weak,size: 28,color: Colors.black87,),
        ),
        title: InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/search');
          },
          child: Container(
            height: ScreenUtil().setHeight(70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(233, 233, 233, 0.8)
            ),
            child: const Row(
              children: [
                Icon(Icons.search),
                Text('笔记本')
              ],
            ),
          ),
        ),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.message,size: 28,color: Colors.black87,),
          )
        ],
      ),
      body: ListView(
        children: [
          _swiperWidget(),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          _titleSwiper("猜你喜欢"),
          _hotProductList(),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          _titleSwiper("推荐"),
          _bestProduct(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
