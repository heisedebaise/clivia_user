import 'package:clivia_base/component/language.dart';
import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/page/privacy.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../../user.dart';

class InUpPage extends StatefulWidget {
  const InUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InUpPageState();
}

class _InUpPageState extends State<InUpPage> {
  bool up = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat = TextEditingController();
  TextEditingController nick = TextEditingController();
  bool visibility = false;
  bool agree = false;

  @override
  void initState() {
    super.initState();
    username.text = User.uid();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (User.gesture()) {
        PageRouter.push(
          PasswordPage(
            l10n(context, 'sign.in'),
            'user.sign-in.gesture',
            complete: (value) async {
              String? string = await User.signInGesture(value);
              if (string == null) Navigator.pop(context);

              return Future.value(string);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: PopPage(
        popable: User.anonymous,
        close: true,
        title: l10n(context, 'sign.${up ? 'up' : 'in'}'),
        actions: [
          Language(
            icon: true,
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ],
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            children: children(),
          ),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
      onWillPop: () => Future.value(User.anonymous));

  List<Widget> children() {
    List<Widget> list = [];
    list.add(text(Icons.person, l10n(context, 'sign.username'), username));
    list.add(pass(l10n(context, 'sign.password'), password));
    if (up) {
      list.add(pass(l10n(context, 'sign.password.repeat'), repeat));
      list.add(text(
        Icons.face_retouching_natural,
        l10n(context, 'sign.nick.new'),
        nick,
      ));
      list.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? false;
              });
            },
          ),
          TextButton(
            onPressed: () {
              PageRouter.push(const PrivacyAgreementPage());
            },
            child: Text(l10n(context, 'sign.privacy-agreement')),
          ),
        ],
      ));
      list.add(elevated(l10n(context, 'sign.up')));
      list.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                up = false;
              });
            },
            child: Text(l10n(context, 'sign.to-in')),
          ),
        ],
      ));
    } else {
      list.add(elevated(l10n(context, 'sign.in')));
      list.add(Row(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                up = true;
              });
            },
            child: Text(l10n(context, 'sign.to-up')),
          ),
          Expanded(
            child: Container(),
          ),
          TextButton(
            onPressed: () {},
            child: Text(l10n(context, 'sign.password.forget')),
          ),
        ],
      ));
    }

    return list;
  }

  Widget text(IconData icon, String label, TextEditingController controller) => TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
        ),
        controller: controller,
      );

  Widget pass(String label, TextEditingController controller) => TextField(
        obscureText: !visibility,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: label,
          suffixIcon: GestureDetector(
            child: Icon(visibility ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                visibility = !visibility;
              });
            },
          ),
        ),
        controller: controller,
      );

  Widget elevated(String text) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: up && !agree
              ? null
              : () async {
                  if (up) {
                    if (await User.signUp(username.text, password.text, nick.text)) Navigator.pop(context);
                  } else {
                    if (await User.signIn(username.text, password.text)) Navigator.pop(context);
                  }
                },
          child: Text(text),
        ),
      );
}
