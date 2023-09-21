// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/profile/profile_cubit/states.dart';
import '../../../models/user_model.dart';
import '../../../shared/components/constants.dart';


class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getProfileData(){
    emit(GetProfileLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
    {
      print(uId);
      print(value.data());
      model =UserModel.fromJson(value.data());
      emit(GetProfileSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(GetProfileErrorState(error.toString()));
    });
  }

  File? profileImage;
  Future<void> getProfileImage()async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage != null){
      emit(GetProfileImageSuccessState());
      profileImage = File(returnedImage.path);
    }else{
      emit(GetProfileImageErrorState());
      print('No image selected!');
    }
  }



}