import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/Screens/Login/loginScreen.dart';
import 'package:socail_app/Screens/Register/Cubit/cubit.dart';
import 'package:socail_app/Screens/Register/Cubit/states.dart';
import 'package:socail_app/Screens/home.dart';

import '/shared/components/constants.dart';
import '/shared/network/local/cache_helper.dart';

import '/shared/components/components.dart';

class Register extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, Home);
          } else if (state is CreateUserErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          /*if (state is RegisterSuccessState) {
            if (state.login.status!) {
              print(state.login.message);
              print(state.login.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.login.data!.token,
              ).then((value) {
                token = state.login.data!.token!;
                //navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.login.message);
              showToast(
                text: state.login.message!,
                state: ToastStates.ERROR,
              );
            }
          }*/
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Register now to communicate with friends ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your name";
                            }
                          },
                          label: "User Name",
                          prefix: Icons.person_outline_outlined,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            }
                          },
                          label: "Email",
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          isPassword: RegisterCubit.get(context).isPress,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Password is too short";
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock_outline_rounded,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your phone";
                            }
                          },
                          label: "Phone",
                          prefix: Icons.phone_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                                navigateAndFinish(context, Home());
                              }
                            },
                            text: "Register",
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don\'t have an acount ?",
                            ),
                            defultTextBottom(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  Login(),
                                );
                              },
                              text: 'login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
