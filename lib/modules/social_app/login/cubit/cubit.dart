import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/login/cubit/states.dart';

class SocialAppLoginCubit extends Cubit<SocialAppLoginStates>{

  SocialAppLoginCubit() : super(SocialAppLoginInitialState());

  static SocialAppLoginCubit get(context)=> BlocProvider.of(context);


  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changIconPasswordState(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(SocialAppLoginShowPasswordState());
  }


  void userLogin({
  required String email,
  required String password,
})
  {
    emit(SocialAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(SocialAppLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialAppLoginErrorState(error.toString()));
    });
  }


}