import 'package:flutter_html/flutter_html.dart';
import 'package:project/helper/utils/generalImports.dart';

class WebViewScreen extends StatefulWidget {
  final String dataFor;

  const WebViewScreen({Key? key, required this.dataFor}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool privacyPolicyExpanded = false;
  bool returnExchangePolicyExpanded = false;
  bool shippingPolicyExpanded = false;
  bool cancellationPolicyExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    String htmlContent = "";
    if (widget.dataFor ==
        getTranslatedValue(
          context,
          "contact_us",
        )) {
      htmlContent = Constant.contactUs;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "about_us",
        )) {
      htmlContent = Constant.aboutUs;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "terms_and_conditions",
        )) {
      htmlContent = Constant.termsConditions;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "privacy_policy",
        )) {
      htmlContent = Constant.privacyPolicy;
    }

    return Scaffold(
      appBar: getAppBar(
          title: CustomTextLabel(
            text: widget.dataFor,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          context: context),
      body: SingleChildScrollView(
        child: widget.dataFor ==
                getTranslatedValue(
                  context,
                  "policies",
                )
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                      bottom: 10,
                      top: 10,
                    ),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      collapsedShape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      shape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      initiallyExpanded: privacyPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => privacyPolicyExpanded = expanded);
                      },
                      title: CustomTextLabel(
                        jsonKey: "privacy_policy",
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        privacyPolicyExpanded ? Icons.remove : Icons.add,
                        color: ColorsRes.mainTextColor,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: Constant.size5,
                          ),
                          child: _getHtmlContainer(
                              Constant.privacyPolicy, context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                      bottom: 10,
                    ),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      collapsedShape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      shape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      initiallyExpanded: returnExchangePolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => returnExchangePolicyExpanded = expanded);
                      },
                      title: CustomTextLabel(
                        jsonKey: "return_and_exchanges_policy",
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        returnExchangePolicyExpanded ? Icons.remove : Icons.add,
                        color: ColorsRes.mainTextColor,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: Constant.size5,
                          ),
                          child: _getHtmlContainer(
                              Constant.returnAndExchangesPolicy, context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                      bottom: 10,
                    ),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      collapsedShape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      shape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      initiallyExpanded: shippingPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => shippingPolicyExpanded = expanded);
                      },
                      title: CustomTextLabel(
                        jsonKey: "shopping_policy",
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        shippingPolicyExpanded ? Icons.remove : Icons.add,
                        color: ColorsRes.mainTextColor,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: Constant.size5,
                          ),
                          child: _getHtmlContainer(
                              Constant.shippingPolicy, context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                      bottom: 10,
                    ),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      collapsedShape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      shape: ShapeBorder.lerp(
                          InputBorder.none, InputBorder.none, 0),
                      initiallyExpanded: cancellationPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => cancellationPolicyExpanded = expanded);
                      },
                      title: CustomTextLabel(
                        jsonKey: "cancellation_policy",
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        cancellationPolicyExpanded ? Icons.remove : Icons.add,
                        color: ColorsRes.mainTextColor,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: Constant.size5,
                          ),
                          child: _getHtmlContainer(
                              Constant.cancellationPolicy, context),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(Constant.size10),
                child: _getHtmlContainer(htmlContent, context),
              ),
      ),
    );
  }

  String modifyHtmlForExternalLinks(String htmlContent) {
    return htmlContent.replaceAll(
        '<a ', '<a target="_blank" rel="noopener noreferrer" ');
  }

  Widget _getHtmlContainer(String htmlContent, BuildContext context) {
    print("htmlContent: $htmlContent");
    return Html(
      style: {
        "*": Style(
          color: ColorsRes.mainTextColor,
        ),
        "a": Style(
          color: Theme.of(context).primaryColor,
          textDecoration: TextDecoration.none,
        ),
      },
      data: modifyHtmlForExternalLinks(htmlContent),
      onLinkTap: (url, _, __) async {
        final Uri urllink = Uri.parse(url!);
        if (await canLaunchUrl(urllink)) {
          await launchUrl(urllink, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
