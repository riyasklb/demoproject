import 'package:project/helper/utils/generalImports.dart';

// class OrderTrackerItemContainer extends StatelessWidget {
//   final List<List> listOfStatus;
//   final int index;
//   final bool isLast;

//   const OrderTrackerItemContainer(
//       {super.key,
//       required this.index,
//       required this.isLast,
//       required this.listOfStatus});

//   @override
//   Widget build(BuildContext context) {
//     List statusImages = [
//       "status_icon_awaiting_payment",
//       "status_icon_received",
//       "status_icon_process",
//       "status_icon_shipped",
//       "status_icon_out_for_delivery",
//       "status_icon_delivered",
//       "status_icon_cancel",
//       "status_icon_returned",
//     ];

//     String currentImage = "";

// switch (Constant.getOrderActiveStatusLabelFromCode(
//         listOfStatus[index].first.toString(), context)
//     .toString()
//     .toLowerCase()) {
//   case "payment pending":
//     currentImage = statusImages[0];
//   case "received":
//     currentImage = statusImages[1];
//   case "processed":
//     currentImage = statusImages[2];
//   case "shipped":
//     currentImage = statusImages[3];
//   case "out for delivery":
//     currentImage = statusImages[4];
//   case "delivered":
//     currentImage = statusImages[5];
//   case "cancelled":
//     currentImage = statusImages[6];
//   case "returned":
//     currentImage = statusImages[7];
//   default:
//     "";
// }

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             CircleAvatar(
//               child: CircleAvatar(
//                 child: defaultImg(
//                   image: currentImage,
//                   height: 22,
//                   width: 22,
//                   iconColor: (listOfStatus.length > index)
//                       ? ColorsRes.appColorWhite
//                       : ColorsRes.subTitleMainTextColor,
//                 ),
//                 radius: 20,
//                 backgroundColor: (listOfStatus.length > index)
//                     ? ColorsRes.appColor
//                     : Theme.of(context).scaffoldBackgroundColor,
//               ),
//               radius: 24,
//               backgroundColor: (listOfStatus.length > index)
//                   ? ColorsRes.appColorDark
//                   : ColorsRes.lightGrey,
//             ),
//             if (!isLast)
//               Container(
//                 height: 50,
//                 width: 10,
//                 color: (!isLast)
//                     ? (listOfStatus.length > index + 1)
//                         ? ColorsRes.appColor
//                         : ColorsRes.lightGrey
//                     : Theme.of(context).primaryColor,
//               )
//           ],
//         ),
//         getSizedBox(width: 20),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: CustomTextLabel(
//               //Your order has been received on 13-06-2023 10:25 PM
//               text: (listOfStatus.length > index)
//                   ? "Your order has been ${Constant.getOrderActiveStatusLabelFromCode(listOfStatus[index].first.toString(), context)} on ${listOfStatus[index].last.toString().formatDate()}"
//                   : Constant.getOrderActiveStatusLabelFromCode(
//                       (index + listOfStatus.length + 1).toString(), context),
//               softWrap: true,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                 color: ColorsRes.mainTextColor,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class OrderTrackerItemContainer extends StatelessWidget {
//   final List<List> listOfStatus;

//   const OrderTrackerItemContainer({
//     super.key,
//     required this.listOfStatus,
//   });

//   @override
//   Widget build(BuildContext context) {
//     print('haiiiii---------------------> $listOfStatus');

//     List<String> allStatuses = [
//       "received",
//       "awaiting payment",
//       "processed",
//       "shipped",
//       "out for delivery",
//       "delivered",
//       "cancelled",
//       "returned"
//     ];

//     List<String> statusImages = [
//       "status_icon_received",
//       "status_icon_awaiting_payment",
//       "status_icon_process",
//       "status_icon_shipped",
//       "status_icon_out_for_delivery",
//       "status_icon_delivered",
//       "status_icon_cancel",
//       "status_icon_returned",
//     ];

//     // Build filteredStatusMap once outside the loop
//     final Map<String, String> filteredStatusMap = {
//       for (var status in listOfStatus)
//         Constant.getOrderActiveStatusLabelFromCode(
//                 status.first.toString(), context)
//             .toString()
//             .toLowerCase(): status.last.toString()
//     };

//     print(
//         'hello---------------------> $filteredStatusMap ${filteredStatusMap.length}');

// bool hasCancelled = filteredStatusMap.containsKey('cancelled');
// if (hasCancelled) {
//   print(allStatuses.length);
//   // Only show statuses that exist in listOfStatus
//   allStatuses = filteredStatusMap.keys.toList();
//   print(allStatuses.length);

//   // Map the statuses to corresponding status images
//   statusImages = allStatuses.map((status) {
//     switch (status) {
//       case "received":
//         return statusImages[0];
//       case "awaiting payment":
//         return statusImages[1];
//       case "processed":
//         return statusImages[2];
//       case "shipped":
//         return statusImages[3];
//       case "out for delivery":
//         return statusImages[4];
//       case "cancelled":
//         return statusImages[6];
//       default:
//         return ""; // You can also return a default image if needed
//     }
//   }).toList();

//   print(statusImages);
// }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(allStatuses.length, (i) {
//         if (((i == 1 && !filteredStatusMap.containsKey('awaiting payment')) ||
//             (i == 5 && filteredStatusMap.containsKey('cancelled')) ||
//             (i == 6 && !filteredStatusMap.containsKey('cancelled')) ||
//             (i == 7 && !filteredStatusMap.containsKey('returned')))) {
//           return SizedBox.shrink(); // Skip "payment pending"
//         }

//         String currentStatus = allStatuses[i];
//         bool isCompleted = filteredStatusMap.containsKey(currentStatus);
//         String currentImage = statusImages[i];
//         String? statusDate = filteredStatusMap[currentStatus];

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 CircleAvatar(
//                   child: CircleAvatar(
//                     child: defaultImg(
//                       image: currentImage,
//                       height: 22,
//                       width: 22,
//                       iconColor: isCompleted
//                           ? ColorsRes.appColorWhite
//                           : ColorsRes.subTitleMainTextColor,
//                     ),
//                     radius: 20,
//                     backgroundColor: isCompleted
//                         ? ColorsRes.appColor
//                         : Theme.of(context).scaffoldBackgroundColor,
//                   ),
//                   radius: 24,
//                   backgroundColor: isCompleted
//                       ? ColorsRes.appColorDark
//                       : ColorsRes.lightGrey,
//                 ),
//                 if (filteredStatusMap.containsKey('returned') ||
//                         filteredStatusMap.containsKey('cancelled')
//                     ? i != allStatuses.length - 2
//                     : i != allStatuses.length - 3)
//                   Container(
//                     height: 50,
//                     width: 10,
//                     color: (filteredStatusMap.containsKey(allStatuses[i + 1]) ||
//                             filteredStatusMap.containsKey(allStatuses[i + 2]))
//                         ? ColorsRes.appColor
//                         : ColorsRes.lightGrey,
//                   ),
//               ],
//             ),
//             getSizedBox(width: 20),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: CustomTextLabel(
//                   text: isCompleted
//                       ? i == 0
//                           ? "Your order is pending payment on ${statusDate!.formatDate()}"
//                           : "Your order has been ${currentStatus.capitalize()} on ${statusDate!.formatDate()}"
//                       : "Your order not yet ${currentStatus.capitalize()}",
//                   softWrap: true,
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                     color: isCompleted
//                         ? ColorsRes.mainTextColor
//                         : ColorsRes.subTitleMainTextColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => this[0].toUpperCase() + substring(1);
// }

class OrderTrackerItemContainer extends StatelessWidget {
  final List<List> listOfStatus;

  const OrderTrackerItemContainer({
    super.key,
    required this.listOfStatus,
  });

  @override
  Widget build(BuildContext context) {
    // Define all possible statuses in order
    final Map<String, String> allStatusesMap = {
      "placed": "status_icon_received",
      "awaiting payment": "status_icon_awaiting_payment",
      "confirmed": "status_icon_process",
      "packed": "status_icon_shipped",
      "out for delivery": "status_icon_out_for_delivery",
      "delivered": "status_icon_delivered",
      "cancelled": "status_icon_cancel",
      "returned": "status_icon_returned"
    };

    // Build filteredStatusMap
    final Map<String, String> filteredStatusMap = {
      for (var status in listOfStatus)
        Constant.getOrderActiveStatusLabelFromCode(
                status.first.toString(), context)
            .toString()
            .toLowerCase(): status.last.toString()
    };

    // Determine which statuses to display
    List<String> displayStatuses = [];
    List<String> displayStatusImages = [];

    // Check if cancelled is in the map
    bool hasCancelled = filteredStatusMap.containsKey('cancelled');

    if (hasCancelled) {
      // If cancelled, only show statuses present in filteredStatusMap
      allStatusesMap.forEach((status, image) {
        if (filteredStatusMap.containsKey(status)) {
          displayStatuses.add(status);
          displayStatusImages.add(image);
        }
      });
    } else {
      // If no cancellation, use all statuses and normal filtering logic
      displayStatuses = allStatusesMap.keys.toList();
      displayStatusImages = allStatusesMap.values.toList();
    }

    print(displayStatuses);
    print(displayStatusImages);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(displayStatuses.length, (i) {
        if (!hasCancelled
            ? ((i == 1 && !filteredStatusMap.containsKey('awaiting payment')) ||
                (i == 5 && filteredStatusMap.containsKey('cancelled')) ||
                (i == 6 && !filteredStatusMap.containsKey('cancelled')) ||
                (i == 7 && !filteredStatusMap.containsKey('returned')))
            : i == "") {
          return SizedBox.shrink(); // Skip "payment pending"
        }
        String currentStatus = displayStatuses[i];
        bool isCompleted = filteredStatusMap.containsKey(currentStatus);
        String currentImage = displayStatusImages[i];
        String? statusDate = filteredStatusMap[currentStatus];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  child: CircleAvatar(
                    child: defaultImg(
                      image: currentImage,
                      height: 22,
                      width: 22,
                      iconColor: isCompleted
                          ? ColorsRes.appColorWhite
                          : ColorsRes.subTitleMainTextColor,
                    ),
                    radius: 20,
                    backgroundColor: isCompleted
                        ? ColorsRes.appColor
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                  radius: 24,
                  backgroundColor: isCompleted
                      ? ColorsRes.appColorDark
                      : ColorsRes.lightGrey,
                ),
                if (filteredStatusMap.containsKey('returned') ||
                        filteredStatusMap.containsKey('cancelled')
                    ? i < displayStatuses.length - 1
                    : i < displayStatuses.length - 3)
                  Container(
                    height: 50,
                    width: 10,
                    color: (i + 1 < displayStatuses.length &&
                                filteredStatusMap
                                    .containsKey(displayStatuses[i + 1]) ||
                            filteredStatusMap
                                .containsKey(displayStatuses[i + 2]))
                        ? ColorsRes.appColor
                        : ColorsRes.lightGrey,
                  ),
              ],
            ),
            getSizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomTextLabel(
                  text: isCompleted
                      ? i == 1
                          ? "Your order is pending payment on ${statusDate!.formatDate()}"
                          : "Your order has been ${currentStatus.capitalize()} on ${statusDate!.formatDate()}"
                      : "Your order not yet ${currentStatus.capitalize()}",
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: isCompleted
                        ? ColorsRes.mainTextColor
                        : ColorsRes.subTitleMainTextColor,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
