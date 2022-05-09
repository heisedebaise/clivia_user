import 'package:clivia_base/component/dark.dart';
import 'package:clivia_base/component/dividers.dart';
import 'package:clivia_base/component/language.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:flutter/material.dart';

import '../user.dart';
import 'aboutus.dart';
import 'feedback.dart';
import 'lockscreen.dart';
import 'privacy.dart';
import 'sign.dart';
import 'uploadlog.dart';
import 'version.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Sign(setState: setState),
          settings(),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FeedBack(),
                Dividers.line,
                const Version(),
                Dividers.line,
                const UploadLog(),
                Dividers.line,
                const PrivacyAgreement(),
                Dividers.line,
                const AboutUs(),
              ],
            ),
          ),
        ],
      );

  Widget settings() {
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(l10n(context, 'me.settings')),
      ),
      Dividers.line,
      const Language(),
    ];
    if (User.on()) {
      children.add(Dividers.line);
      children.add(const LockScreen());
    }
    children.add(Dividers.line);
    children.add(const Dark());

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
