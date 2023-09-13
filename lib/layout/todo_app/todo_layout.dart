import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
 import 'package:udemy_flutter/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
 import 'package:udemy_flutter/modules/todo_app/done_tasks/done_tasks_screen.dart';
 import 'package:udemy_flutter/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

// 1.create database
// 2.create tables
// 3.open database
// 4.insert to database
// 5.get from databasse
// 6.update in database
// 7.delete from database

class HomeLayout extends StatelessWidget
{



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatbase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context , AppStates state){
          if (state is AppInsertDatabsaeState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.Titles[cubit.currentIndex],
              ),
            ),
            body:ConditionalBuilder(
              condition: state is! AppGetDatabsaeLoadingState,
              builder: (context)=>cubit.Screens[cubit.currentIndex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // try {
                //   var name = await getName();
                //   print(name);
                //   print ('Ghaylen);
                //   throw('some errror');
                // } catch (error) {
                //   print('error ${error.toString()}');
                // }

                // getName().then((value) {
                //   print(value);
                //   print('Ghaylen');
                //   // throw('I have made an error');
                // })
                //     //     .then((_) {
                //     //   // This block is reached only if the previous `then` didn't throw an error
                //     //   print('Success');
                //     // })
                //     .catchError((error) {
                //   print('Error is: ${error.toString()}');
                // });

                // =true
                if (cubit.isButtomSheetShown) {
                  if (formKey.currentState?.validate() ?? false) {
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);

                    // insertToDatabase(
                    //   date: dateController.text,
                    //   time: timeController.text,
                    //   title: titleController.text,
                    // ).then((value) {
                    //   getDataFromDataBase(database).then((value)
                    //   {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //
                    //     //   isButtomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks = value;
                    //     //   print(tasks);
                    //     // });
                    //
                    //
                    //     // if (tasks != null && tasks!.isNotEmpty) {
                    //     //   print(tasks![0]['title']);
                    //     //   print(tasks![0]['time']);
                    //     // }
                    //   });
                    //
                    // });
                  }
                }
                else {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (value){
                                if (value!.isEmpty){
                                  return ('value must not be empty');
                                }
                                return null;
                              },
                              label: 'Task title',
                              prefix: Icons.title,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    timeController.text = value.format(context).toString();
                                    print(value.format(context));
                                  }
                                });
                              },

                              validate: (value){
                                if (value!.isEmpty){
                                  return ('time must not be empty');
                                }
                                return null;
                              },
                              label: 'Task time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-11-11'),
                                ).then((value) {
                                  // if (selectedDate != null) {
                                  //   dateController.text =
                                  //   selectedDate.toLocal().toString().split(' ')[0];
                                  //   print(selectedDate.toLocal());
                                  // }
                                  if (value != null) {
                                    String formattedDate = DateFormat.yMMMd().format(value);
                                    print(formattedDate);
                                    dateController.text = formattedDate; // Update the text value of the controller
                                  } else {
                                    print("DateTime value is null.");
                                  }
                                });
                              },
                              validate: (value){
                                if (value!.isEmpty){
                                  return ('date must not be empty');
                                }
                                return null;
                              },
                              label: 'Task date',
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 15.0,
                  ).closed.then((value) {
                    cubit.chngeButtomSheetState(isShow: false, icon: Icons.edit);
                    // isButtomSheetShown = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  cubit.chngeButtomSheetState(isShow: true, icon: Icons.add);

                  // isButtomSheetShown = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                // setState(() {
                //   currentIndex = index;
                // });
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Ahmed Ali';
  // }





}




