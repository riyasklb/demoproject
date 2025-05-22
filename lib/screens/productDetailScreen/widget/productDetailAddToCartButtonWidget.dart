import 'package:project/helper/utils/generalImports.dart';

Widget ProductDetailAddToCartButtonWidget({
  required BuildContext context,
  required ProductData product,
  Color? bgColor,
  double? padding,
}) {
  return Container(
    width: double.infinity,
    color: bgColor,
    padding:
        EdgeInsetsDirectional.only(top: padding ?? 0, bottom: padding ?? 0),
    child: Padding(
      padding: EdgeInsetsDirectional.only(start:padding?? 0 ,end: padding ?? 0),
      child: Consumer<SelectedVariantItemProvider>(
          builder: (context, selectedVariantItemProvider, _) {
        return ProductCartButton(
          productId: product.id.toString(),
          productVariantId: product
              .variants[selectedVariantItemProvider.getSelectedIndex()].id
              .toString(),
          count: int.parse(product
                      .variants[
                          selectedVariantItemProvider.getSelectedIndex()]
                      .status) ==
                  0
              ? -1
              : int.parse(product
                  .variants[
                      selectedVariantItemProvider.getSelectedIndex()]
                  .cartCount),
          isUnlimitedStock: product.isUnlimitedStock == "1",
          maximumAllowedQuantity:
              double.parse(product.totalAllowedQuantity.toString()),
          availableStock: double.parse(product
              .variants[selectedVariantItemProvider.getSelectedIndex()]
              .stock),
          isGrid: false,
          sellerId: product.sellerId.toString(),
        );
      }),
    ),
  );
}
