import 'package:clivia_base/component/avatar.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final bool circular;
  final Color? background;
  final Color? foreground;
  final GestureTapCallback? tap;

  const UserAvatar({Key? key, this.size = 64, this.circular = false, this.background, this.foreground, this.tap}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Avatar(
          uri: User.avatar(''),
          nick: User.nick(''),
          size: size,
          circular: circular,
          background: background,
          foreground: foreground,
        ),
        onTap: tap,
      );
}
