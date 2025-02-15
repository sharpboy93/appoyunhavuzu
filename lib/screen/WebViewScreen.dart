import 'dart:io';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/appWidget.dart';
import '../../utils/constant.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class WebViewScreen extends StatefulWidget {
  static String tag = '/WebViewScreen';
  final String? mInitialUrl;
  final bool isAdsLoad;
  final bool isAppBar;

  WebViewScreen({this.mInitialUrl, this.isAdsLoad = false, this.isAppBar = false});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  bool? isLoading = true;

  InAppWebViewSettings options = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    userAgent: "Mozilla/5.0 (Linux; Android 4.2.2; GT-I9505 Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.59 Mobile Safari/537.36",
    mediaPlaybackRequiresUserGesture: false,
    allowFileAccessFromFileURLs: true,
    useOnDownloadStart: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    transparentBackground: true,
    useHybridComposition: true,
    allowsInlineMediaPlayback: true,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    init();
  }

  init() async {
    log("URL" + widget.mInitialUrl!);
    if (widget.isAppBar == false) {
      // ignore: deprecated_member_use
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
    if (widget.isAdsLoad == true) {
      FacebookAudienceNetwork.init(testingId: FACEBOOK_KEY, iOSAdvertiserTrackingEnabled: true);
      if (mWebInterstitialAds == '1') {
        loadInterstitialAds();
      }
    }
    if (wishListStore.isNetworkAvailable) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    if (mAdShowCount < int.parse(adsInterval)) {
      mAdShowCount++;
    } else {
      mAdShowCount = 0;
      showInterstitialAds();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // ignore: deprecated_member_use
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget mBody() {
    return Observer(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          webViewController!.goBack();
          return true;
        },
        child: Stack(
          children: [
            wishListStore.isNetworkAvailable
                ? InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: WebUri(widget.mInitialUrl == null ? 'https://www.google.com' : widget.mInitialUrl!)),
                    initialSettings: options,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      log("onLoadStart");
                      setState(() {
                        isLoading = true;
                      });
                    },
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      var uri = navigationAction.request.url;
                      var url = navigationAction.request.url.toString();
                      log("URL" + url.toString());

                      if (Platform.isAndroid && url.contains("intent")) {
                        if (url.contains("maps")) {
                          var mNewURL = url.replaceAll("intent://", "https://");
                          if (await canLaunchUrl(Uri.parse(mNewURL))) {
                            await launchUrl(Uri.parse(mNewURL));
                            return NavigationActionPolicy.CANCEL;
                          }
                        } else {
                          String id = url.substring(url.indexOf('id%3D') + 5, url.indexOf('#Intent'));
                          await StoreRedirect.redirect(androidAppId: id);
                          return NavigationActionPolicy.CANCEL;
                        }
                      } else if (url.contains("linkedin.com") ||
                          url.contains("market://") ||
                          url.contains("whatsapp://") ||
                          url.contains("truecaller://") ||
                          url.contains("pinterest.com") ||
                          url.contains("snapchat.com") ||
                          url.contains("instagram.com") ||
                          url.contains("play.google.com") ||
                          url.contains("mailto:") ||
                          url.contains("tel:") ||
                          url.contains("share=telegram") ||
                          url.contains("messenger.com")) {
                        if (url.contains("https://api.whatsapp.com/send?phone=+")) {
                          url = url.replaceAll("https://api.whatsapp.com/send?phone=+", "https://api.whatsapp.com/send?phone=");
                        } else if (url.contains("whatsapp://send/?phone=%20")) {
                          url = url.replaceAll("whatsapp://send/?phone=%20", "whatsapp://send/?phone=");
                        }
                        if (!url.contains("whatsapp://")) {
                          url = Uri.encodeFull(url);
                        }
                        try {
                          if (await canLaunchUrl(Uri.parse(url))) {
                            launchUrl(Uri.parse(url));
                          } else {
                            launchUrl(Uri.parse(url));
                          }
                          return NavigationActionPolicy.CANCEL;
                        } catch (e) {
                          launchUrl(Uri.parse(url));
                          return NavigationActionPolicy.CANCEL;
                        }
                      } else if (!["http", "https", "chrome", "data", "javascript", "about"].contains(uri!.scheme)) {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                          return NavigationActionPolicy.CANCEL;
                        }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      log("onLoadStop");
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onReceivedError: (controller, request, error) {
                      log("onLoadError");
                      setState(() {
                        isLoading = false;
                      });
                    },
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(language.lblNoInternet, style: primaryTextStyle()),
                      ],
                    ),
                  ),
            mProgress().center().visible(isLoading!),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar == true
          ? appBarWidget("",
              showBack: true,
              color: primaryColor,
              backWidget: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white)))
          : PreferredSize(child: SizedBox(), preferredSize: Size.fromHeight(0)),
      body: mBody(),
      bottomNavigationBar: mWebBannerAds == '1' ? showBannerAds() : SizedBox(),
    );
  }
}
