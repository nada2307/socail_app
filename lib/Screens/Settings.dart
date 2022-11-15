import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socail_app/Screens/edit_profile.dart';
import 'package:socail_app/cubit/cubit.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/styles/colors.dart';
import 'package:socail_app/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 195.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${cubit.userModel!.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                            '${cubit.userModel!.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  '${cubit.userModel!.name}',
                  style: GoogleFonts.akayaKanadaka(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  '${cubit.userModel!.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '50',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen(),);
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 15.0,
                      ),
                    ),
                  ],
                ),
               /* const SizedBox(
                  height: 100.0,
                ),*/
                /*Container(
                  width: double.infinity,
                  height: 40.0,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'update'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    color: mainColor,
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
