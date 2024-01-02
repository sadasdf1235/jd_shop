class CateModel {
  List<CateItemModel> result;

  CateModel({
    required this.result,
  });

  factory CateModel.fromJson(Map<String, dynamic> json) => CateModel(
    result: List<CateItemModel>.from(json["result"].map((x) => CateItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'CateModel{result: $result}';
  }
}

class CateItemModel {
  String id;
  String title;
  dynamic status;
  String pic;
  String pid;
  String sort;

  CateItemModel({
    required this.id,
    required this.title,
    required this.status,
    required this.pic,
    required this.pid,
    required this.sort,
  });

  factory CateItemModel.fromJson(Map<String, dynamic> json) => CateItemModel(
    id: json["_id"],
    title: json["title"],
    status: json["status"],
    pic: json["pic"],
    pid: json["pid"],
    sort: json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "status": status,
    "pic": pic,
    "pid": pid,
    "sort": sort,
  };

  @override
  String toString() {
    return 'CateItemModel{id: $id, title: $title, status: $status, pic: $pic, pid: $pid, sort: $sort}';
  }
}
