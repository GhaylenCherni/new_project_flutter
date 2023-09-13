import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/shop_app/Registre/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_registre/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SocialRegistreCubit extends Cubit<SocialRegistreStates> {
  SocialRegistreCubit() : super(SocialRegistreInitialState());
  static SocialRegistreCubit get(context) => BlocProvider.of(context);

  void userRegistre({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegistreLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print('registre');
      print(error.toString());
      emit(SocialRegistreErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      email: email,
      name: name,
      uId: uId,
      bio: 'Write your bio ...',
      cover: 'https://img.freepik.com/photos-gratuite/personne-appreciant-coucher-du-soleil-chaud-nostalgique_52683-100695.jpg?w=996&t=st=1694266236~exp=1694266836~hmac=5e7a4f1a68f3c25f558a18cbe06486e40936b8dd727f446aac1b194676291817',
      image: 'https://img.freepik.com/photos-gratuite/personne-appreciant-coucher-du-soleil-chaud-nostalgique_52683-100695.jpg?w=996&t=st=1694266236~exp=1694266836~hmac=5e7a4f1a68f3c25f558a18cbe06486e40936b8dd727f446aac1b194676291817',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print('create');
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassworVisiblity() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangePasswordVisiblityState());
  }
}
