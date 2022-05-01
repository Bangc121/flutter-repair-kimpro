import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconMenu {
  final String title;
  final IconData iconData;

  IconMenu({required this.title, required this.iconData});
}

final List<IconMenu> iconMenu1 = [
  IconMenu(title: '튜토리얼', iconData: FontAwesomeIcons.mapMarkerAlt),
  IconMenu(title: '공지사항', iconData: FontAwesomeIcons.compressArrowsAlt),
  IconMenu(title: '고객센터', iconData: FontAwesomeIcons.tag),
  IconMenu(title: '이용약관', iconData: FontAwesomeIcons.borderAll)
];

final List<IconMenu> iconMenu2 = [
  IconMenu(title: '동네생활 글', iconData: FontAwesomeIcons.edit),
  IconMenu(title: '동네생활 댓글', iconData: FontAwesomeIcons.commentDots),
  IconMenu(title: '동네생활 주제 목록', iconData: FontAwesomeIcons.star)
];

final List<IconMenu> iconMenu3 = [
  IconMenu(title: '비즈프로필 관리', iconData: FontAwesomeIcons.store),
  IconMenu(title: '지역광고', iconData: FontAwesomeIcons.bullhorn)
];
