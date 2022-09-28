import 'package:clivia_base/component/dialog.dart';
import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/notice.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class Password {
  static Future<bool?> valid(BuildContext context, String title) async {
    bool b = false;
    if (User.gesture()) {
      await PageRouter.push(
        PasswordPage(
          l10n(context, title),
          'user.sign-in.gesture',
          complete: (value) async {
            String? string = await User.signInGesture(value);
            if (string == null) {
              b = true;

              return Future.value(null);
            }

            return Future.value(string);
          },
        ),
      );

      return Future.value(b);
    }

    TextEditingController controller = TextEditingController();
    await Dialogs.confirm(
      context,
      title: Text(l10n(null, title)),
      content: TextField(
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
        ),
        controller: controller,
      ),
      ok: () async {
        String? message = await User.signInPassword(controller.text);
        if (message == null) {
          b = true;

          return Future.value(true);
        }

        Notice.error(0, message);

        return Future.value(false);
      },
    );

    return Future.value(b);
  }
}
