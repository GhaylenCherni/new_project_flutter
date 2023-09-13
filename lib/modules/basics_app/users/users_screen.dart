import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';



class UsersScreen  extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1 ,
        name:'Ghaylen' ,
        phone:'+216 96705345',
    ),
    UserModel(id: 2 ,
      name:'Abdou' ,
      phone:'+216 965483443',
    ),
    UserModel(id: 3 ,
      name:'ggggg' ,
      phone:'+216 96712345',
    ),
    UserModel(id: 1 ,
      name:'Ghaylen' ,
      phone:'+216 96705345',
    ),
    UserModel(id: 2 ,
      name:'Abdou' ,
      phone:'+216 965483443',
    ),
    UserModel(id: 3 ,
      name:'ggggg' ,
      phone:'+216 96712345',
    ),
    UserModel(id: 1 ,
      name:'Ghaylen' ,
      phone:'+216 96705345',
    ),
    UserModel(id: 2 ,
      name:'Abdou' ,
      phone:'+216 965483443',
    ),
    UserModel(id: 3 ,
      name:'ggggg' ,
      phone:'+216 96712345',
    ),
    UserModel(id: 1 ,
      name:'Ghaylen' ,
      phone:'+216 96705345',
    ),
    UserModel(id: 2 ,
      name:'Abdou' ,
      phone:'+216 965483443',
    ),
    UserModel(id: 3 ,
      name:'ggggg' ,
      phone:'+216 96712345',
    ),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Users',
        ),
      ),
      body:ListView.separated(
        itemBuilder:(context,index)=>buildUserItem(users[index]),
        separatorBuilder: (context,index)=>Padding(
          padding: EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }
  Widget buildUserItem(UserModel user)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${user.id}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              '${user.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );

}

// 1 : build item
// 2 : build List
// 3 : add item to list

