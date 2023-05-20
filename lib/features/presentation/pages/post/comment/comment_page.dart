import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/presentation/widgets/form_container_widget.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool _isUserReplying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
            )),
        title: const Text("Comments"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    sizeHor(10),
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    sizeHor(10),
                  ],
                ),
                sizeVer(10),
                const Text(
                  "This is very beautiful place",
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          sizeVer(10),
          const Divider(
            color: secondaryColor,
          ),
          sizeVer(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizeHor(10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Username",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 22,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          sizeVer(4),
                          const Text(
                            "This is comment",
                            style: TextStyle(color: primaryColor),
                          ),
                          sizeVer(4),
                          Row(
                            children: [
                              const Text(
                                "02/20/2002",
                                style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 12,
                                ),
                              ),
                              sizeHor(15),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isUserReplying = !_isUserReplying;
                                  });
                                },
                                child: const Text(
                                  "Reply",
                                  style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              sizeHor(15),
                              const Text(
                                "View Replies",
                                style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          _isUserReplying ? sizeVer(10) : sizeVer(0),
                          _isUserReplying
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const FormContainerWidget(
                                      hintText: "Post your reply...",
                                    ),
                                    sizeVer(10),
                                    const Text(
                                      "Post",
                                      style: TextStyle(
                                        color: blueColor,
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _commentSection(),
        ],
      ),
    );
  }

  Widget _commentSection() {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          sizeHor(10),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                color: primaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Post your comment...",
                hintStyle: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          const Text(
            "Post",
            style: TextStyle(
              fontSize: 15,
              color: blueColor,
            ),
          ),
        ],
      ),
    );
  }
}
