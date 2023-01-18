
import 'package:social_app/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
  //    navigateAndFinishSS(context, );
    }
  });

}
String? token = '';
String? uId = '';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');  // 800 is size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
