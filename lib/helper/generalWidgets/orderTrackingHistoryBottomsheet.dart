/*
      1 -> Payment pending
      2 -> Received
      3 -> Processed
      4 -> Shipped
      5 -> Out For Delivery
      6 -> Delivered
      7 -> Cancelled
      8 -> Returned
*/

import 'package:project/helper/utils/generalImports.dart';

class OrderTrackingHistoryBottomSheet extends StatelessWidget {
  final List<List> listOfStatus;

  const OrderTrackingHistoryBottomSheet(
      {super.key, required this.listOfStatus});

  @override
  Widget build(BuildContext context) {
    print("count is ----------------->" + listOfStatus.length.toString());
    return ListView(
      shrinkWrap: true,
      children: [
        getSizedBox(
          height: 20,
        ),
        Center(
          child: CustomTextLabel(
            jsonKey: "track_my_order",
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  TextStyle(
                    letterSpacing: 0.5,
                    color: ColorsRes.mainTextColor,
                  ),
                ),
          ),
        ),
        getSizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsetsDirectional.only(
              start: 10,
              end: 10,
              bottom: 10,
            ),
            child: OrderTrackerItemContainer(
              listOfStatus: listOfStatus,
            )),
      ],
    );
  }
}
