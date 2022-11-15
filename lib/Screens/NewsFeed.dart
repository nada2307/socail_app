import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socail_app/cubit/states.dart';
import 'package:socail_app/models/postModel.dart';
import 'package:socail_app/shared/styles/icon_broken.dart';

import '../cubit/cubit.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
      //  cubit.getPosts();
        return ConditionalBuilder(
          fallback: (context) => const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: const [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/cute-business-woman-idea-thinking-present-pink-background-3d-rendering_56104-1460.jpg?w=740&t=st=1663171052~exp=1663171652~hmac=8c5e17328ab08ccfaf7674f6187c99d06497c3c817c8dfb7c8adf7911b641176',
                        ),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      /*Text(
                    "Communicate with friends",
                    style: GoogleFonts.akayaKanadaka(
                      textStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                    ],
                  ),
                ),
                ListView.separated(
                  itemBuilder: (context, index) =>
                      buildPostItem(context, cubit.posts[index], index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 7.0,
                  ),
                  itemCount: cubit.posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          condition: cubit.posts.isNotEmpty && cubit.userModel != null,
        );
      },
    );
  }
}

Widget buildPostItem(context, PostModel model , int index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.0,
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: GoogleFonts.akayaKanadaka(
                              textStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Icon(
                            Icons.verified_rounded,
                            color: mainColor,
                            size: 18.0,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0.5,
                      ),
                      Text(
                        '${model.dateTime}',
                        style: GoogleFonts.akayaKanadaka(
                          textStyle: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
//                    print(model.image);

                  },
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.grey,
                    size: 17.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            myDivider(),
            const SizedBox(
              height: 12.0,
            ),
            if(model.text != '')
            Text(
              ' ${model.text}',
              style: GoogleFonts.aBeeZee(
                textStyle: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            /*Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 10.0,
                top: 4.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4.0),
                      child: SizedBox(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#mental_health',
                            style: GoogleFonts.actor(
                              textStyle: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4.0),
                      child: SizedBox(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#mental_health',
                            style: GoogleFonts.actor(
                              textStyle: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 130.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 16.0,
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: GoogleFonts.akayaKanadaka(),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 16.0,
                        ),
                       const SizedBox(width: 3.0),
                        Text(
                          '0 Comments',
                          style: GoogleFonts.akayaKanadaka(),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            myDivider(),
            const SizedBox(
              height: 13.0,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 17.0,
                  backgroundImage: NetworkImage(
                    '${SocialCubit.get(context).userModel!.image}',
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: InkWell(
                    child: Text(
                      'Write Your comment',
                      style: GoogleFonts.actor(
                        textStyle:
                            Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                    ),
                    onTap: () {
                      print(SocialCubit.get(context).likes);
                    },
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                       Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        'Like',
                        style: GoogleFonts.actor(
                          textStyle:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
