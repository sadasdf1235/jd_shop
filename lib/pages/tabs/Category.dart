import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jd_shop/utils/request.dart';
import 'package:jd_shop/model/cartgoryModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  int currentIndex = 0;
  Request request = Request();
  List<CateItemModel> cartgoryData = [];
  List<CateItemModel> cartgoryDetailData = [];
  _getCategoryData() async {
    final res = await request.get("/api/pcate");
    setState(() {
      cartgoryData = CateModel.fromJson(res.data).result;
    });
    _getCategoryDetailData(cartgoryData[0].id);
  }

  _getCategoryDetailData(String id) async {
    final res = await request.get("/api/pcate?pid=$id");
    setState(() {
      cartgoryDetailData = CateModel.fromJson(res.data).result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    var width = (ScreenUtil().screenWidth * 0.75 -
        ScreenUtil().setWidth(10 * 2 + 10 * 2 + 20)) / 3;
    var height = width + ScreenUtil().setHeight(28);
    return Row(
      children: [
        cartgoryData.isNotEmpty
            ? SizedBox(
                width: ScreenUtil().screenWidth / 4,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: cartgoryData.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              _getCategoryDetailData(cartgoryData[index].id);
                            });
                          },
                          child: Container(
                            color: currentIndex == index
                                ? const Color.fromRGBO(240, 246, 246, 0.9)
                                : Colors.white,
                            width: double.infinity,
                            height: ScreenUtil().setHeight(84),
                            child: Text(
                              cartgoryData[index].title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                      ],
                    );
                  },
                ),
              )
            : SizedBox(
                width: ScreenUtil().screenWidth / 4,
                height: double.infinity,
              ),
        cartgoryDetailData.isNotEmpty
            ? Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  height: double.infinity,
                  color: const Color.fromRGBO(240, 246, 246, 0.9),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: width / height),
                      itemCount: cartgoryDetailData.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/productList',arguments: {
                              "cid": cartgoryDetailData[index].id
                            });
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Image.network(
                                    Request.replaceUrl(
                                        cartgoryDetailData[index].pic),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    height: ScreenUtil().setHeight(28),
                                    child: Text(
                                      cartgoryDetailData[index].title,
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            : const Expanded(
                flex: 1,
                child: Center(child: Text("加载中")),
              )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
