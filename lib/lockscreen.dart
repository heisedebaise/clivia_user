import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../user.dart';

const String _levelKey = 'settings.lock-screen.level';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(l10n(context, 'lock-screen')),
        value: User.screen(),
        onChanged: (bool on) async {
          PageRouter.push(
            PasswordPage(
              l10n(null, 'lock-screen.${on ? 'on' : 'off'}'),
              _levelKey,
              full: true,
              twice: on,
              complete: (value) async {
                return await User.passwordOnOff(context, on, 'screen', value, setState, l10n(null, 'lock-screen.wrong'));
              },
            ),
          );
        },
      );
}

class ScreenLocker {
  static bool _on = false;
  static bool _off = false;

  static void off(bool off) {
    _off = off;
  }

  static void show(BuildContext context) {
    if (_on || _off || !User.on() || !User.screen()) return;

    _on = true;
    PageRouter.push(
      PasswordPage(
        l10n(null, 'lock-screen.password'),
        _levelKey,
        popable: false,
        full: true,
        complete: (value) async {
          if (await User.passwordAuth('screen', value)) {
            _on = false;

            return Future.value(null);
          }

          return Future.value(l10n(null, 'lock-screen.wrong'));
        },
      ),
    );
  }
}
