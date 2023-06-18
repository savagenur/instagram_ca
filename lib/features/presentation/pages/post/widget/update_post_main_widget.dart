import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/post/post_entity.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_ca/features/presentation/cubit/post/cubit/post_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_ca/profile_widget.dart';
import 'package:instagram_ca/injection_container.dart' as di;

class UpdatePostMainWidget extends StatefulWidget {
  final PostEntity postEntity;
  const UpdatePostMainWidget({super.key, required this.postEntity});

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.postEntity.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isUpdating = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occurred $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Edit Post"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: GestureDetector(
              onTap: _updatePost,
              child: Icon(
                Icons.done,
                color: blueColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child:
                      profileWidget(imageUrl: widget.postEntity.userProfileUrl),
                ),
              ),
              sizeVer(10),
              Text(
                "${widget.postEntity.userName}",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(10),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(
                        imageUrl: widget.postEntity.postImageUrl,
                        image: _image),
                  ),
                  _isUpdating
                      ? Container(
                          color: Colors.black45,
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: !_isUpdating ? selectImage : () {},
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: blueColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizeVer(10),
              ProfileFormWidget(
                controller: _descriptionController,
                title: "Description",
              )
            ],
          ),
        ),
      ),
    );
  }

  _updatePost() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isUpdating = true;
    });
    if (_image == null) {
      _submitUpdatePost(image: widget.postEntity.postImageUrl!);
      _clear();
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, true, "posts")
          .then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      }).then((value) => _clear());
    }
  }

  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context).updatePost(
        postEntity: PostEntity(
      userProfileUrl: widget.postEntity.userProfileUrl,
      creatorUid: widget.postEntity.creatorUid,
      description: _descriptionController.text,
      postId: widget.postEntity.postId,
      postImageUrl: image,
    ));
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _image = null;
      _descriptionController.clear();
      Navigator.pop(context);
    });
  }
}
