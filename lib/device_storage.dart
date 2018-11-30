
import 'dart:io';

import 'package:path_provider/path_provider.dart';

final deviceStorage = new DeviceStorage._private();

class DeviceStorage {
  DeviceStorage._private();

  Future<File> getLocalFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

}