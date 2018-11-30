import 'dart:io';

import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';

const _SCOPES = const [StorageApi.DevstorageReadWriteScope];

const String credentialsJson = r'''
        {
          "private_key_id": "e62ab0f13178dbe78d5bdc4924788d7546c9289a",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC1tmek0RMZ0Wu+\noWaqx/CpAa+isyc4Bpc7ZlhPUuDXSJU8CLsFTqDK6WYwPJhtiYuuhlmq2FSegImb\nMc4xazQyEhFaIgIevPqnP18bbBG14Z1dpwsEh7LnLEBrbeU5A0rsrwmYAQ6S+my2\n+9oaOU3bVrmvfZxHhk+/5JGR7ZA8FWQBS8ikLiht+qx6MQtI+qutujAgQLVaPveb\n24r5F2wt3d7+71oigNGWuRxPczLjRIXMTBj330va0yk1ER6zZIfnvj5nXtodPaDU\nVacFv2zG/Cp4bt1HwnE2SsCVOJnVAoYyGCZaa/6X1u9xQrYhJxzOzR5FXqu+LRSL\nUb456YJJAgMBAAECggEAAMYZPkk03CKN+khmWp3LZHttuyMgES81SVeqyW3VjJtv\n3IsIniQB4fdUhQV15YA8CiJ+cKdU8DSAmqhkMXzuwoYvEOltoMah7SC6J95dW7qW\nicZLEQ62GDz2xcQPc7YmQMz0z0VHc/wID/Ps3UJU9qLj5KZfM05rB6GnCNUk9flk\nSwsHwwyswNwOaKTXISpu/PzruBfIN7utpNX+3ww4KL8m/FybZRnGEv+ycKcTozvO\nEbQQB9MwOOvsSwuuawYPceJsi08Rh5Pv3YfmLemYshqe7gSyz2T6lY4D8ZCnMfaz\nHQ0UOdEHC6n8hCzwcafeGErfyqda4xZjlFo8UmhWAQKBgQDgCPN17CkoKibt3eco\n3kMyrrgZzns8qtB3xUqLEv8y+dpFyA6A7FEpDj65J0h0uOw1VzXmFHhZSNOMFImF\ndTbX2ZWAIueNDLBzUZp37suGsq69rCFr9p8Vj5T79ZcQ7F+807jXwIPz4jcYKYZF\ns8txuQhN80f/qbhkNDftKLjASQKBgQDPo5gSb89TNqb2Mzq2K14DJl7R42+V7Pe6\nQHs4kOK3p1ZIkE8P5L0NXOeZM2NdF6zu4A6YzuxRUy38D3gOAbUpRHKM8nrjk1Nk\niydLXsVYqzKc8RJ8OPmTioLLrMslgdnNFg8emx2M1cw6hjuqiZsfg2ksakL9xQXK\ntANMW46yAQKBgDYak0kwLkRP4bTiORgKjSnpPfalgeeFzPCPyc/KV60k38yoYrBJ\n4dPLZ+RpEzt1CT5cgFy/Js1RJB2ZPBjp1MPN/SfDxi2vGdHPrEE4fxhZgI+3yR58\nobCgSzeJ+OCSZRCCBQq9qGA2il2gcZfVstUU/Wdt0D5y61/vqG3yvqNZAoGAEtaq\n43FVhB0/RLMdLo38t5hxneVeqGGZkEJta5Jpn3QFNgwxwCVmqaG2OYYaC8YsIHgf\nmumbMz2yvF3C7LJm91mIcxVE5QTm2gZuCD6O9R6DNw4AOVkJ+8LjXwtMWxjO4/aO\nZJ56Ld7v6pdnLm/RrShFEIyLi26mud9fNTxRVAECgYAyi/d6uSqDqG7YT8Ky/cOZ\nDzdHo60iSUGpfP5DdjWNMvIWRkNCGeVsOSXc2R4PewAjVxiGNQAozSMGyNxFzcf7\nlq0C49YcyCAR5nG8g9+7mVfvG10eKyoTCAL+ZoS0KnXGy6q5vgNDX5W24Zri6fjy\nzkP0xdbokMiyzrdHSn6EPg==\n-----END PRIVATE KEY-----\n",
          "client_email": "iam-challenge@challenge-api.iam.gserviceaccount.com",
          "client_id": "113918839792213968910",
          "type": "service_account"
        }
        ''';

void getStuff() {
  var credentials = new ServiceAccountCredentials.fromJson(credentialsJson);

  clientViaServiceAccount(credentials, _SCOPES).then((httpClient) {
    var storage = new StorageApi(httpClient);
    storage.buckets.list('challenge-api').then((buckets) {
      var bucketText = "Received ${buckets.items.length} bucket names:";
      print(bucketText);
      for (var file in buckets.items) {
        print(file.name);
      }
    });
  });
}

void uploadFile(File f) {
  var credentials = new ServiceAccountCredentials.fromJson(credentialsJson);

  clientViaServiceAccount(credentials, _SCOPES).then((httpClient) {
    var storage = new StorageApi(httpClient);
    var media = new Media(f.openRead(), f.lengthSync());
    return storage.objects.insert(null, "challenge-video-bucket", name: "hello.txt", uploadMedia: media);
  });
}
