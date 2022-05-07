import 'package:clivia_base/util/l10n.dart';
import 'package:flutter/material.dart';

class UploadLog extends StatelessWidget {
  const UploadLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n('me.upload-log')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              content: Text(l10n('me.upload-log.memo')),
              actions: <Widget>[
                TextButton(
                  child: Text(l10n('ok')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(l10n('cancel')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
}
