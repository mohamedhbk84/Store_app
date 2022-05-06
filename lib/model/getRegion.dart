import 'package:flutter/foundation.dart';
class GetRegion {
  List<Regions> regions =[] ;
  bool status;
  String errNum;
  String msg;

  GetRegion({required this.regions,required this.status,required this.errNum,required this.msg});

 factory GetRegion.fromJson(Map<String, dynamic> json) {
  List <Regions> regionsnew = [];
   if (json['regions'] != null) {
     json['regions'].forEach((v) {
       regionsnew.add(new Regions.fromJson(v));
     });
   }
    return GetRegion(regions: regionsnew, status: json['status'], errNum:  json['errNum'], msg:  json['msg']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.regions != null) {
      data['regions'] = regions.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}

class Regions {
  int id;
  String cityId;
  String regionName;

  Regions({required this.id,required this.cityId,required this.regionName});

 factory Regions.fromJson(Map<String, dynamic> json) {
    return Regions(id: json['id'], cityId: json['city_id'], regionName: json['region_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['region_name'] = this.regionName;
    return data;
  }
}