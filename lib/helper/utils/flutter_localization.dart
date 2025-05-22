// ignore_for_file: file_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/helper/utils/generalImports.dart';

import 'package:http/http.dart' as http;

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging? messagingInstance = FirebaseMessaging.instance;

  static LocalNotification? localNotification = LocalNotification();
  static StreamSubscription<RemoteMessage>? onMessageOpen;

  // For notification tapping in terminated state
  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'notification_channel_id', // id
    'Basic notifications', // title
    description: 'Notification channel', // description
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  // Initialize notifications plugin
  @pragma('vm:entry-point')
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap
        await handleNotificationTap(response.payload);
      },
    );

    // Create high importance channel for Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Handle notification tap
  @pragma('vm:entry-point')
  static Future<void> handleNotificationTap(String? payloadString) async {
    if (payloadString == null) return;

    try {
      final Map<String, dynamic> payload = jsonDecode(payloadString);
      String notificationTypeId = payload["id"].toString();
      String notificationType = payload["type"].toString();

      Future.delayed(
        Duration.zero,
        () {
          if (notificationType == "default" || notificationType == "user") {
            Navigator.pushNamed(
              Constant.navigatorKay.currentContext!,
              notificationListScreen,
            );
          } else if (notificationType == "category") {
            Navigator.pushNamed(
              Constant.navigatorKay.currentContext!,
              productListScreen,
              arguments: [
                "category",
                notificationTypeId.toString(),
                getTranslatedValue(
                    Constant.navigatorKay.currentContext!, "app_name")
              ],
            );
          } else if (notificationType == "product") {
            Navigator.pushNamed(
              Constant.navigatorKay.currentContext!,
              productDetailScreen,
              arguments: [
                notificationTypeId.toString(),
                getTranslatedValue(
                    Constant.navigatorKay.currentContext!, "app_name"),
                null
              ],
            );
          } else if (notificationType == "url") {
            launchUrl(
              Uri.parse(
                notificationTypeId.toString(),
              ),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }

  // Initialize the notification service
  Future<void> init(BuildContext context) async {
    if (messagingInstance != null && localNotification != null) {
      await disposeListeners();
      await requestPermission(context: context);
      messagingInstance = FirebaseMessaging.instance;
      localNotification = LocalNotification();

      await initializeLocalNotifications();
      await registerListeners(context);
    } else {
      await requestPermission(context: context);
      messagingInstance = FirebaseMessaging.instance;
      localNotification = LocalNotification();

      await initializeLocalNotifications();
      await registerListeners(context);
    }
  }

  // Create image notification
  @pragma('vm:entry-point')
  Future<void> createImageNotification({
    required RemoteMessage data,
    required bool isLocked,
  }) async {
    try {
      int currentCount =
          Constant.session.getIntData(SessionManager.notificationTotalCount);
      Constant.session
          .setIntData(SessionManager.notificationTotalCount, currentCount + 1);
      print(
          'new notification image value is -----------------> ${Constant.session.getIntData(SessionManager.notificationTotalCount)}');
      notificationCount.value = currentCount + 1;
      print('count is ------------> ${notificationCount.value}');

      // Convert data to JSON string for payload
      final String payloadData = jsonEncode(data.data);

      // Create the big picture style information
      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(
            await _getBase64Image(data.data["image"])),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            await _getBase64Image(data.data["image"])),
      );

      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(5000),
        data.data["title"],
        data.data["message"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            styleInformation: bigPictureStyleInformation,
            icon: '@drawable/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: payloadData,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }

  // Helper method to get base64 image from URL
  Future<String> _getBase64Image(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      return base64Encode(response.bodyBytes);
    } catch (e) {
      return "";
    }
  }

  // Create standard notification
  @pragma('vm:entry-point')
  Future<void> createNotification({
    required RemoteMessage data,
    required bool isLocked,
  }) async {
    try {
      print(
          '------------------------createNotification----------------------------');
      int currentCount =
          Constant.session.getIntData(SessionManager.notificationTotalCount);
      Constant.session
          .setIntData(SessionManager.notificationTotalCount, currentCount + 1);
      print(
          'new notification value is -----------------> ${Constant.session.getIntData(SessionManager.notificationTotalCount)}');
      notificationCount.value = currentCount + 1;
      print('count is ------------> ${notificationCount.value}');

      // Convert data to JSON string for payload
      final String payloadData = jsonEncode(data.data);

      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(5000),
        data.data["title"],
        data.data["message"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@drawable/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: payloadData,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }

  // Request notification permission
  @pragma('vm:entry-point')
  Future<void> requestPermission({required BuildContext context}) async {
    try {
      PermissionStatus notificationPermissionStatus =
          await Permission.notification.status;

      if (notificationPermissionStatus.isPermanentlyDenied) {
        if (!Constant.session.getBoolData(
            SessionManager.keyPermissionNotificationHidePromptPermanently)) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  PermissionHandlerBottomSheet(
                    titleJsonKey: "notification_permission_title",
                    messageJsonKey: "notification_permission_message",
                    sessionKeyForAskNeverShowAgain: SessionManager
                        .keyPermissionNotificationHidePromptPermanently,
                  ),
                ],
              );
            },
          );
        }
      } else if (notificationPermissionStatus.isDenied) {
        await messagingInstance?.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        Permission.notification.request();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }

  // Background message handler
  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessageHandler(RemoteMessage data) async {
    try {
      debugPrint("background notification handler invoked.");
      final prefs = await SharedPreferences.getInstance();
      Constant.session = SessionManager(prefs: prefs);

      if (Platform.isAndroid) {
        if (data.data["image"] == "" || data.data["image"] == null) {
          print(
              '------------------------onBackgroundMessageHandler-1-------------------------');
          localNotification?.createNotification(isLocked: false, data: data);
        } else {
          print(
              '------------------------onBackgroundMessageHandler-2-------------------------');
          localNotification?.createImageNotification(
              isLocked: false, data: data);
        }
      }
      return Future.value();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ISSUE ${e.toString()}");
      }
      return Future.value();
    }
  }

  // Foreground notification handler
  @pragma('vm:entry-point')
  static Future<void> foregroundNotificationHandler() async {
    try {
      onMessageOpen =
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("Foreground notification handler invoked.");

        if (Platform.isAndroid) {
          if (message.data["image"] == "" || message.data["image"] == null) {
            print(
                '------------------------foregroundNotificationHandler--------------------------');
            localNotification?.createNotification(
                isLocked: false, data: message);
          } else {
            localNotification?.createImageNotification(
                isLocked: false, data: message);
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ISSUE ${e.toString()}");
      }
    }
  }

  // Terminated state notification handler
  @pragma('vm:entry-point')
  static Future<void> terminatedStateNotificationHandler() async {
    messagingInstance?.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message == null) {
          return;
        }

        if (message.data["image"] == "" || message.data["image"] == null) {
          localNotification?.createNotification(isLocked: false, data: message);
        } else {
          localNotification?.createImageNotification(
              isLocked: false, data: message);
        }
      },
    );
  }

  // Register notification listeners
  @pragma('vm:entry-point')
  static Future<void> registerListeners(BuildContext context) async {
    try {
      print(
          '------------------------registerListeners------onBackgroundMessage------start--------------');
      // await messagingInstance!.setForegroundNotificationPresentationOptions(
      //   alert: false,
      //   badge: false,
      //   sound: false,
      // );
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
      print(
          '------------------------registerListeners-------onBackgroundMessage-----end--------------');

      await foregroundNotificationHandler();
      await terminatedStateNotificationHandler();
      print(
          '------------------------registerListeners------------end--------------');
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }

  // Dispose listeners
  @pragma('vm:entry-point')
  Future<void> disposeListeners() async {
    try {
      onMessageOpen?.cancel();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("ERROR IS ${e.toString()}");
      }
    }
  }
}
