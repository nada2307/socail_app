import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/Screens/login1/otp_screen.dart';
import 'package:socail_app/phone_auth/phone_auth_cubit.dart';
import 'package:socail_app/shared/components/components.dart';

import '../../../shared/network/local/cache_helper.dart';
import '/shared/styles/colors.dart';
import '/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneScreen extends StatelessWidget {
  final String dId;

  PhoneScreen({Key? key, required this.dId}) : super(key: key);

  late String phoneNumber;
  var formKey = GlobalKey<FormState>();

  var phoneController = TextEditingController();

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'من فضل ادخل رقم هاتفك',
          style: TextStyle(
            color: mainColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              controller: phoneController,
              autofocus: true,
              style: const TextStyle(
                color: mainColor,
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: mainColor,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'ادخل رقم تلفونك!';
                } else if (value.length < 11) {
                  return 'رقم التلفون قصير!';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Center(
              child: Text(
                '${generateCountryFlag()} +20',
                style: const TextStyle(
                    fontSize: 18, letterSpacing: 2.0, color: mainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(mainColor),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPhoneNumberSubmitBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          navigateTo(context, OtpScreen(phoneNumber: phoneNumber));
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PhoneAuthCubit(),
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: backGround,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 88),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIntroTexts(),
                        const SizedBox(
                          height: 50,
                        ),
                        _buildPhoneFormField(),
                        const SizedBox(
                          height: 100,
                        ),
                        defaultButton(
                            function: () {
                              showProgressIndicator(context);
                              if (!formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                return;
                              } else {
                                Navigator.pop(context);
                                formKey.currentState!.save();
                                PhoneAuthCubit.get(context).submitPhoneNumber(phoneController.text);
                              }
                            },
                            text: 'التالى'),
                        _buildPhoneNumberSubmitBloc(),
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
