import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socail_app/Screens/Chat.dart';
import 'package:socail_app/Screens/NewsFeed.dart';
import 'package:socail_app/Screens/Settings.dart';
import 'package:socail_app/Screens/User.dart';
import 'package:socail_app/Screens/addNewPost.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socail_app/models/postModel.dart';

import '../models/UserModel.dart';
import '../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    NewsFeedScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialAddNewPostState());
    } else {
      currentIndex = index;
      emit(SocialAppChangeBottomNavState());
    }
  }

  File? profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      //preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, image: value);
        //emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print('value');
        //print(value);
        updateUser(name: name, bio: bio, phone: phone, cover: value);

        // emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(UpdateUserDataLoadingState());
    print('nnnn');
    // print(userModel!.uId);
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      bio: bio,
      image: image ?? userModel!.image,
      mailVerification: false,
    );
    print(model.name);
    print(model.phone);
    print(model.bio);
    print(model.uId);
    print(model.email);
    print(model.cover);
    print(model.image);

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      //emit(UpdateUserDataSuccessState());
      print('hi');
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  // create Post

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        emit(UploadPostImageErrorState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    print(model.name);
    print(model.text);
    print(model.dateTime);
    print(model.uId);
    print(model.postImage);
    print(model.image);

    FirebaseFirestore.instance
        .collection('Posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  //get posts
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('Likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((error) {
          print(error.toString());
          emit(GetPostErrorState());
        });

      });
      // print(posts[0].image);
      emit(GetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostErrorState());
    });
  }

  void likePost(String postId) {
    emit(LikePostLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId!)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikePostErrorState());
    });
  }
}
