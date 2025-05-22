import 'package:project/helper/utils/generalImports.dart';
import 'package:badges/badges.dart' as badges;

class CartFloating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<CartListProvider>(
      builder: (context, cartListProvider, child) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, cartScreen);
          },
          child: badges.Badge(
            position: cartListProvider.cartList.length > 9
                ? badges.BadgePosition.topEnd(top: -10, end: -5)
                : badges.BadgePosition.topEnd(top: -14, end: -5),
            badgeStyle: badges.BadgeStyle(
              padding: EdgeInsets.all(
                  cartListProvider.cartList.length > 9 ? 5 : 7.8),
              // badgeColor: ColorsRes.appColorWhite,
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            badgeAnimation: badges.BadgeAnimation.scale(toAnimate: false),
            badgeContent: Text(
              "${cartListProvider.cartList.length}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorsRes.appColorWhite,
                  fontSize:
                      cartListProvider.cartList.length > 9 ? 12 : 14),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),
        );
      }
    );
  }
}
