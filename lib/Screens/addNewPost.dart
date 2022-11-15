import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socail_app/cubit/cubit.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:socail_app/shared/components/components.dart';
import 'package:socail_app/shared/styles/colors.dart';

import '../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if(state is CreatePostSuccessState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var textController = TextEditingController();
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                  function: () {
                    var now = DateTime.now();
                    if(cubit.postImage == null){
                      cubit.createPost(text: textController.text, dateTime:now.toString(),);
                    }else{
                      cubit.uploadPostImage(text: textController.text, dateTime:now.toString(),);
                    }
                  },
                  text: 'post',
                ),
                SizedBox(
                  width: 7.0,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                  if(state is CreatePostLoadingState)
                    SizedBox(height: 7.0,),
                    Row(
                    children: [
                      CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                         '${ cubit.userModel!.image}',
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          '${cubit.userModel!.name}',
                          style: GoogleFonts.akayaKanadaka(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "post must not be empty";
                        }
                      },
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what\'s on your mind.....',
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.akayaKanadaka(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 23.0,),

                  if(cubit.postImage != null)
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                         4.0
                          ),
                          image: DecorationImage(
                            image:  FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                            color:  mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 23.0,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: mainColor,
                              ),
                              SizedBox(width: 5.0,),
                              Text(
                                'add photo',
                                style: GoogleFonts.akayaKanadaka(
                                  textStyle: TextStyle(
                                    fontSize: 19.0,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '# tages',
                            style: GoogleFonts.akayaKanadaka(
                              textStyle: TextStyle(
                                fontSize: 19.0,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
