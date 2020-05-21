import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pdf/pdf.dart';

class CustomWebView extends StatefulWidget {
  String title = '';
  String path;
  bool isUrl;
  bool isAssets;
  bool isPrintable;
  bool isPdfFile;

  CustomWebView({@required this.title,
    @required this.path,
    this.isUrl = false,
    this.isAssets = false,
    this.isPrintable = false,
    this.isPdfFile = false});

  @override
  State<StatefulWidget> createState() {
    return CustomWebViewState(this.title, this.path, this.isUrl, this.isAssets,
        this.isPrintable, this.isPdfFile);
  }
}

class CustomWebViewState extends State<CustomWebView> {
  String mTitle;
  String mPath;
  bool mIsUrl;
  bool mAssets;
  bool mPrintable;
  bool mPdfFile;
  File generatedPdfFile;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  CustomWebViewState(this.mTitle, this.mPath, this.mIsUrl, this.mAssets,
      this.mPrintable, this.mPdfFile);

  @override
  void initState() {
    //  mPdfFile ? loadLocalPdf() : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadLocalHTML(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(backgroundColor: Colors.white,
              appBar: AppBar(
                  title: Text(mTitle),
                actions: <Widget>[
                  NavigationControls(_controller.future),
                ],),
              body: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: webView(snapshot.data),
                    ),
                    mPrintable
                        ? Container(
                      child: FlatButton(color: Colors.white,shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey)),
                        onPressed: () {
                          printView();
                        },
                        child: Text("Print"),
                      ),
                      color: Colors.white,
                    )
                        : Container()
                  ],
                ),
              ),
            );
          } else {
            return CustomProgress();
          }
        });
  }

  Future<String> loadLocalHTML() async {
    var htmlContent;
    if (mIsUrl) return mPath;
    htmlContent = mAssets ? await rootBundle.loadString('$mPath') : mPath;
   // await generatePdfFile(htmlContent);
    return htmlContent;
  }

  webView(String snapshot) {

    return WebView(
      initialUrl: mIsUrl != true
          ? Uri.dataFromString(
        snapshot ?? "No Data...",
        mimeType: 'text/html',
      ).toString()
          : mPath,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },

      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
    );

  }

  /*generatePdfFile(String htmlContent) async {
    generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, (await getTemporaryDirectory()).path, "bill");
  }

  void printView() async {
    var pdfBytes = await generatedPdfFile.readAsBytes();
    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  }*/

  void printView() async {

    var htmlContent = await loadLocalHTML();

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
          format: format,
          html: htmlContent,
        ));
  }

  pdfView(String data) {
    return PDFViewerScaffold(
        path: mPath,
        appBar: AppBar(
          centerTitle: true,
          title: Text(mTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.print),
              color: Colors.white,
              onPressed: () {
                printView();
              },
            )
          ],
        ));
  }


}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}
