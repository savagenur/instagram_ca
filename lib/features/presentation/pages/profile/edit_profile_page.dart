import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/domain/entities/user/user_entity.dart';
import 'package:instagram_ca/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_ca/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:instagram_ca/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_ca/injection_container.dart' as di;

import '../../../../profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;
  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _userNameController;
  TextEditingController? _nameController;
  TextEditingController? _websiteController;
  TextEditingController? _bioController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.name);
    _userNameController =
        TextEditingController(text: widget.currentUser.userName);
    _websiteController =
        TextEditingController(text: widget.currentUser.website);
    _bioController = TextEditingController(text: widget.currentUser.bio);

    super.initState();
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
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: GestureDetector(
                onTap: _updateUserProfileData,
                child: Icon(
                  Icons.done,
                  color: blueColor,
                  size: 32,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: profileWidget(
                        imageUrl: widget.currentUser.profileUrl, image: _image),
                  ),
                ),
              ),
              sizeVer(15),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: Text(
                    "Change profile photo",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: "Name",
                controller: _nameController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: "Username",
                controller: _userNameController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: "Website",
                controller: _websiteController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: "Bio",
                controller: _bioController,
              ),
              sizeVer(15),
              _isUpdating
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Please wait",
                              style: TextStyle(color: primaryColor),
                            ),
                            sizeHor(10),
                            CircularProgressIndicator(),
                          ],
                        ),
                        sizeVer(10),
                      ],
                    )
                  : sizeVer(50),
            ],
          ),
        ),
      ),
    );
  }

  _updateUserProfileData() {
    setState(() {
      _isUpdating = true;
    });
    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    if (_image == null) {
      _updateUserProfile('');
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, false, "profileImages")
          .then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
            userEntity: UserEntity(
          uid: widget.currentUser.uid,
          userName: _userNameController!.text,
          name: _nameController!.text,
          bio: _bioController!.text,
          website: _websiteController!.text,
          profileUrl: profileUrl,
        ))
        .then((value) => _clear());
  }

  _clear() {
    _userNameController!.clear();
    _nameController!.clear();
    _websiteController!.clear();
    _bioController!.clear();
    setState(() {
      _isUpdating = false;
    });
    Navigator.pop(context);
  }
}
