import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/Registre/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopRegistreCubit extends Cubit<ShopRegistreStates>
{

  ShopRegistreCubit():super(ShopRegistreInitialState());
  static ShopRegistreCubit get(context) => BlocProvider.of (context);

  ShopLoginModel? loginModel ;
  void userRegistre({
  required String name,
  required String email,
  required String password,
  required String phone,
}){
    emit(ShopRegistreLoadingState());
    DioHelper.postData(
        url: REGISTRE,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value)
    {
      print(value?.data);
      loginModel =  ShopLoginModel.fromJson(value?.data);
      emit(ShopRegistreSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegistreErrorState(error.toString()));
    });
  }

 IconData suffix= Icons.visibility_outlined;
  bool isPassword = true;

  void changePassworVisiblity (){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordVisiblityState());
  }
}