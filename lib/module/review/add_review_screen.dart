import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/core/constants/icon_path.dart';
import 'package:testapp/core/theme/app_text_style.dart';
import 'package:testapp/module/review/bloc/add_comment_cubit.dart';
import 'package:testapp/module/review/bloc/add_comment_state.dart';
import 'package:testapp/widget/circle_icon.dart';
import 'package:testapp/widget/foot_page.dart';
import 'package:testapp/widget/text_field_widget.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.postId});
  final int postId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState(postId: postId);
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _bodyController = TextEditingController();
  final int postId;

  _AddReviewScreenState({required this.postId});

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            child: CircleIcon(
              iconname: IconPath.back,
              colorCircle: const Color.fromRGBO(245, 246, 250, 1),
              sizeIcon: const Size(25, 25),
              sizeCircle: const Size(45, 45),
              colorBorder: Colors.transparent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Add Review",
          style: AppTextStyle.s17_w6.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldWidget(
                filedSize: Size(MediaQuery.sizeOf(context).width - 40, 50),
                filedName: "Name"),
            SizedBox(
              height: 30,
            ),
            AddText(
              filedSize: Size(MediaQuery.sizeOf(context).width - 40, 213),
              filedName: "How was your experience ?",
              data: _bodyController,
            ),
            BlocListener<AddCommentCubit, AddCommentState>(
                listener: (context, state) {
                  if (state is AddCommentLoadingInProgress) {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is AddCommentSuccess) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else if (state is AddCommentLoadingError) {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: ColoredBox(
                            color: Colors.white,
                            child: Text(state.errorMessage)),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  height: 10,
                ))
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          context.read<AddCommentCubit>().addComment(
                _bodyController.text,
                postId,
                5,
              );
        },
        child: const FootPage(
          textfootpage: 'Submit Review',
        ),
      ),
    );
  }
}

class AddText extends StatelessWidget {
  final TextEditingController data;
  final Size filedSize;
  final String filedName;

  const AddText(
      {super.key,
      required this.filedSize,
      required this.filedName,
      required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filedName,
          style: AppTextStyle.s17_w5
              .copyWith(color: Color.fromRGBO(29, 30, 32, 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Ink(
          width: filedSize.width,
          height: filedSize.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 246, 250, 1)),
          child: TextField(
            controller: data,
            decoration: InputDecoration(
              hintText: "Type Here",
              fillColor: Color.fromRGBO(245, 246, 250, 1),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintStyle: const TextStyle(
                  fontSize: 17, color: Color.fromRGBO(143, 149, 158, 1)),
            ),
          ),
        ),
      ],
    );
  }
}
