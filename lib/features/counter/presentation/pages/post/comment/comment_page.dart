import 'package:flutter/material.dart';
import 'package:instagram_ca/constants.dart';
import 'package:instagram_ca/features/counter/presentation/widgets/form_container_widget.dart';

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
        title: Text("Comments"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              sizeHor(10),
              Text(
                "Username",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          sizeVer(10),
          Text(
            "This very beatiful place",
            style: TextStyle(color: primaryColor),
          ),
          sizeVer(10),
          Divider(
            color: secondaryColor,
          ),
          sizeVer(10),
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizeHor(10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                size: 20,
                                color: darkGreyColor,
                              )
                            ],
                          ),
                          sizeVer(4),
                          Text(
                            "This comment",
                            style: TextStyle(color: primaryColor),
                          ),
                          sizeVer(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "08/07/2022",
                                style: TextStyle(
                                    color: darkGreyColor, fontSize: 12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isUserReplying = !_isUserReplying;
                                  });
                                },
                                child: Text(
                                  "Reply",
                                  style: TextStyle(
                                      color: darkGreyColor, fontSize: 12),
                                ),
                              ),
                              Text(
                                "View Replys",
                                style: TextStyle(
                                    color: darkGreyColor, fontSize: 12),
                              ),
                            ],
                          ),
                          _isUserReplying ? sizeVer(10) : sizeVer(0),
                          _isUserReplying
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FormContainerWidget(
                                      hintText: "Post your reply...",
                                    ),
                                    sizeVer(10),
                                    Text(
                                      "Post",
                                      style: TextStyle(color: blueColor),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _commentSection(),
        ],
      ),
    );
  }

  _commentSection() {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      padding: EdgeInsets.symmetric(horizontal: 10),
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
              style: TextStyle(
                color: primaryColor,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Post your comment...",
                hintStyle: TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          Text(
            "Post",
            style: TextStyle(
              fontSize: 15,
              color: blueColor,
            ),
          )
        ],
      ),
    );
  }
}
