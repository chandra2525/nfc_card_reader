// // nfc_bloc.dart
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:bloc/bloc.dart';
// import 'package:nfc_manager/nfc_manager.dart' as nfc;
// import 'nfc_event.dart';
// import 'nfc_state.dart';

// class NfcBloc extends Bloc<NfcEvent, NfcState> {
//   NfcBloc() : super(NfcInitial()) {
//     on<TagReadEvent>(_onTagRead);
//     on<NdefWriteEvent>(_onNdefWrite);
//     on<NdefWriteLockEvent>(_onNdefWriteLock);

//     // Handling internal events
//     on<TagReadCompleteEvent>(_onTagReadComplete);
//     on<NdefWriteCompleteEvent>(_onNdefWriteComplete);
//     on<NdefWriteErrorEvent>(_onNdefWriteError);
//     on<NdefWriteLockCompleteEvent>(_onNdefWriteLockComplete);
//     on<NdefWriteLockErrorEvent>(_onNdefWriteLockError);
//   }

//   Future<void> _onTagRead(TagReadEvent event, Emitter<NfcState> emit) async {
//     emit(NfcLoading());
//     try {
//       await nfc.NfcManager.instance.startSession(
//           onDiscovered: (nfc.NfcTag tag) async {
//         add(TagReadCompleteEvent());
//         nfc.NfcManager.instance.stopSession();
//       });
//     } catch (e) {
//       emit(NfcError(e.toString()));
//       nfc.NfcManager.instance.stopSession(errorMessage: e.toString());
//     }
//   }

//   Future<void> _onNdefWrite(
//       NdefWriteEvent event, Emitter<NfcState> emit) async {
//     emit(NfcLoading());
//     try {
//       await nfc.NfcManager.instance.startSession(
//           onDiscovered: (nfc.NfcTag tag) async {
//         var ndef = nfc.Ndef.from(tag);
//         if (ndef == null || !ndef.isWritable) {
//           add(NdefWriteErrorEvent());
//           nfc.NfcManager.instance
//               .stopSession(errorMessage: 'Tag is not ndef writable');
//           return;
//         }

//         nfc.NdefMessage message = nfc.NdefMessage([
//           nfc.NdefRecord.createText('Hello World!'),
//           nfc.NdefRecord.createUri(Uri.parse('https://flutter.dev')),
//           nfc.NdefRecord.createMime(
//               'text/plain', Uint8List.fromList('Hello'.codeUnits)),
//           nfc.NdefRecord.createExternal(
//               'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
//         ]);

//         try {
//           await ndef.write(message);
//           add(NdefWriteCompleteEvent());
//           nfc.NfcManager.instance.stopSession();
//         } catch (e) {
//           add(NdefWriteErrorEvent());
//           nfc.NfcManager.instance.stopSession(errorMessage: e.toString());
//         }
//       });
//     } catch (e) {
//       emit(NfcError(e.toString()));
//       nfc.NfcManager.instance.stopSession(errorMessage: e.toString());
//     }
//   }

//   Future<void> _onNdefWriteLock(
//       NdefWriteLockEvent event, Emitter<NfcState> emit) async {
//     emit(NfcLoading());
//     try {
//       await nfc.NfcManager.instance.startSession(
//           onDiscovered: (nfc.NfcTag tag) async {
//         var ndef = nfc.Ndef.from(tag);
//         if (ndef == null) {
//           add(NdefWriteLockErrorEvent());
//           nfc.NfcManager.instance.stopSession(errorMessage: 'Tag is not ndef');
//           return;
//         }

//         try {
//           await ndef.writeLock();
//           add(NdefWriteLockCompleteEvent());
//           nfc.NfcManager.instance.stopSession();
//         } catch (e) {
//           add(NdefWriteLockErrorEvent());
//           nfc.NfcManager.instance.stopSession(errorMessage: e.toString());
//         }
//       });
//     } catch (e) {
//       emit(NfcError(e.toString()));
//       nfc.NfcManager.instance.stopSession(errorMessage: e.toString());
//     }
//   }

//   // Handlers for internal events
//   void _onTagReadComplete(TagReadCompleteEvent event, Emitter<NfcState> emit) {
//     // emit(NfcSuccess(event.data));
//   }

//   void _onNdefWriteComplete(
//       NdefWriteCompleteEvent event, Emitter<NfcState> emit) {
//     // emit(NfcSuccess(event.message));
//   }

//   void _onNdefWriteError(NdefWriteErrorEvent event, Emitter<NfcState> emit) {
//     // emit(NfcError(event.errorMessage));
//   }

//   void _onNdefWriteLockComplete(
//       NdefWriteLockCompleteEvent event, Emitter<NfcState> emit) {
//     // emit(NfcSuccess(event.message));
//   }

//   void _onNdefWriteLockError(
//       NdefWriteLockErrorEvent event, Emitter<NfcState> emit) {
//     // emit(NfcError(event.errorMessage));
//   }
// }
