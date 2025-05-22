import 'package:project/helper/utils/generalImports.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, confirmLocationScreen, arguments: [
          Constant.session.getData(SessionManager.keyLatitude),
          Constant.session.getData(SessionManager.keyLongitude),
          "home_screen"
        ]);
      },
      child: ListTile(
        contentPadding: EdgeInsetsDirectional.zero,
        horizontalTitleGap: 0,
        leading: getDarkLightIcon(
          image: "home_map",
          height: 35,
          width: 35,
          padding: EdgeInsetsDirectional.only(
            top: Constant.size10,
            bottom: Constant.size10,
            end: Constant.size10,
          ),
        ),
        title: CustomTextLabel(
          jsonKey: "store_location",
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 15,
              color: ColorsRes.mainTextColor,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Constant.session.getData(SessionManager.keyAddress).isNotEmpty
            ? CustomTextLabel(
                text: Constant.session.getData(SessionManager.keyAddress),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              )
            : CustomTextLabel(
                jsonKey: "add_new_address",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              ),
      ),
    );
  }
}
