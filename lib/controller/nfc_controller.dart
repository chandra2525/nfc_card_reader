import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcController extends GetxController {
  var result = ''.obs;
  var status = ''.obs;

  Future<bool> isNfcAvailable() async {
    return await NfcManager.instance.isAvailable();
  }

  // Method to read NFC tag
  void tagRead() {
    isNfcAvailable();
    status.value = "ada";
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data.toString();
      NfcManager.instance.stopSession();
    });
  }

  // // Method to write NDEF message to NFC tag
  // void ndefWrite() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null || !ndef.isWritable) {
  //       result.value = 'Tag is not NDEF writable';
  //       NfcManager.instance.stopSession(errorMessage: result.value);
  //       return;
  //     }

  //     NdefMessage message = NdefMessage([
  //       NdefRecord.createText('Hello World!'),
  //       NdefRecord.createUri(Uri.parse('https://flutter.dev')),
  //       NdefRecord.createMime(
  //           'text/plain', Uint8List.fromList('Hello'.codeUnits)),
  //       NdefRecord.createExternal(
  //           'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
  //     ]);

  //     try {
  //       await ndef.write(message);
  //       result.value = 'Success to "Ndef Write"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e.toString();
  //       NfcManager.instance.stopSession(errorMessage: result.value);
  //       return;
  //     }
  //   });
  // }

  // // Method to lock NDEF tag
  // void ndefWriteLock() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null) {
  //       result.value = 'Tag is not NDEF';
  //       NfcManager.instance.stopSession(errorMessage: result.value);
  //       return;
  //     }

  //     try {
  //       await ndef.writeLock();
  //       result.value = 'Success to "Ndef Write Lock"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e.toString();
  //       NfcManager.instance.stopSession(errorMessage: result.value);
  //       return;
  //     }
  //   });
  // }
}
