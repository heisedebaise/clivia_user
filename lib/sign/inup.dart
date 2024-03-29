import 'package:clivia_base/component/dialog.dart';
import 'package:clivia_base/component/language.dart';
import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/page/privacy.dart';
import 'package:clivia_base/util/context.dart';
import 'package:clivia_base/util/generator.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/keyvalue.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_capchar.dart';

import '../../user.dart';

class InUpPage extends StatefulWidget {
  const InUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InUpPageState();
}

class _InUpPageState extends State<InUpPage> {
  bool upable = false;
  bool up = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat = TextEditingController();
  TextEditingController nick = TextEditingController();
  TextEditingController invitecode = TextEditingController();
  bool visibility = false;
  bool icable = false;
  late bool agree = Context.get('user.agree', defaultValue: false);
  SliderController controller = SliderController();

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
    Keyvalue.map('setting.user.sign-up.').then((data) {
      if ((data['setting.user.sign-up.enable'] ?? '0') == '1') upable = true;
      if ((data['setting.user.sign-up.invite-code'] ?? '0') == '1') icable = true;
      if (mounted) setState(() {});
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
    if (upable && up) {
      list.add(pass(l10n(context, 'sign.password.repeat'), repeat));
      list.add(text(Icons.face_retouching_natural, l10n(context, 'sign.nick.new'), nick));
      if (icable) list.add(text(Icons.numbers_outlined, l10n(context, 'sign.invite-code'), invitecode));
      list.add(privacy());
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
      list.add(privacy());
      list.add(elevated(l10n(context, 'sign.in')));

      Widget widget;
      if (upable) {
        widget = TextButton(
          onPressed: () {
            setState(() {
              up = true;
            });
          },
          child: Text(l10n(context, 'sign.to-up')),
        );
      } else {
        widget = Container();
      }
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget,
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

  Widget privacy() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: agree,
            onChanged: (value) {
              agree = value ?? false;
              Context.set('user.agree', agree);
              setState(() {});
            },
          ),
          TextButton(
            onPressed: () {
              PageRouter.push(const PrivacyAgreementPage());
            },
            child: Text(l10n(context, 'sign.privacy-agreement')),
          ),
        ],
      );

  Widget elevated(String text) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: agree ? inup : null,
          child: Text(text),
        ),
      );

  Future<void> inup() async {
    Map<String, dynamic> map = await Keyvalue.map('setting.slider-captcha.');
    if (map.isNotEmpty) {
      if ((up && map['setting.slider-captcha.sign-up'] == '1') || (!up && map['setting.slider-captcha.sign-in'] == '1')) {
        Image img = await image(map['setting.slider-captcha.image'] ?? '');
        bool? b = await Dialogs.show(
          context,
          content: SliderCaptcha(
            title: l10n(null, 'sign.captcha'),
            controller: controller,
            image: img,
            colorBar: color(),
            colorCaptChar: color(),
            onConfirm: (value) async {
              if (value) {
                PageRouter.pop(true);
              }
            },
          ),
        );
        if (b == null || !b) return;
      }
    }

    if (up) {
      if (await User.signUp(username.text, password.text, nick.text, invitecode.text)) Navigator.pop(context);
    } else {
      if (await User.signIn(username.text, password.text)) Navigator.pop(context);
    }
  }

  Future<Image> image(String uri) async {
    if (uri != '') {
      if (uri.contains(',')) {
        List<String> list = uri.split(',');
        uri = list[Generator.range(0, list.length)];
      }

      return Future.value(Image.network(
        Http.url(uri),
        fit: BoxFit.fitWidth,
      ));
    }

    return Future.value(Image.asset(
      'images/logo.png',
      fit: BoxFit.fitWidth,
    ));
  }

  Color color() => Colors.primaries[Generator.range(0, Colors.primaries.length)];
}
