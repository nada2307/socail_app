import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/Screens/Notifecation.dart';
import 'package:socail_app/Screens/Search.dart';
import 'package:socail_app/Screens/addNewPost.dart';
import 'package:socail_app/cubit/cubit.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/styles/icon_broken.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialAddNewPostState ){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon:  Icon(IconBroken.Search)),
              IconButton(onPressed: (){
                navigateTo(context, NotifecationScreen());
              }, icon:  Icon(IconBroken.Notification)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items:  [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

/* ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context){
              var model = FirebaseAuth.instance.currentUser!.emailVerified;
              return Column(
                children: [
                  if(!model)
                  Container(
                    color: Colors.amberAccent.withOpacity(0.5),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              'please Verify your email ',
                            ),
                          ),
                          SizedBox(width: 15.0,),
                          defaultTextButton(
                            function: (){
                              FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                                showToast(text: "Check Your Mail", state: ToastStates.SUCCESS);
                              }).catchError((error){
                                print(error.toString());
                              });
                            },
                            text: "send",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) =>  Center(child: CircularProgressIndicator()),

          ),*/
