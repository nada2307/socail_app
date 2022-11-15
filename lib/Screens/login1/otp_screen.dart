import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:socail_app/Screens/home.dart';
import 'package:socail_app/phone_auth/phone_auth_cubit.dart';
import 'package:socail_app/shared/colors.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/network/local/cache_helper.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
              color: mainColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code numbers sent to ',
              style: const TextStyle(color: mainColor, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(color: secondColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
      barrierColor: backGround.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: mainColor,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: secondColor,
          inactiveColor: secondColor,
          inactiveFillColor: backGround,
          activeFillColor: secondColor,
          selectedColor: secondColor,
          selectedFillColor: backGround,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: backGround,
        enableActiveFill: true,
        onCompleted: (submitedCode) {
          otpCode = submitedCode;
          print("Completed");
        }, onChanged: (String value) {  },

      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PhoneAuthCubit(),
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is Loading) {
              showProgressIndicator(context);
            }

            if (state is PhoneOTPVerified) {
              CacheHelper.saveData(
                key: 'uId',
                value: '255456155',
              ).then((value) {
                Navigator.pop(context);
                navigateAndFinish(context, Home());
              });
            }

            if (state is ErrorOccurred) {
              String errorMsg = state.errorMsg;

              showToast(text: errorMsg, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            //  var cubit = DoctorLoginCubit.get(context);
            return SafeArea(
              child: Scaffold(
                backgroundColor: backGround,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 88),
                    child: Column(
                      children: [
                        _buildIntroTexts(),
                        const SizedBox(
                          height: 88,
                        ),
                        _buildPinCodeFields(context),
                        const SizedBox(
                          height: 60,
                        ),
                        defaultButton(
                            function: () {
                              showProgressIndicator(context);

                              _login(context);
                            },
                            text: 'تأكيد'),
                   ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
