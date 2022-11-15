import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/Screens/Register/Cubit/states.dart';
import 'package:socail_app/models/UserModel.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
        email: email,
        uId: value.user!.uid,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model = UserModel( name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover: 'https://img.freepik.com/premium-photo/businessman-suit-holding-out-hand-icon-user-internet-icons-interface-foreground-global-network-media-concept-contact-virtual-screens-copy-space_150455-11620.jpg?size=626&ext=jpg&uid=R79185227&ga=GA1.2.854155706.1663170007',
      bio: 'write your bio...',
      image: 'https://cdn.vanderbilt.edu/vu-web/lab-wpcontent/sites/49/2019/04/04204241/no-photo.png',
      mailVerification: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPress = true;

  void changePasswordVisibility() {
    isPress = !isPress;
    suffix =
        isPress ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }
}
