import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomEmptyView.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loadmore/loadmore.dart';

class CustomListAndSearch<T> extends StatefulWidget {
  OnProcessListener onProcessListener;
  int limit;
  List<String> mFilterList;
  List<String> mFilterColumnList;

  CustomListAndSearch(
      {Key key,
      @required this.onProcessListener,
      this.limit = 50,
      this.mFilterList,
      this.mFilterColumnList})
      : super(key: key);

  @override
  TCustomListAndSearch createState() => new TCustomListAndSearch<T>(
      onProcessListener: onProcessListener,
      mFilterColumnList: mFilterColumnList,
      mFilterList: mFilterList,
      limit: limit);
}

class TCustomListAndSearch<T> extends State<CustomListAndSearch>
    implements SearchListener {
  OnProcessListener onProcessListener;
  String _filterColumn;
  String _filter;
  int _currentPage = 0;
  int limit;
  TextEditingController _tecSearch = TextEditingController();
  List<String> mFilterList;
  List<String> mFilterColumnList;
  List<T> data = List();
  bool isFirst = true;
  int viewHandler = 4;

  TCustomListAndSearch(
      {@required this.onProcessListener,
      this.limit = 50,
      this.mFilterList,
      this.mFilterColumnList});

  void initState() {
    super.initState();
    if (mFilterColumnList != null &&
        mFilterColumnList.length != 0 &&
        mFilterList != null &&
        mFilterList.length != 0) {
      _filterColumn = mFilterColumnList.elementAt(0);
      _filter = mFilterList.elementAt(0);
      CustomRadio.currentValue = 0;
    }
  }

  void notifiy(List<T> networkData, bool clearAndUpdate) {
    setState(() {
      _currentPage++;

      if (clearAndUpdate) {
        data.clear();
      }
      if (networkData != null) {
        data.addAll(networkData);
      }
    });
    if (data != null) {
      if (data.length == 0) {
        setState(() {
          viewHandler = 2;
        });
      } else {
        setState(() {
          viewHandler = 4;
        });
      }
    } else {
      setState(() {
        viewHandler = 3;
      });
    }
  }

  bool backSpaceVisible = false;

  Widget getSearch(BuildContext context) {
    return mFilterColumnList?.length == 0
        ? Container()
        : Container(
            height: 45.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.grey[300])),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      size: 20,
                    ),
                    onPressed: () {
                      _tecSearch.text = "";
                      onSearch();
                    }),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        maxLines: 1,
                        onChanged: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              backSpaceVisible = false;
                            });
                          } else {
                            setState(() {
                              backSpaceVisible = true;
                            });
                          }
                          onSearch();
                        },
                        controller: _tecSearch,
                        decoration: InputDecoration.collapsed(
                            hintText: "Search by " + _filter),
                      )),
                ),
                backSpaceVisible
                    ? IconButton(
                        icon: Icon(
                          FontAwesomeIcons.backspace,
                          size: 20,
                        ),
                        onPressed: () {
                          _tecSearch.text = "";
                          setState(() {
                            backSpaceVisible = false;
                          });
                          onSearch();
                        })
                    : Container(),
                mFilterColumnList?.length != 1
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.filter, size: 20),
                        onPressed: () {
                          showAlert(context);
                        })
                    : new Container(),
              ],
            ));
  }

  Widget getListWidget() {
    switch (viewHandler) {
      case 1:
        print("View Handle " + viewHandler.toString());
        return CustomProgress(
          title: "Load More",
          content: "Please wait !",
          isTitleRequired: false,
        );
      case 2:
        print("View Handle " + viewHandler.toString());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
          child: Container(
              alignment: Alignment.center,
              height: double.maxFinite,
              child: ListView(children: <Widget>[
                EmptyView(),],)
          ),
          onRefresh: onRefresh,
        ),);
      case 3:
        print("View Handle" + viewHandler.toString());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: CustomRetry(
            title: "Load More",
            retry: onRefresh,
            isTitleRequired: false,
          ),
        );
      case 4:
        print("View Handle" + viewHandler.toString());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
          child: LoadMore(
              isFinish: isFinished(),
              onLoadMore: isFirst ? onRefresh : onLoadMore,
              delegate: CustomDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return getItem(context, index);
                },
                itemCount: data == null ? 0 : data?.length,
              )),
          onRefresh: onRefresh,
        ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Created Once CustomListAndSearch");
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            getSearch(context),
            Expanded(child: getListWidget())
          ],
        ));
  }

  Widget listWidget;

  Widget getContainerWithText(String text) {
    return Center(
      child: Container(
        child: Text(text),
      ),
    );
  }

  bool isFinished() {
    print("Raghu : isFinished called");
    print("Raghu Current Page : " + _currentPage.toString());
    print("Raghu Limit : " + limit.toString());
    print("Raghu Current Page * Limit : " + (_currentPage * limit).toString());
    print("Raghu Data Length: " + data?.length.toString());
    print("Raghu isFinished : " +
        (data?.length != _currentPage * limit).toString());
    return data?.length != _currentPage * limit;
  }

  Future<bool> onLoadMore() async {
    print("Raghu : onLoadMore called");
    List<T> networkData = await callApi(
        _tecSearch.text.toString(),
        _filterColumn,
        true,
        _currentPage,
        limit,
        getSavedDate(data[data.length - 1]));
    if (networkData == null) {
      notifiy(null, true);
      return Future.value(false);
    } else {
      notifiy(networkData, false);
      return Future.value(true);
    }
  }

  void onSearch() async {
    print("Raghu : onSearch called");
    _currentPage = 0;
    List<T> networkData = await callApi(_tecSearch.text.toString(),
        _filterColumn, true, _currentPage, limit, null);
    notifiy(networkData, true);
  }

  Future<bool> onRefresh() async {
    print("Raghu : onRefresh called");
    print("Raghu : onRefresh isFirst : " + isFirst.toString());
    if (isFirst) {
      isFirst = false;
    }
    setState(() {
      viewHandler = 1;
    });
    print("Raghu : onRefresh isFirst : " + isFirst.toString());
    _currentPage = 0;
    _tecSearch.text = null;
    List<T> networkData = await callApi(
        _tecSearch.text, _filterColumn, true, _currentPage, limit, null);
    notifiy(networkData, true);
    return Future.value(networkData != null);
  }

  Widget getItem(BuildContext context, int index) {
    return onProcessListener.createView(context).setItem(data[index]);
  }

  Future<List<T>> callApi(String filter, String filterColumn, bool paging,
      int currentPage, int limit, String minDate) async {
    print("callApi Current Page :" + currentPage.toString());
    print("callApi filter :" + (filter == null ? "" : filter));
    print(
        "callApi filterColumn :" + (filterColumn == null ? "" : filterColumn));
    print("callApi minDate :" + (minDate == null ? "" : minDate));
    return await onProcessListener?.onProcessing(
        filter,
        (filterColumn == null || filterColumn.isEmpty ? "" : filterColumn),
        paging,
        currentPage,
        limit,
        minDate);
  }

  String getSavedDate(dynamic item) {
    return item == null ? null : onProcessListener?.getSavedDate(item);
  }

  void showAlert(BuildContext context) {
    CustomAlerts.showAlertWithRadioButton(context, mFilterList, this);
  }

  @override
  void onSelectAlert(int index) {
    _filterColumn = mFilterColumnList.elementAt(index);
    setState(() {
      _filter = mFilterList.elementAt(index);
    });
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class CustomDelegate extends LoadMoreDelegate {
  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    switch (status) {
      case LoadMoreStatus.idle:
        return Container();
      case LoadMoreStatus.loading:
        return loadingWidget();
      case LoadMoreStatus.fail:
        return Container(
          child: Text("Something went wrong !"),
        );
      case LoadMoreStatus.nomore:
        return Container();
    }
    return Container();
  }

  Widget loadingWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey)),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 33,
            height: 33,
            child: new CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Please Wait"),
          ),
        ],
      ),
    );
  }
}
