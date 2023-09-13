import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/new_tasks/new_tasks_screen.dart';
// import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
// import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
// import 'package:udemy_flutter/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;



  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> Titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeButtomNavBarState());
  }

  Database? database;

  List<Map<String, dynamic>>? newTasks = [];
  List<Map<String, dynamic>>? archivedTasks = [];
  List<Map<String, dynamic>>? doneTasks = [];


  void createDatbase()  {
    openDatabase('todod.db', version: 1,
        onCreate: (database, version) {
          print('databse created');
          database
              .execute(
              'create table tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('success');
          }).then((_) {
            print('table created');
          }).catchError((error) {
            print('Error is: ${error.toString()}');
          });
        }, onOpen: (database) {
          getDataFromDataBase(database);

          print('databse opened');
        },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabsaeState());
    });
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new")');
        print('Inserted successfully');
        emit(AppInsertDatabsaeState());
        getDataFromDataBase(database);
      } catch (error) {
        print('Error is: ${error.toString()}');
      }
    });
  }

  void getDataFromDataBase(database)  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabsaeLoadingState());
     database?.rawQuery('SELECT * from tasks').then((value)
     {

       // tasks = value;
       // print(tasks);

       value.forEach((element)
       {
         if (element['status'] == 'new') newTasks?.add(element);
         else if  (element['status'] == 'done') doneTasks?.add(element);
         else archivedTasks?.add(element);
       });
       emit(AppGetDatabsaeState());


       // if (tasks != null && tasks!.isNotEmpty) {
       //   print(tasks![0]['title']);
       //   print(tasks![0]['time']);
       // }
     });
  }

  void updateDatabase ({
  required String status,
  required int id,
}) async
  {
     database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id],
     ).then((value)
     {
       getDataFromDataBase(database);
       emit(AppUpdateDatabsaeState());
     });
  }

  void deleteDatabase ({
    required int id,
  }) async
  {
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDatabsaeState());
    });
  }

  bool isButtomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void chngeButtomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isButtomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeButtomSheetState());
  }

bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }

  }
}