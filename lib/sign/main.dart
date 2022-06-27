import 'package:clivia_base/component/avatar.dart';
import 'package:clivia_base/component/dividers.dart';
import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/component/picture.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/component/qrcode.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../user.dart';
import 'change.dart';
import 'destroy.dart';
import 'inup.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) => PopPage(
        title: l10n(null, 'sign.info'),
        body: ListView(
          children: [
            item(
              l10n(null, 'sign.avatar'),
              Avatar(uri: User.avatar(''), nick: User.nick(''), size: 32),
              0,
            ),
            Dividers.line,
            item(
              l10n(null, 'sign.nick'),
              Text(User.nick(l10n(null, 'sign.nick.empty'))),
              1,
            ),
            Dividers.line,
            gesture(),
            Dividers.line,
            item(
              l10n(null, 'sign.mobile'),
              Text(User.get('mobile', l10n(null, 'unset'))),
              2,
            ),
            Dividers.line,
            item(
              l10n(null, 'sign.email'),
              Text(User.get('email', l10n(null, 'unset'))),
              3,
            ),
            Dividers.line,
            item(
              l10n(null, 'sign.qr-code'),
              const Icon(Icons.qr_code_2),
              4,
            ),
            Dividers.line,
            const DestroyPassword(),
            Dividers.line,
            Destroy(),
            Dividers.line,
            button(
              l10n(null, 'sign.out'),
              () async {
                await User.signOut();
                if (User.anonymous) {
                  Navigator.pop(context);
                } else {
                  await PageRouter.push(const InUpPage());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );

  Widget item(String label, Widget value, int index) => ListTile(
        title: Row(
          children: [
            Expanded(child: Text(label)),
            value,
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          Widget? widget = page(index);
          if (widget != null) {
            dynamic back = await PageRouter.push(widget);
            if (back != null && back) setState(() {});
          }
        },
      );

  Widget? page(int index) {
    switch (index) {
      case 0:
        return PicturePage(
          title: l10n(null, 'sign.avatar.change'),
          upload: 'clivia.user.avatar',
          uri: User.avatar(''),
          ratio: 1,
          ok: (uri) async {
            await User.modify({'avatar': uri});
            setState(() {});
          },
        );
      case 1:
        return ChangePage(
          l10n(null, 'sign.nick.change'),
          Icons.face_retouching_natural,
          'nick',
          l10n(null, 'sign.nick.change.memo'),
        );
      case 2:
        return ChangePage(
          l10n(null, 'sign.mobile.change'),
          Icons.phone,
          'mobile',
          '',
        );
      case 3:
        return ChangePage(
          l10n(null, 'sign.email.change'),
          Icons.email,
          'email',
          '',
        );
      case 4:
        QrCode.show(
          'clivia:user:${User.code('')}',
          image: ExtendedNetworkImageProvider(
            Http.url(User.avatar('')),
            cache: true,
          ),
        );
        return null;
      default:
        return null;
    }
  }

  Widget gesture() => SwitchListTile(
        title: Text(l10n(null, 'sign.gesture')),
        value: User.gesture(),
        onChanged: (bool on) {
          PageRouter.push(
            PasswordPage(
              l10n(null, 'sign.gesture.${on ? 'on' : 'off'}'),
              'user.sign-in.gesture',
              twice: on,
              complete: (value) async {
                return await User.passwordOnOff(context, on, 'gesture', value, setState, l10n(null, 'sign.gesture.wrong'));
              },
            ),
          );
        },
      );

  Widget button(String label, void Function() tap) => Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(label),
            onPressed: tap,
          ),
        ),
      );
}
