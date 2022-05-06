import 'package:store/shared/network/local/cache_helper.dart';
 String firebaseToken = '';
class Utils{

   static String getToken(){
    if(CacheHelper.getData(key: "token")==null){
      return "";
    }else{
      return "Bearer ${CacheHelper.getData(key: "token")}";
    }

  }
}