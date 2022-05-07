import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/component/webview.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).meAboutUs),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const AboutUsPage());
        },
      );
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).meAboutUs,
        body: const Webview(
          url: 'https://github.com/heisedebaise/clivia-app',
        ),
      );
}
