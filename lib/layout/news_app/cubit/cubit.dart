import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
//import 'package:udemy_flutter/modules/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udemy_flutter/modules/news_app/sports/sports_screen.dart';
//import 'package:udemy_flutter/modules/science/science_screen.dart';
//import 'package:udemy_flutter/modules/shop_app/settings_screen/settings_screen.dart';
// import 'package:udemy_flutter/modules/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  void changeBottomNavbar(int index){
    currentIndex = index;
    if(index == 1) getSports();
    if(index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
     // print(value?.data['articles'][0]['title']);
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length ==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        // print(value?.data['articles'][0]['title']);
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }

  }


  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if (science.length ==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        // print(value?.data['articles'][0]['title']);
        science = value?.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetScienceSuccessState());
    }

  }


  List<dynamic> search = [];

  void getSearch(String value)
  {


    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      // print(value?.data['articles'][0]['title']);
      search = value?.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }

}