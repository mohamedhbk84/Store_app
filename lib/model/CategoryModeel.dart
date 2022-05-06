class CategoriesModel {
  List<Categories> categories= [];
  bool status ;
  String errNum;
  String msg;

  CategoriesModel({required this.categories,required this.status,required this.errNum,required this.msg});

 factory CategoriesModel.fromJson(Map<String, dynamic> json) {
  List<Categories> categoriesnew = [];
   if (json['categories'] != null) {
     json['categories'].forEach((v) {
       categoriesnew.add( Categories.fromJson(v));
     });
   }
   return CategoriesModel(categories: categoriesnew, status: json['status']??'', errNum: json['errNum']??'',
       msg: json['msg']??'');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}

class Categories {
  int id;
  String name;
  String slug;
  String active;
  String image;
  List<Childrens> childrens =[];

  Categories(
      {required this.id,required this.name,required this.slug,required this.active,required this.image,required this.childrens});

factory  Categories.fromJson(Map<String, dynamic> json) {
List  <Childrens> childrensnew = [];
  if (json['childrens'] != null) {

    json['childrens'].forEach((v) {
      childrensnew.add(new Childrens.fromJson(v));
    });
  }
  return Categories(id: json['id']??0, name: json['name']??'', slug: json['slug']??'',
      active: json['active']??'', image: json['image']??'', childrens: childrensnew);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['active'] = active;
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
  List<Childrens> childrens = [];

  Childrens(
      {required  this.id,
       required  this.parentId,
       required this.name,
       required this.slug,
       required this.active,
       required this.image,
       required this.childrens});

 factory Childrens.fromJson(Map<String, dynamic> json) {
   List<Childrens> childrens = [];
   if (json['childrens'] != null) {
     json['childrens'].forEach((v) {
       childrens.add(new Childrens.fromJson(v));
     });
   }
   return Childrens(id: json['id']??0, parentId: json['parent_id']??"", name: json['name']??'',
       slug: json['slug']??'', active: json['active']??'', image: json['image']??'', childrens: childrens);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['active'] = this.active;
    data['image'] = this.image;
    if (childrens != null) {
      data['childrens'] = childrens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class Childrens {
//   int? id;
//   String? parentId;
//   String? name;
//   Null? slug;
//   String? active;
//   String? image;
//
//   Childrens(
//       {this.id, this.parentId, this.name, this.slug, this.active, this.image});
//
//   Childrens.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentId = json['parent_id'];
//     name = json['name'];
//     slug = json['slug'];
//     active = json['active'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['parent_id'] = this.parentId;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['active'] = this.active;
//     data['image'] = this.image;
//     return data;
//   }
// }