import '../models/user.dart';
import 'Cloud_Service/cs_user.dart';
import 'database-helper.dart';
import '../data/Controles/CtrUser.dart';
import 'dart:async';


class RestData {
  DatabaseHelper con = new DatabaseHelper();
  CtrUser ctruser = new CtrUser();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";
  Cloud_Service_User ctrCloudUser = new Cloud_Service_User();

  Future<User> login( String username, String password) async {
    String flagLogged = "logged";
    //simulate internet connection by selecting the local database to check if user has already been registered
    var user = new User(null,null,null, username, password, null);
    var userRetorno = new User(null,null,null,null,null,null);
    //userRetorno = await ctruser.selectUser(user);
    userRetorno = await ctrCloudUser.getUserByUser(user);

    print('voici le user trouver dans lapi:');
    print(userRetorno);

    if(userRetorno != null){
      flagLogged = "logged";
      return new Future.value(new User(userRetorno.id,userRetorno.idFireStore,null, username, password,flagLogged));
    }else {
      flagLogged = "not";
      return new Future.value(new User(null,null,null,username, password,flagLogged));
    }
  }


}
