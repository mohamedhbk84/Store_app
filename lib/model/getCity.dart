class GetCity {
  List<City> city= [];
  bool status;
  String errNum;
  String msg;

  GetCity({required this.city,required this.status,required this.errNum,required this.msg});

 factory GetCity.fromJson(Map<String, dynamic> json) {
 List <City>  citynew =[];
   if (json['city'] != null) {
     json['city'].forEach((v) {
       citynew.add( City.fromJson(v));
     });
   }
    return GetCity(city: citynew, status: json['status']==null?"":json['status'], errNum: json['errNum'] !=null?json['errNum']:"", msg:  json['msg'] ==null?"":json['msg']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = city.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}

class City {
  int id;
  String cityName ='';

  City({required this.id,required this.cityName});

 factory City.fromJson(Map<String, dynamic> json) {
   return City(id: json['id'] ==null?"":json['id'], cityName: json['city_name']==null?"":json['city_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['city_name'] = cityName;
    return data;
  }
}