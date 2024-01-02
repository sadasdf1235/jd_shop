import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_shop/utils/searchService.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}
class _SearchState extends State<Search> {
  TextEditingController _textEditingController = TextEditingController();
  List _searchList = [];
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _getSearchList();
  }
  _getSearchList()async{
    List data = await SearchService.getSearchData();
    setState(() {
      _searchList = data;
    });
  }
  Widget _historyList(){
    return Column(
      children: [
        const SizedBox(
          child: Text("历史记录"),
        ),
        Column(
          children: _searchList.map((e){
            return Column(
              children: [
                ListTile(
                  title: Text(e),
                ),
                const Divider(),
              ],
            );
          }).toList(),
        ),
        IconButton(onPressed: ()async{
          await SearchService.clearSearchList();
          setState(() {
            _searchList = [];
          });
        }, icon: const Icon(Icons.delete),)
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenUtil().setHeight(68),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(233, 233, 233, 0.8)
          ),
          child: TextField(
            controller: _textEditingController,
            autofocus: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
            ),
            onSubmitted: (value){
              SearchService.setSearchData(_textEditingController.text);
              Navigator.pushReplacementNamed(context, '/productList',arguments: {
                "keywords": value,
              });
            },
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(68),
              height: ScreenUtil().setHeight(68),
              child: const Text('搜索'),
            ),
            onTap: (){
              SearchService.setSearchData(_textEditingController.text);
              Navigator.pushReplacementNamed(context, '/productList',arguments: {
                "keywords": _textEditingController.text,
              });
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              child: Text("热搜"),
            ),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("1231231"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("1231231"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("1231231"),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            _searchList.isEmpty ? const Text(''): _historyList(),
          ],
        ),
      ),
    );
  }
}
