
// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import '../network/local/cache_helper.dart';
import 'components.dart';

void SinOut(context, screen) {
      CacheHelper.removeData(key: 'token').then((value) {
        if (value) {
          print('hi');
          navigateAndFinish(
            context,
            screen,
          );
        }
      });
    }

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


String uId = '';