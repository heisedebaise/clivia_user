import 'package:clivia_base/component/cachedimage.dart';
import 'package:clivia_base/component/popage.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

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
              String? path = await pickImage(ImageSource.gallery);
              if (path == null) return;

              await Http.upload('clivia.user.upload', file: path);
              number = 0;
              await load();
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
        body: Scrollable(
          viewportBuilder: (BuildContext context, ViewportOffset offset) => Wrap(
            children: list
                .map(
                  (upload) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedImage(
                        uri: upload['uri'],
                        height: 128,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: true, onChanged: (bool? check) {}),
                          Text(upload['filename']),
                        ],
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      );

  Future<void> load() async {
    Map<String, dynamic>? map = await Http.service('/user/upload/user', data: {'pageNum': number + 1});
    print(map);
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
