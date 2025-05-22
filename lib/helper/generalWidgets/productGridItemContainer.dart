import 'package:project/helper/utils/generalImports.dart';

class ProductGridItemContainer extends StatefulWidget {
  final ProductListItem product;

  const ProductGridItemContainer({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductGridItemContainer> createState() => _State();
}

class _State extends State<ProductGridItemContainer> {
  late BuildContext context1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    ProductListItem product = widget.product;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          productDetailScreen,
          arguments: [
            product.id.toString(),
            product.name,
            product,
          ],
        );
      },
      child: ChangeNotifierProvider<SelectedVariantItemProvider>(
        create: (context) => SelectedVariantItemProvider(),
        child: product.variants!.length > 0
            ? Container(
                decoration: DesignConfig.boxDecoration(
                  Theme.of(context).cardColor,
                  8,
                  borderwidth: 1,
                  isboarder: true,
                  bordercolor: ColorsRes.subTitleMainTextColor.withOpacity(0.3),
                ),
                padding: EdgeInsetsDirectional.all(5),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Consumer<SelectedVariantItemProvider>(
                            builder:
                                (context, selectedVariantItemProvider, child) {
                              print(
                                  "product imageUrl : ${product.imageUrl.toString()}");
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorsRes.appColorWhite,
                                      borderRadius: Constant.borderRadius7,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: Constant.borderRadius7,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: setNetworkImg(
                                        boxFit: BoxFit.cover,
                                        image: product.imageUrl.toString(),
                                        height: double.maxFinite,
                                        width: double.maxFinite,
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
                                            image: "product_veg_indicator",
                                          ),
                                        if (product.indicator.toString() == "2")
                                          defaultImg(
                                            height: 24,
                                            width: 24,
                                            image: "product_non_veg_indicator",
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        getSizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 5),
                              child: CustomTextLabel(
                                text: product.name.toString(),
                                maxLines: 1,
                                softWrap: true,
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
                            ProductListRatingBuilderWidget(
                              averageRating: widget.product.averageRating
                                  .toString()
                                  .toDouble,
                              totalRatings:
                                  widget.product.ratingCount.toString().toInt,
                              size: 15,
                              spacing: 2,
                            ),
                            getSizedBox(
                              height: Constant.size10,
                            ),
                            if (product.variants!.isNotEmpty)
                              ProductVariantDropDownMenuGrid(
                                from: "",
                                product: product,
                                variants: product.variants,
                                isGrid: true,
                              ),
                          ],
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
                        start: 0,
                        top: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 7),
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
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
