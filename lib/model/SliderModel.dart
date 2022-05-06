class SliderModel {
  List<Slider> slider= [];
  bool status;
  String errNum;
  String msg;

  SliderModel({required this.slider,required this.status,required this.errNum,required this.msg});

 factory SliderModel.fromJson(Map<String, dynamic> json) {
  List<Slider> slider = [];
   if (json['slider'] != null) {
     json['slider'].forEach((v) {
       slider.add(new Slider.fromJson(v));
     });
   }
   return SliderModel(slider: slider, status: json['status']??'', errNum: json['errNum']??'', msg: json['msg']??'');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slider != null) {
      data['slider'] = slider.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}

class Slider {
  int id;
  String image;

  Slider({required this.id,required this.image});

 factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(id: json['id'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}