// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../models/user_model.dart';
import '../../modules/profile/profile.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(uId);
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const ProfileScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Profile',
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  File? profileImage;
  Future<void> getProfileImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      profileImage = File(returnedImage.path);
      emit(SocialGetProfileImageSuccessState());
    } else {
      emit(SocialGetProfileImageErrorState());
      print('No image selected!');
    }
  }

  Future<void> getProfileImageCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage != null) {
      profileImage = File(returnedImage.path);
      emit(SocialGetProfileImageSuccessState());
    } else {
      emit(SocialGetProfileImageErrorState());
      print('No image selected!');
    }
  }

  File? coverImage;
  Future<void> getCoverImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      coverImage = File(returnedImage.path);
      emit(SocialGetCoverImageSuccessState());
    } else {
      emit(SocialGetCoverImageErrorState());
      print('No image selected!');
    }
  }

  Future<void> getCoverImageCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage != null) {
      coverImage = File(returnedImage.path);
      emit(SocialGetCoverImageSuccessState());
    } else {
      emit(SocialGetCoverImageErrorState());
      print('No image selected!');
    }
  }

  void uploadProfileImage(
      {String? email,
      String? uId,
      required String name,
      required String phone,
      dynamic image,
      dynamic cover,
      required String bio}) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage(
      {String? email,
      String? uId,
      required String name,
      required String phone,
      dynamic image,
      dynamic cover,
      required String bio}) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {String? email,
      String? uId,
      required String name,
      required String phone,
      dynamic image,
      dynamic cover,
      required String bio}) {
    UserModel model = UserModel(
      name = name,
      phone = phone,
      email = userModel?.email,
      uId = userModel?.uId,
      bio = bio,
      image = image ?? userModel?.image,
      cover = cover ?? userModel?.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void updateUserInfo(
      {String? email,
      String? uId,
      required String name,
      required String phone,
      dynamic image,
      dynamic cover,
      required String bio}) {
    emit(SocialUserUpdateLoadingState());
    if (coverImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else if (profileImage != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
    } else if (profileImage != null && coverImage != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }

  File? postImage;
  Future<void> getPostImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      postImage = File(returnedImage.path);
      emit(SocialGetPostImageSuccessState());
    } else {
      emit(SocialGetPostImageErrorState());
      print('No image selected!');
    }
  }

  void uploadPostImage({
    dynamic name,
    dynamic uId,
    dynamic image,
    required dateTime,
    required clockTime,
    required text,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPost(
            dateTime: dateTime,
            clockTime: clockTime,
            text: text,
            postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createNewPost(
      {String? name,
      String? uId,
      String? image,
      required String dateTime,
      required String clockTime,
      required String text,
      dynamic postImage}) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name = userModel?.name,
      uId = userModel?.uId,
      image = userModel?.image,
      postImage = postImage ?? '',
      dateTime = dateTime,
      clockTime = clockTime,
      text = text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  Future<void> getPosts() async {
    emit(SocialGetPostLoadingState());

    final postsQuery = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get();

    final likeAndCommentFutures = postsQuery.docs.map((element) async {
      final likesQuery = await element.reference.collection('likes').get();
      final commentsQuery =
          await element.reference.collection('comments').get();
      return {
        'likes': likesQuery.docs.length,
        'comments': commentsQuery.docs.length,
      };
    }).toList();

    final likeAndCommentResults = await Future.wait(likeAndCommentFutures);

    for (var i = 0; i < postsQuery.docs.length; i++) {
      likes.add(likeAndCommentResults[i]['likes']!);
      comments.add(likeAndCommentResults[i]['comments']!);
      postsId.add(postsQuery.docs[i].id);
      posts.add(PostModel.fromJson(postsQuery.docs[i].data()));
    }

    emit(SocialGetPostSuccessState());
  }

  Future<void> postLike(String postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(SocialPostLikeSuccessState());
    }).catchError((error) {
      emit(SocialPostLikeErrorState(error.toString()));
    });
  }

  Future<void> postComment(String postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel?.uId)
        .set({'comment': true}).then((value) {
      emit(SocialPostCommentSuccessState());
    }).catchError((error) {
      emit(SocialPostCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  Future<void> getUsers() async {
    emit(SocialGetAllUsersLoadingState());
    users = [];
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel?.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  var messageController = TextEditingController();
  void clearField() {
    messageController.clear();
  }

  void sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(senderId = userModel?.uId,
        receiverId = receiverId, dateTime = dateTime, text = text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      try {
        final List<MessageModel> updatedMessages = [];
        for (var element in event.docs) {
          updatedMessages.add(MessageModel.fromJson(element.data()));
        }
        messages = updatedMessages.reversed.toList();
        emit(SocialGetMessageSuccessState());
      } catch (e) {
        emit(SocialGetMessageErrorState(e.toString()));
      }
    });
  }

}
