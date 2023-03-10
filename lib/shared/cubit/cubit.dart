import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates>
{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



  bool isDark = false;
  bool isLight = false;
  IconData lightIcon = Icons.brightness_4_outlined;

  void changeMode({ bool? fromShared })
  {
    if(fromShared != null)
      {
        isDark = fromShared;
        emit(AppChangeModeState());
      }
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}