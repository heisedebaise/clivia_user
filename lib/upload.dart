import 'package:clivia_base/component/cachedimage.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/picker.dart';
import 'package:clivia_base/util/router.dart';
import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  final void Function(List<Upload> uploads) select;

  const FileUploadPage({Key? key, required this.select}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  List<dynamic> list = [];
  int page = 0;
  int number = 0;
  final Map<String, dynamic> map = {};
  final List<String> selects = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopPage(
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload_outlined),
            onPressed: () async {
              String? path = await pickImage();
              if (path == null) return;

              await Http.upload('clivia.user.upload', file: path);
              number = 0;
              list.clear();
              await load();
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (selects.isEmpty) return;

              List<Upload> list = [];
              for (String id in selects) {
                Map<String, dynamic> upload = map[id];
                list.add(Upload(contentType: upload['contentType'], filename: upload['filename'], uri: upload['uri'], time: upload['time']));
              }
              PageRouter.pop(list);
            },
          ),
        ],
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          children: [
            Wrap(children: list.map((upload) => image(upload)).toList()),
          ],
        ),
      );

  Widget image(Map<String, dynamic> upload) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              uri: upload['uri'],
              width: 256,
              height: 128,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                    value: selects.contains(upload['id']),
                    onChanged: (bool? check) {
                      String id = upload['id'] ?? '';
                      if (check == null || !check) {
                        map.remove(id);
                        selects.remove(id);
                      } else {
                        map[id] = upload;
                        selects.add(id);
                      }
                      setState(() {});
                    }),
                SizedBox(
                  width: 160,
                  child: Text(
                    upload['filename'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          String id = upload['id'] ?? '';
          if (selects.contains(id)) {
            map.remove(id);
            selects.remove(id);
          } else {
            map[id] = upload;
            selects.add(id);
          }
          setState(() {});
        },
      );

  Future<void> load() async {
    Map<String, dynamic>? map = await Http.service('/user/upload/user', data: {'pageNum': number + 1});
    if (map == null) return;

    page = map['page'] ?? 0;
    number = map['number'] ?? 0;
    list.addAll(map['list']);
    setState(() {});
  }
}

class Upload {
  final String contentType;
  final String filename;
  final String uri;
  final String time;

  const Upload({required this.contentType, required this.filename, required this.uri, required this.time});
}
