import 'package:project/helper/utils/generalImports.dart';

class ProductWishListIcon extends StatelessWidget {
  final bool? isListing;
  final ProductListItem? product;

  const ProductWishListIcon({
    Key? key,
    this.isListing,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAddOrRemoveFavoriteProvider>(
      builder: (providerContext, value, child) {
        return GestureDetector(
          onTap: () async {
            if (Constant.session.isUserLoggedIn()) {
              Map<String, String> params = {};
              params[ApiAndParams.productId] = product?.id.toString() ?? "0";

              await providerContext
                  .read<ProductAddOrRemoveFavoriteProvider>()
                  .getProductAddOrRemoveFavorite(
                      params: params,
                      context: context,
                      productId: int.parse(product?.id ?? "0"))
                  .then((value) {
                if (value) {
                  context
                      .read<ProductWishListProvider>()
                      .addRemoveFavoriteProduct(context, product);
                }
              });
            } else {
              loginUserAccount(context, "wishlist");
            }
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: isListing == false
                ? BoxDecoration(color: Colors.transparent)
                : BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Constant.size7, horizontal: Constant.size7),
              child: (providerContext
                              .read<ProductAddOrRemoveFavoriteProvider>()
                              .productAddRemoveFavoriteState ==
                          ProductAddRemoveFavoriteState.loading &&
                      providerContext
                              .read<ProductAddOrRemoveFavoriteProvider>()
                              .stateId ==
                          (int.parse(product?.id ?? "0")))
                  ? getLoadingIndicator()
                  : getDarkLightIcon(
                      iconColor: Theme.of(context).primaryColor,
                      isActive: Constant.session.isUserLoggedIn()
                          ? providerContext
                              .read<ProductAddOrRemoveFavoriteProvider>()
                              .favoriteList
                              .contains(
                                  int.parse(product?.id.toString() ?? "0"))
                          : false,
                      image: "wishlist",
                    ),
            ),
          ),
        );
      },
    );
  }
}
