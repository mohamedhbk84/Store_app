class SubCategoriesModel {
  List<Sub> sub = [];
  bool status;
  String errNum;
  String msg;

  SubCategoriesModel({required this.sub,required this.status,required this.errNum,required this.msg});

factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
 List <Sub>  sub = [];
  if (json['sub'] != null) {
    json['sub'].forEach((v) {
      sub.add(new Sub.fromJson(v));
    });
  }
  return SubCategoriesModel(sub: sub, status: json['status'], errNum: json['errNum'], msg: json['msg']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sub != null) {
      data['sub'] = sub.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}

class Sub {
  int id;
  String name;
  String slug;
  String active;
  String image;
  List<Childrens> childrens;

  Sub({required this.id,required this.name,required this.slug,required this.active,required this.image,required this.childrens});

factory  Sub.fromJson(Map<String, dynamic> json) {
  List <Childrens> childrensnew = [];
  if (json['childrens'] != null) {
    json['childrens'].forEach((v) {
      childrensnew.add(new Childrens.fromJson(v));
    });
  }
  return Sub(id: json['id'], name: json['name']??'', slug: json['slug']??'', active:  json['active']??'',
      image: json['image']??'', childrens: childrensnew);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['active'] =active;
    data['image'] = image;
    if (childrens != null) {
      data['childrens'] = childrens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childrens {
  int id;
  String parentId;
  String name;
  String slug;
  String active;
  String image;

  Childrens(
      {required this.id,required this.parentId,required this.name,required this.slug,required this.active,required this.image});

 factory Childrens.fromJson(Map<String, dynamic> json) {
   return Childrens(
       id: json['id'], parentId: json['parent_id']??'',
       name: json['name']??'', slug: json['slug']??'', active: json['active']??'', image: json['image']??'');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['active'] = this.active;
    data['image'] = this.image;
    return data;
  }
}