
// base url : https://newsapi.org/

// method (url)  : v2/top-headlines?

// queries (map : key , value) : country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca


// https://newsapi.org/v2/everything?q=tesla&apikey=65f7f556ec76449fa7dc7c0069f040ca



import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value) {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chink
  pattern.allMatches(text).forEach((match) => print (match.group(0)));
}

String token = '';

String uId = '';


