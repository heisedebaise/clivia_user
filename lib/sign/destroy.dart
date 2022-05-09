import 'package:clivia_base/component/password.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/notice.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

import '../../user.dart';

class DestroyPassword extends StatefulWidget {
  const DestroyPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DestroyPasswordState();
}

class _DestroyPasswordState extends State<DestroyPassword> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(l10n(context, 'sign.destroy')),
        subtitle: Text(l10n(context, 'sign.destroy.memo')),
        value: User.destroy(),
        onChanged: (bool on) {
          PageRouter.push(
            PasswordPage(
              l10n(context, 'sign.destroy.${on ? 'on' : 'off'}'),
              'user.sign-in.destroy',
              twice: on,
              full: true,
              complete: (value) async {
                return await User.passwordOnOff(context, on, 'destroy', value, setState, l10n(context, 'sign.destroy.wrong'));
              },
            ),
          );
        },
      );
}

class Destroy extends StatelessWidget {
  Destroy({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'sign.destroy.account')),
        subtitle: Text(l10n(context, 'sign.destroy.account.memo')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n(context, 'sign.destroy.account')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n(context, 'sign.destroy.account.memo')),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: l10n(context, 'sign.destroy.password'),
                    ),
                    controller: _controller,
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(l10n(context, 'cancel'))),
                TextButton(
                    onPressed: () async {
                      dynamic data = await Http.service('/user/destroy', data: {'password': _controller.text});
                      if (data != null && !data) {
                        Notice.error(0, l10n(context, 'sign.password.wrong'));
                      }
                    },
                    child: Text(
                      l10n(context, 'ok'),
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )),
              ],
            ),
          );
        },
      );
}
