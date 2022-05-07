import 'dart:convert';

import 'package:clivia_base/component/pdfview.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/util/context.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/io.dart';
import 'package:clivia_base/util/keyvalue.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class PrivacyAgreement extends StatelessWidget {
  const PrivacyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(S.of(context).mePrivacyAgreement),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const PrivacyAgreementPage());
        },
      );
}

class PrivacyAgreementPage extends StatefulWidget {
  const PrivacyAgreementPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrivacyAgreementPageState();
}

class _PrivacyAgreementPageState extends State<PrivacyAgreementPage> {
  String path = '';

  @override
  void initState() {
    super.initState();
    if (Context.isLinux) return;

    Keyvalue.value('setting.agreement.privacy').then((value) async {
      if (value == '') return;

      dynamic array = json.decode(value);
      if (array == null || array.length == 0) return;

      String uri = array[0]['uri'] ?? '';
      if (uri == '') return;

      String path = Io.absolute(uri.substring(1));
      await Http.download(uri, path);
      setState(() {
        this.path = path;
      });
    });
  }

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: S.of(context).mePrivacyAgreement,
        body: Pdfview(path: path),
      );
}
