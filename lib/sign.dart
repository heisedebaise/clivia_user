import 'package:clivia_base/component/avatar.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../user.dart';
import 'sign/inup.dart';
import 'sign/main.dart';

class Sign extends StatefulWidget {
  final void Function(void Function()) setState;

  const Sign({Key? key, required this.setState}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 4),
        shape: const RoundedRectangleBorder(),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Avatar(uri: User.avatar(''), nick: User.nick('')),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      User.nick(l10n(context, 'sign.nick.empty')),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ID: ${User.code('00000000')}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Icon(
                          Icons.qr_code_2,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () async {
            await PageRouter.push(User.on() ? const SignPage() : const InUpPage());
            widget.setState(() {});
          },
        ),
      );
}
