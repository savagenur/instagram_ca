import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_ca/profile_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_ca/injection_container.dart' as di;

import '../../../../domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';

class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  TextEditingController _descriptionController = TextEditingController();
  bool _isUploading = false;
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  File? _image;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image has been selected!");
        }
      });
    } catch (e) {
      toast("Some error occurred: $e!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? _uploadPostWidget()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: GestureDetector(
                onTap: () => setState(() => _image = null),
                child: Icon(Icons.close, size: 28),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: _submitPost,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: profileWidget(
                              imageUrl: widget.currentUser.profileUrl)),
                    ),
                    sizeVer(10),
                    Text("${widget.currentUser.userName}"),
                    sizeVer(10),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: profileWidget(
                            image: _image,
                          ),
                        ),
                        _isUploading
                            ? Container(
                                color: Colors.black45,
                                width: double.infinity,
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    sizeVer(10),
                    ProfileFormWidget(
                      title: "Description",
                      controller: _descriptionController,
                    ),
                    sizeVer(30),
                  ],
                ),
              ),
            ),
          );
  }

  _submitPost() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isUploading = true;
    });
    di
        .sl<UploadImageToStorageUseCase>()
        .call(_image!, true, "posts")
        .then((imageUrl) {
      ;
      _createSubmitPost(image: imageUrl);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
            postEntity: PostEntity(
          description: _descriptionController.text,
          createAt: Timestamp.now(),
          creatorUid: widget.currentUser.uid,
          likes: [],
          postId: Uuid().v1(),
          totalComments: 0,
          totalLikes: 0,
          userName: widget.currentUser.userName,
          userProfileUrl: widget.currentUser.profileUrl,
        ))
        .then((value) => _clear());
  }

  Widget _uploadPostWidget() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: GestureDetector(
          onTap: selectImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(
                .3,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.upload,
                color: primaryColor,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _clear() {
    setState(() {
      _isUploading = false;
      _image = null;
      _descriptionController.clear();
    });
  }
}
