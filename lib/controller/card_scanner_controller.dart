import 'package:get/get.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:nfc_card_reader/controller/nfc_controller.dart';

class CardScannerController extends GetxController {
  final NfcController nfcController = Get.put(NfcController());

  Rx<CardDetails?> cardDetails = Rx<CardDetails?>(null);

  var scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  ).obs;

  Future<void> scanCard() async {
    final CardDetails? result =
        await CardScanner.scanCard(scanOptions: scanOptions.value);
    if (result != null) {
      nfcController.result.value = result.toString();
      cardDetails.value = result;
    }
  }

  void updateScanOptions(CardScanOptions options) {
    scanOptions.value = options;
  }
}
