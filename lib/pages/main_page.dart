import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_card_reader/controller/card_scanner_controller.dart';
import 'package:nfc_card_reader/controller/nfc_controller.dart';

class MainPage extends StatelessWidget {
  final NfcController nfcController = Get.put(NfcController());
  final CardScannerController cardController = Get.put(CardScannerController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  'NFC ReaderApp',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800, fontSize: 27),
                ),
              ),
              Expanded(
                child: FutureBuilder<bool>(
                  future: nfcController.isNfcAvailable(),
                  builder: (context, ss) {
                    return Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !ss.hasData || ss.data != true
                              ? Text(
                                  "Aktifkan NFC\nTerlebih dahulu",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                )
                              : Text(
                                  nfcController.status.value == ""
                                      ? 'Tekan tombol dibawah\nuntuk memulai'
                                      : 'Dekatkan kartu\npada smartphone',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.green.shade700),
                                ),
                          nfcController.result.value == ""
                              ? Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            31, 6, 147, 11),
                                        borderRadius:
                                            BorderRadius.circular(10000)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                43, 6, 147, 11),
                                            borderRadius:
                                                BorderRadius.circular(10000)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    110, 6, 147, 11),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10000)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Image.asset(
                                                'assets/images/scan_card1.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    constraints: const BoxConstraints.expand(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.green),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Obx(() => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            child: Text(
                                              nfcController.result.value,
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                  child: Text(
                    'Read NFC',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  onPressed: () {
                    nfcController.tagRead();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                  child: Text(
                    'Scan Card',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  onPressed: () {
                    nfcController.tagRead();
                    cardController.scanCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
