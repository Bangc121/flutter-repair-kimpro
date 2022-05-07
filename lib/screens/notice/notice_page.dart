import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:kimpro/models/notice/user.dart';
import 'package:kimpro/screens/list/list.dart';
import 'package:kimpro/screens/notice/notice_row.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatefulWidget {
  NoticeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NoticeScreen> {
  List<String> images = [
    "assets/images/avatar.png",
    "assets/images/avatar.png",
    "assets/images/avatar.png",
    "assets/images/avatar.png",
  ];
  DateTime currentPhoneDate = DateTime.now(); //DateTime

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("공지사항"),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(images[index]),
              ),
              title: Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*2*/
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${index + 1} 공지사항 목록 공지사항 목록',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(DateFormat("yyyy.MM.dd").format(currentPhoneDate),
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                              // Icon(Icons.fiber_new_outlined),
                            ),
                            Icon(Icons.fiber_new_outlined),
                            ],
                          ),
                        ),
                        // Text(
                        //   DateFormat("yyyy.MM.dd").format(currentPhoneDate),
                        //   // 'Kandersteg, Switzerland',
                        //   style: TextStyle(
                        //     color: Colors.grey[500],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  /*3*/
                  Icon(
                    // Icons.star,
                    FontAwesomeIcons.plus,
                    // color: Colors.red[500],
                  ),
                  // Text('41'),
                ],
              ),
              // title: Text("${index} This is title"),
              // subtitle: Container(
              //   padding: const EdgeInsets.only(bottom: 8),
              //   child: Text(
              //     'ㄴㅇㄹㄴㅇ',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // subtitle: Text(DateFormat("yyyy.MM.dd").format(currentPhoneDate)),
                // subtitle: Text(DateFormat("yyyy-MM-dd hh:mm:ss").parse(currentPhoneDate.toString()).toString()),
              // subtitle: Text("This is subtitle  "),
              onTap: () => print("${index}  ListTile")
            );
          },
          separatorBuilder: (BuildContext, index) {
            return Divider(height: 1);
          },
          itemCount: images.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }
}


// 'Date:' + (document['eventDate'].toDate()).DateFormat('kk:mm:a').format(),
// style: new TextStyle(
// color: Color(0xFF49DEE8),
// fontSize: 14.0,
// fontWeight: FontWeight.normal)),