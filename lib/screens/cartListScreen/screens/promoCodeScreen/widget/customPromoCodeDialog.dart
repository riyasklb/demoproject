import 'package:project/helper/utils/generalImports.dart';

class CustomPromoCodeDialog extends StatefulWidget {
  final String couponCode;
  final double couponAmount;

  const CustomPromoCodeDialog(
      {Key? key, required this.couponCode, required this.couponAmount})
      : super(key: key);

  @override
  State<CustomPromoCodeDialog> createState() => _CustomPromoCodeDialogState();
}

class _CustomPromoCodeDialogState extends State<CustomPromoCodeDialog> {
  @override
  void initState() {
    Timer(
        Duration(
            milliseconds:
                Constant.discountCouponDialogVisibilityTimeInMilliseconds), () {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      surfaceTintColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          defaultImg(
            image: "coupon",
            height: context.width * 0.3,
            width: context.width * 0.3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextLabel(
                text: "\"${widget.couponCode}\"",
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              getSizedBox(width: 10),
              CustomTextLabel(
                jsonKey: "coupon_applied",
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ColorsRes.mainTextColor,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          getSizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextLabel(
                jsonKey: "you_saved",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorsRes.mainTextColor,
                    fontWeight: FontWeight.w500),
                softWrap: true,
              ),
              getSizedBox(width: 10),
              CustomTextLabel(
                text: widget.couponAmount.toString().currency,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                softWrap: true,
              ),
            ],
          ),
          getSizedBox(height: 10),
          CustomTextLabel(
            jsonKey: "with_this_promo_code",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: ColorsRes.subTitleMainTextColor,
                fontWeight: FontWeight.normal),
            softWrap: true,
          ),
          getSizedBox(height: 10),
        ],
      ),
    );
  }
}
