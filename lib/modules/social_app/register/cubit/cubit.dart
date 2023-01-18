import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_models/users.dart';
import 'package:social_app/modules/social_app/register/cubit/states.dart';

class SocialAppRegisterCubit extends Cubit<SocialAppRegisterStates>{

  SocialAppRegisterCubit() : super(SocialAppRegisterInitialState());

  static SocialAppRegisterCubit get(context)=> BlocProvider.of(context);


  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changIconRegisterPasswordState(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(SocialAppRegisterShowPasswordState());
  }


  void userRegister({
  required String email,
  required String password,
  required String phone,
  required String name,
})
  {
    emit(SocialAppRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      createUser(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone
      );
    }).catchError((error){
      emit(SocialAppRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,

  }){
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      bio: 'boudy nafe3 ',
      isEmailVerified: false,
      image: 'https://image.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
      cover: 'https://image.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SocialAppCreateUserSuccessState());
    }).catchError((error){
      emit(SocialAppCreateUserErrorState(error.toString()));
    });
  }


}