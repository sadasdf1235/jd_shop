import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_shop/utils/request.dart';

import '../model/productModel.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments;
  ProductListPage({super.key, this.arguments});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Request request = Request();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  List<ProductModelItem> _productList = [];
  int _pageSize = 10;
  int _page = 1;
  String _sort = '';
  bool _flag = false;
  bool _hasMore = true;
  final List _subvHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "selecount", "sort": -1},
    //升序 price_1 降序 price_-1
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  int _selectSubId = 1;
  _getProductListData({String search = ''}) async {
    setState(() {
      _flag = true;
    });
    var res;
    if (search != '' && search != 'null') {
      res = await request.get('/api/plist?search=$search&pageSize=$_pageSize&page=$_page&sort=$_sort');
    } else {
      res = await request.get(
          '/api/plist?cid=${widget.arguments?['cid']}&pageSize=$_pageSize&page=$_page&sort=$_sort');
    }
    if (_productList.length < _pageSize) {
      setState(() {
        _hasMore = false;
      });
    }
    setState(() {
      _productList.addAll(ProductModel.fromJson(res.data).result);
      _page++;
      _flag = false;
      _hasMore = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductListData(search :widget.arguments!['keywords'].toString());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (!_flag && _hasMore) {
          _getProductListData(search :widget.arguments!['keywords'].toString());
        }
      }
    });
  }

  Widget _ProductListWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _productList.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setHeight(180),
                      child: Image.network(
                        Request.replaceUrl(_productList[index].pic),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          height: ScreenUtil().setHeight(180),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_productList[index].title),
                              Text(
                                "￥${_productList[index].price}",
                                style: const TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Divider(
                  height: ScreenUtil().setHeight(20),
                ),
                index == _productList.length
                    ? const CircularProgressIndicator()
                    : const Text('')
              ],
            );
          }),
    );
  }
  Widget _showIcon(e){
    if(e['id'] == 2 || e['id'] == 3){
      if(e['sort'] == 1){
        return const Icon(Icons.arrow_drop_up);
      }else {
        return const Icon(Icons.arrow_drop_down);
      }
    }else {
      return const Text('');
    }
  }
  Widget _SelectWidget() {
    return Positioned(
        top: 0,
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(750),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0))),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _subvHeaderList.map((e) {
              return Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if(e['id'] == 4){
                        _selectSubId = e['id'];
                        _scaffoldKey.currentState?.openEndDrawer();
                      }else {
                        setState(() {
                          _selectSubId = e['id'];
                          //重置数据
                          _page = 1;
                          _hasMore = true;
                          _scrollController.jumpTo(0);
                          _productList = [];
                          e['sort'] = e['sort'] * -1;
                          _sort = "${e['fileds']}_${e['sort']}";
                          _getProductListData(search: widget.arguments?['keywords']);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          e['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: e['id'] == _selectSubId ? Colors.red : Colors.black54,
                          ),
                        ),
                        _showIcon(e),
                      ],
                    ),
                  ));
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("商品列表"),
        actions: const [Text("")],
      ),
      endDrawer: const Drawer(
        child: Text("抽屉"),
      ),
      body: Stack(
        children: [
          _productList.isNotEmpty ? _ProductListWidget() : const Text(''),
          _SelectWidget(),
        ],
      ),
    );
  }
}
