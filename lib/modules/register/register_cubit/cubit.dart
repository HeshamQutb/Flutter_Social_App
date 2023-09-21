// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

import '../../../models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
}){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      userCreate(
        email: email,
        uId: value.user!.uid,
        name: name,
        phone: phone,
      );
      print(value.user?.email);
      print(value.user?.uid);
    }
    ).catchError((error){
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          emit(RegisterErrorState('This email address is already in use.'));
        } else
        {
          emit(RegisterErrorState(error.toString()));
        }
      } else
      {
        emit(RegisterErrorState('An error occurred while registering, please check you information'));
      }
    }
    );

  }


  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String phone,
    String? image,
    String? cover,
    String? bio
  }){
    UserModel model = UserModel(
      name = name,
      phone = phone,
      email = email,
      uId = uId,
      bio = 'add bio here ... ',
      image = 'https://img.freepik.com/free-icon/man_318-677829.jpg',
      cover = 'https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg',

    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()
    ).then((value)
    {
      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword == true ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }


}