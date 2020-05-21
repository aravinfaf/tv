import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/homebloc.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/binlistingview.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/dispatchlistingview.dart';
import 'package:tvs_visibility/src/visibility/ui/gateinout/gateview.dart';
import 'package:tvs_visibility/src/visibility/ui/loginview.dart';
import 'package:tvs_visibility/src/visibility/ui/picking/picklisting.dart';
import 'package:tvs_visibility/src/visibility/ui/pod/podlisting.dart';
import 'package:tvs_visibility/src/visibility/ui/preBinning/preBinningListView.dart';
import 'package:tvs_visibility/src/visibility/ui/singlebintobintransfer/singlebintobintransfer.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/orderdetailslisting/orderdetailslistingview.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/ui/singlebintobintransferview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberdetailsview/partnumberdetailsview.dart';

class HomeView extends StatefulWidget {
  List<DrawerItemModel> mDrawerItemModel = [];
  HomeViewState mHomeViewState;
  static int viewIndex = 0;

  HomeView();

  @override
  State<StatefulWidget> createState() {
    mHomeViewState = HomeViewState(mDrawerItemModel);
    return mHomeViewState;
  }
}

class HomeViewState extends State<HomeView> implements HomeListener {
  HomeBloc mHomeBloc;
  List<DrawerItemModel> mDrawerItemModel = [];
  var mDrawerWidgets = <Widget>[];
  List<String> mRoleType = [];
  String mUserName;

  HomeViewState(this.mDrawerItemModel) {
    var container = kiwi.Container();
    mHomeBloc = container<HomeBloc>();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    mHomeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mHomeBloc.getTitle,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('${snapshot.data}'),
                actions: <Widget>[logout()],
              ),
              drawer: Drawer(
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                  DrawerHeader(
                    child: UserAccountsDrawerHeader(
                      accountName: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${mUserName}',
                              style: TextStyle(fontSize: 18),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      accountEmail: null,
                      currentAccountPicture: CircleAvatar(
                        child: Text(
                          !Utility.isEmpty(mUserName)?'$mUserName'[0].toUpperCase():"",
                          style: TextStyle(fontSize: 25),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  new Column(
                    children: mDrawerWidgets,
                  )
                ]),
              ),
              body: Center(
                child: getDrawerItemWidget(
                    mDrawerItemModel.elementAt(HomeView.viewIndex)),
              ),
            );
          } else
            return CustomProgress();
        });
  }

  getDrawerItemWidget(DrawerItemModel model) {
    switch (model.mTitle) {
      case 'Gate In':
        return GateView();
      case 'POD':
        return PodListView();
      case 'Binning':
        return BinListingView();
      case 'Picking':
        return PickingList();
      case 'Dealer Binning':
        return OrderDetailsListingView();
      case 'Dealer Picking':
        return PostDespatchDetailsView();
      case 'Dealer Bin to Bin':
        return SingleBinToBinTransferView();
      case 'Single Bin Transfer':
          return SingleBinToBin();
      case 'Dispatch':
        return DispatchListingView();
      default:
        return PreBinningListView();
    }
  }

  initialize() {
    mHomeBloc.getActivityDetailsList(widget.mHomeViewState, HomeView.viewIndex);
  }

  setDataWidgets() {
    for (var i = 0; i < mDrawerItemModel.length; i++) {
      var title = mDrawerItemModel[i].mTitle;

      mDrawerWidgets.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('$title'),
            onTap: () {
              if(HomeView.viewIndex!=i)
                onSelectWidget(i);
              else
                Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          )
        ],
      ));
    }
  }

  onSelectWidget(int i) {
    HomeView.viewIndex = i;
    mHomeBloc.setTitle(mDrawerItemModel[i].mTitle);
    Navigator.pop(context);
  }

  logout() {
    return IconButton(
      icon: const Icon(Icons.power_settings_new),
      tooltip: 'Logout',
      onPressed: () {
        CustomAlerts.showAlertWithOkCancel(context,
            "Are you sure want to log out?", 'NO', 'YES', () {}, onUserLogout);
      },
    );
  }

  menuIcons() {
    return Container(
      child: Container(
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notification',
            onPressed: () {
              // TODO Notification
            },
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            tooltip: 'Logout',
            onPressed: () {
              CustomAlerts.showAlertWithOkCancel(
                  context,
                  "Are you sure want to log out?",
                  'NO',
                  'YES',
                  () {},
                  onUserLogout);
            },
          ),
        ]),
      ),
    );
  }

  onUserLogout() async {
    if (await mHomeBloc.userLogOut()) {
      HomeView.viewIndex = 0;
      NavigationUtils.pushReplacement(context, LoginView());
    } else
      CustomToast.showToast('Something went wrong!');
  }

  @override
  void onSetData(List<String> activityList, String userName) {
    mDrawerItemModel = [];
    mDrawerWidgets = [];
    for (int i = 0; i < activityList.length; i++) {
      mDrawerItemModel
          .add(DrawerItemModel(mTitle: activityList[i], mItemIndex: i));
    }
    mUserName = userName;
    setDataWidgets();
  }
}
