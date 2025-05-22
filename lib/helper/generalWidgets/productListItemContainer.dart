import 'package:project/helper/utils/generalImports.dart';

class ProductListItemContainer extends StatefulWidget {
  final ProductListItem product;

  const ProductListItemContainer({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductListItemContainer> createState() => _State();
}

class _State extends State<ProductListItemContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductListItem product = widget.product;
    List<Variants> variants = product.variants!;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          bottom: 5, start: 10, end: 10, top: 5),
      child: variants.length > 0
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, productDetailScreen,
                    arguments: [product.id.toString(), product.name, product]);
              },
              child: ChangeNotifierProvider<SelectedVariantItemProvider>(
                create: (context) => SelectedVariantItemProvider(),
                child: Container(
                  decoration: DesignConfig.boxDecoration(
                    Theme.of(context).cardColor,
                    8,
                    isboarder: true,
                    bordercolor:
                        ColorsRes.subTitleMainTextColor.withOpacity(0.3),
                    borderwidth: 1,
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<SelectedVariantItemProvider>(
                            builder:
                                (context, selectedVariantItemProvider, child) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 5),
                                    child: ClipRRect(
                                      borderRadius: Constant.borderRadius7,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: setNetworkImg(
                                        boxFit: BoxFit.cover,
                                        image: product.imageUrl.toString(),
                                        height: 115,
                                        width: 115,
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    bottom: 5,
                                    end: 5,
                                    child: Column(
                                      children: [
                                        if (product.indicator.toString() == "1")
                                          defaultImg(
                                              height: 24,
                                              width: 24,
                                              image: "product_veg_indicator"),
                                        if (product.indicator.toString() == "2")
                                          defaultImg(
                                              height: 24,
                                              width: 24,
                                              image:
                                                  "product_non_veg_indicator"),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getSizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(end: 30),
                                    child: CustomTextLabel(
                                      text: product.name.toString(),
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsRes.mainTextColor,
                                      ),
                                    ),
                                  ),
                                  getSizedBox(
                                    height: 5,
                                  ),
                                  ProductVariantDropDownMenuList(
                                    variants: variants,
                                    from: "",
                                    product: product,
                                    isGrid: false,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      PositionedDirectional(
                        end: 5,
                        top: 5,
                        child: ProductWishListIcon(
                          product: product,
                        ),
                      ),
                      PositionedDirectional(
                          start: 5,
                          top: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorsRes.appColorGreen,
                            ),
                            child: Text(
                              '${((1 - (product.variants![0].discountedPrice!.toDouble / product.variants![0].price!.toDouble)) * 100).round()}% OFF',
                              style: TextStyle(
                                  color: ColorsRes.appColorWhite, fontSize: 12),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
