import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kimpro/models/profile/icon_menu.dart';

class CardIconMenu extends StatelessWidget {
  final List<IconMenu> iconMenuList;

  CardIconMenu({required this.iconMenuList});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            iconMenuList.length,
            (index) => _buildRowIconItem(
                iconMenuList[index].title, iconMenuList[index].iconData),
          ),
        ),
      ),
    );
  }

  Widget _buildRowIconItem(String title, IconData iconData) {
    return Container(
      height: 50,
      child: InkWell(
          onTap: () {
            //페이지 이동
            print('aaa : 해당 페이지로 이동.');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondRoute()),
            // );
          }, // Handle your callback
          child: Column(
            // padding: EdgeInsets.all(12.0),
            children: [
              Icon(iconData, size: 17),
              const SizedBox(width: 20),
              Text(
                title,
              )
              // Text(title, style: textTheme().subtitle1)
            ],
          )
          // child: Ink(height: 100, width: 100, color: Colors.blue),
          // children: [
          //   Icon(iconData, size: 17),
          //   const SizedBox(width: 20),
          //   Text(
          //     title,
          //   )
          //   // Text(title, style: textTheme().subtitle1)
          // ],
          ),
    );
  }
}
