import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopRegistreStates {}

class ShopRegistreInitialState extends ShopRegistreStates {}

class ShopRegistreLoadingState extends ShopRegistreStates {}

class ShopRegistreSuccessState extends ShopRegistreStates {

  final ShopLoginModel loginModel;

  ShopRegistreSuccessState(this.loginModel);
}

class ShopRegistreErrorState extends ShopRegistreStates {
  final String error;

  ShopRegistreErrorState(this.error);

}

class ShopChangePasswordVisiblityState extends ShopRegistreStates {}
