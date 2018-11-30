
import 'dart:io';

import 'package:path_provider/path_provider.dart';

final deviceStorage = new DeviceStorage._private();

class DeviceStorage {
  DeviceStorage._private();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getLocalFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

}