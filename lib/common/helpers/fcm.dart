// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

// class FCM {
//   setNotifications() {
//     getScreenshot();
//     FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
//     FirebaseMessaging.onMessage.listen(
//       (message) async {
//         print("AAA FIREBASE AAA");
//         print(message);
//         getScreenshot();
//       },
//     );
//   }
// }

// Future<void> onBackgroundMessage(RemoteMessage message) async {
//   print("BBB FIREBASE BBB");
//   print(message);
//   getScreenshot();
// }

// Future<void> getScreenshot() async {
//   FFmpegKit.execute(
//           '-i output.mkv -acodec libfdk_aac -ab 128k -ac 2 -vcodec libx264 -preset slow -crf 22 -threads 0 final_video.mp4')
//       .then((session) async {
//     final returnCode = await session.getReturnCode();
//     if (ReturnCode.isSuccess(returnCode)) {
//       print("FFMPEG BERHASIL ${returnCode}");
//       // SUCCESS
//     } else if (ReturnCode.isCancel(returnCode)) {
//       print("FFMPEG GAGAL ${returnCode}");
//       // CANCEL
//     } else {
//       print("FFMPEG ERROR ${returnCode}");
//       // print(await session.getAllLogsAsString());
//       print(await session.getOutput());
//       // ERROR
//     }
//   });
// }
